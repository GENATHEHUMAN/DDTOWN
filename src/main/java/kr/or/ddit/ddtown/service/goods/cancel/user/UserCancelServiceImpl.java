package kr.or.ddit.ddtown.service.goods.cancel.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.admin.goods.order.IAdminOrdersMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.ddtown.mapper.orders.ICancelMapper;
import kr.or.ddit.ddtown.mapper.orders.IPaymentMapper;
import kr.or.ddit.ddtown.service.goods.order.IOrderService;
import kr.or.ddit.ddtown.service.kakaopay.IKakaoPayService;
import kr.or.ddit.dto.kakaopay.CancelRequest;
import kr.or.ddit.dto.kakaopay.KakaoPayCancelResponseDTO;
import kr.or.ddit.vo.order.OrderCancelVO;
import kr.or.ddit.vo.order.OrderDetailVO;
import kr.or.ddit.vo.order.OrdersVO;
import kr.or.ddit.vo.order.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserCancelServiceImpl implements IUserCancelService {
	
	@Autowired
    private IAdminOrdersMapper adminOrdersMapper; // 주문(ORDERS) 상태 업데이트용 (OrdersVO와 OrderDetailList를 가져오는 기능도 필요할 수 있음)
    
    @Autowired
    private IGoodsMapper goodsMapper; // 재고 복구용
    
    @Autowired
    private ICancelMapper cancelMapper; // Cancel 테이블 기록용
    
    @Autowired
    private IPaymentMapper paymentMapper; // 결제(PAYMENT) 상태 업데이트용
    
    @Autowired
    private IKakaoPayService kakaoPayService; // 카카오페이 API 연동용
    
    @Autowired
    private IOrderService orderService;
	
	@Override
    @Transactional // 트랜잭션 처리
    public ServiceResult processUserOrderCancel(Integer orderNo, String cancelReasonCode, String cancelReasonDetail, String memUsername) {
        log.info("### OrderServiceImpl - processUserOrderCancel 호출: orderNo={}, memUsername={}", orderNo, memUsername);

        try {
            OrdersVO order = orderService.retrieveOrderDetail(orderNo); 
            PaymentVO payment = paymentMapper.selectPaymentByOrderNo(orderNo);

            if (order == null) {
                log.error("주문(orderNo={})을 찾을 수 없습니다.", orderNo);
                return ServiceResult.FAILED;
            }
            
            if (!order.getMemUsername().equals(memUsername)) {
                log.error("주문(orderNo={}) 취소 권한이 없습니다. 요청자: {}, 주문자: {}", orderNo, memUsername, order.getMemUsername());
                return ServiceResult.AUTH_ERROR; // 권한 없음 에러 코드
            }

            if (!"OSC001".equals(order.getOrderStatCode()) && !"OSC002".equals(order.getOrderStatCode())) {
                log.warn("주문(orderNo={})이 현재 상태({}, 결제상태: {})에서는 취소할 수 없습니다.",
                         orderNo, order.getOrderStatCode(), (payment != null ? payment.getPaymentStatCode() : "N/A"));
                return ServiceResult.FAILED; // 또는 특정 오류 코드 반환
            }

            OrdersVO updateOrderVO = new OrdersVO();
            updateOrderVO.setOrderNo(orderNo);
            updateOrderVO.setOrderStatCode("OSC008"); 

            int statusUpdateCount = adminOrdersMapper.updateOrder(updateOrderVO);
            if (statusUpdateCount <= 0) {
                log.error("주문(orderNo={}) 상태 변경 실패.", orderNo);
                throw new RuntimeException("주문 상태 변경 실패");
            }
            log.info("주문(orderNo={}) 상태가 '취소 완료(OSC003)'로 변경되었습니다.", orderNo);

            if (order.getOrderDetailList() != null && !order.getOrderDetailList().isEmpty()) {
                for (OrderDetailVO detail : order.getOrderDetailList()) {
                    
                    int updatedRows = goodsMapper.increaseGoodsStock(
                        detail.getGoodsNo(),
                        detail.getGoodsOptNo(),
                        detail.getOrderDetQty()
                    );
                    
                    log.info("### 디버그: 재고 복구 완료 후 CANCEL 테이블 INSERT 로직 진입 전.");

                    if (updatedRows == 0) {
                        log.error("상품(goodsNo={}, goodsOptNo={}) 재고 복구 실패. 주문 수량={}",
                                  detail.getGoodsNo(), detail.getGoodsOptNo(), detail.getOrderDetQty());
                        throw new RuntimeException("재고 복구 실패");
                    }
                    log.info("상품(goodsNo={}, goodsOptNo={}) 재고 {}개 복구 완료.", detail.getGoodsNo(), detail.getGoodsOptNo(), detail.getOrderDetQty());

                    OrderCancelVO cancelVO = new OrderCancelVO();
                    cancelVO.setOrderNo(orderNo);
                    cancelVO.setGoodsNo(detail.getGoodsNo());
                    cancelVO.setCancelType("CTC001"); 
                    cancelVO.setCancelReasonCode(cancelReasonCode); 
                    cancelVO.setCancelStatCode("CSC003"); 
                    cancelVO.setEmpUsername(null); 
                    cancelVO.setMemUsername(memUsername); 
                    cancelVO.setCancelReasonDetail(cancelReasonDetail);

                    long itemUnitPrice = 0; // 상품 1개당 단가

                    if (detail.getGoodsOptNo() != null && detail.getGoodsOptNo() > 0) {
                        itemUnitPrice = detail.getGoodsOptPrice(); // 옵션 단가 사용
                    } else {
                        itemUnitPrice = detail.getGoodsPrice(); // 상품 기본 단가 사용
                    }

                    int calculatedCancelPrice = (int) (itemUnitPrice * detail.getOrderDetQty());

                    cancelVO.setCancelReqPrice(calculatedCancelPrice); // 각 상품별 취소 요청 금액
                    cancelVO.setCancelResPrice(calculatedCancelPrice); // 각 상품별 최종 처리 금액
                    
                    cancelVO.setCancelItemQty(detail.getOrderDetQty()); // 취소 수량

                    int cancelInsertCount = cancelMapper.insertCancel(cancelVO);
                    if (cancelInsertCount <= 0) {
                        log.error("CANCEL 테이블에 상품(goodsNo={}) 취소 기록 INSERT 실패. orderNo={}", detail.getGoodsNo(), orderNo);
                        throw new RuntimeException("상품 취소 기록 생성 실패");
                    }
                    log.info("CANCEL 테이블에 주문(orderNo={}) 상품(goodsNo={}) 취소 기록이 성공적으로 추가되었습니다.", orderNo, detail.getGoodsNo());
                }
            } else {
                log.warn("### OrderServiceImpl - 주문(orderNo={}) 상세 정보가 없어 재고 복구 및 취소 기록 대상이 없습니다.", orderNo);
                throw new RuntimeException("주문 상세 정보 없음. 재고 복구 및 취소 기록 불가.");
            }

            if (payment != null && payment.getTid() != null && "카카오페이".equals(order.getOrderPayMethodNm())) {
                log.info("카카오페이 결제 취소 API 호출 시도: orderNo={}, tid={}, totalAmount={}",
                         orderNo, payment.getTid(), payment.getTotalAmount());

                CancelRequest cancelRequest = new CancelRequest();
                cancelRequest.setCid(payment.getCid() != null ? payment.getCid() : kakaoPayService.getCid()); // PaymentVO에서 cid 가져오기, 없으면 서비스에서 기본 cid 가져오기
                cancelRequest.setTid(payment.getTid());
                cancelRequest.setCancelAmount(payment.getTotalAmount()); // 전체 취소이므로 totalAmount를 그대로 사용
                cancelRequest.setCancelTaxFreeAmount(0); // 비과세 금액은 0으로 설정

                KakaoPayCancelResponseDTO cancelResponse = null;
                try {
                    cancelResponse = kakaoPayService.kakaoPayCancel(cancelRequest); // 수정된 메서드 호출
                } catch (Exception e) {
                    log.error("카카오페이 결제 취소 API 호출 중 예외 발생 (orderNo: {}): {}", orderNo, e.getMessage(), e);
                    throw new RuntimeException("카카오페이 결제 취소 API 호출 실패: " + e.getMessage(), e);
                }

                if (cancelResponse == null ||
                    (!"CANCELED".equals(cancelResponse.getStatus()) && !"PARTIAL_CANCELED".equals(cancelResponse.getStatus()))) {

                    String errorMessage = "카카오페이 취소 응답: " + (cancelResponse != null ? cancelResponse.getStatus() : "null response");
                    log.error("카카오페이 결제 취소 실패 (사용자 요청): orderNo={}, tid={}, 응답: {}", orderNo, payment.getTid(), cancelResponse);
                    throw new RuntimeException("카카오페이 결제 취소에 실패했습니다: " + errorMessage);
                }
                log.info("카카오페이 결제(orderNo={}) 성공적으로 취소되었습니다 (사용자 요청). 응답: {}", orderNo, cancelResponse);

                PaymentVO paymentStatusUpdate = new PaymentVO();
                paymentStatusUpdate.setOrderNo(orderNo);
                paymentStatusUpdate.setPaymentStatCode("PSC003"); // 결제 취소 완료 공통 코드
                int paymentStatusUpdateCount = paymentMapper.updatePaymentStatus(paymentStatusUpdate);
                if (paymentStatusUpdateCount <= 0) {
                    log.error("결제(orderNo={}) 상태를 '취소 완료(PSC003)'로 업데이트 실패.", orderNo);
                    throw new RuntimeException("결제 상태 업데이트 실패");
                }
                log.info("결제(orderNo={}) 상태가 '취소 완료(PSC003)'로 성공적으로 변경되었습니다.", orderNo);

            } else {
                log.info("주문(orderNo={})은 카카오페이 결제가 아니거나 유효한 TID 정보가 없어 PG사 취소 API를 호출하지 않습니다. (무통장 입금 등)", orderNo);

                PaymentVO paymentStatusUpdate = new PaymentVO();
                paymentStatusUpdate.setOrderNo(orderNo);
                paymentStatusUpdate.setPaymentStatCode("PSC003");
                int paymentStatusUpdateCount = paymentMapper.updatePaymentStatus(paymentStatusUpdate);
                if (paymentStatusUpdateCount <= 0) {
                    log.error("비 카카오페이 결제(orderNo={}) 상태를 '취소 완료(PSC003)'로 업데이트 실패.", orderNo);
                    throw new RuntimeException("결제 상태 업데이트 실패");
                }
                log.info("비 카카오페이 결제(orderNo={}) 상태가 '취소 완료(PSC003)'로 성공적으로 변경되었습니다.", orderNo);
            }

            return ServiceResult.OK;

        } catch (Exception e) {
            log.error("OrderServiceImpl에서 사용자 주문 취소 처리 중 예외 발생: {}", e.getMessage(), e);
            throw new RuntimeException("주문 취소 처리 중 오류 발생", e);
        }
    }

}
