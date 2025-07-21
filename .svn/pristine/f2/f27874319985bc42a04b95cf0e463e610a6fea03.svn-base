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
        	 // 0. 주문 정보와 결제 정보 조회 (OrderDetailList 포함)
            // 기존 OrderService의 retrieveOrderDetail 메서드를 호출합니다.
            OrdersVO order = orderService.retrieveOrderDetail(orderNo); // 이제 여기서는 orderService의 retrieveOrderDetail을 사용합니다.
            PaymentVO payment = paymentMapper.selectPaymentByOrderNo(orderNo); // PaymentVO는 별도로 조회

            if (order == null) {
                log.error("주문(orderNo={})을 찾을 수 없습니다.", orderNo);
                return ServiceResult.FAILED;
            }
            // 현재 로그인한 사용자와 주문자가 일치하는지 확인 (보안 강화)
            if (!order.getMemUsername().equals(memUsername)) {
                log.error("주문(orderNo={}) 취소 권한이 없습니다. 요청자: {}, 주문자: {}", orderNo, memUsername, order.getMemUsername());
                return ServiceResult.AUTH_ERROR; // 권한 없음 에러 코드
            }

            // 주문 상태 검증 (취소 가능한 상태인지 확인)
            // 예: "OSC001"(주문 완료), "OSC002"(결제 요청/대기) 상태에서만 취소 가능
            // "OSC004"(배송 중) 등은 취소 불가능하도록 설정
            if (!"OSC001".equals(order.getOrderStatCode()) && !"OSC002".equals(order.getOrderStatCode())) {
                log.warn("주문(orderNo={})이 현재 상태({}, 결제상태: {})에서는 취소할 수 없습니다.",
                         orderNo, order.getOrderStatCode(), (payment != null ? payment.getPaymentStatCode() : "N/A"));
                return ServiceResult.FAILED; // 또는 특정 오류 코드 반환
            }

            // 1. ORDERS 테이블의 주문 상태를 '취소 완료'로 변경 (사용자 취소 코드: 예시 OSC008)
            OrdersVO updateOrderVO = new OrdersVO();
            updateOrderVO.setOrderNo(orderNo);
            updateOrderVO.setOrderStatCode("OSC008"); // 사용자 취소 완료 공통 코드 (관리자와 다르게 설정)

            int statusUpdateCount = adminOrdersMapper.updateOrder(updateOrderVO);
            if (statusUpdateCount <= 0) {
                log.error("주문(orderNo={}) 상태 변경 실패.", orderNo);
                throw new RuntimeException("주문 상태 변경 실패");
            }
            log.info("주문(orderNo={}) 상태가 '취소 완료(OSC003)'로 변경되었습니다.", orderNo);

            // 2. 주문 상세 정보의 재고 복구 및 CANCEL 테이블 기록
            if (order.getOrderDetailList() != null && !order.getOrderDetailList().isEmpty()) {
                for (OrderDetailVO detail : order.getOrderDetailList()) {
                    // 각 주문 상세 항목에 대해 재고 복구
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

                    // 각 주문 상세 항목에 대해 CANCEL 테이블에 취소 기록 INSERT
                    OrderCancelVO cancelVO = new OrderCancelVO();
                    cancelVO.setOrderNo(orderNo);
                    cancelVO.setGoodsNo(detail.getGoodsNo());
                    cancelVO.setCancelType("CTC001"); // 사용자 주문 취소 (CT001: 고객 변심, CT002: 상품 품절 등)
                    cancelVO.setCancelReasonCode(cancelReasonCode); // 프론트에서 받은 사유 코드
                    cancelVO.setCancelStatCode("CSC003"); // 취소 처리 완료
                    cancelVO.setEmpUsername(null); // 사용자가 취소했으므로 직원 ID는 NULL
                    cancelVO.setMemUsername(memUsername); // 현재 로그인한 회원 ID
                    cancelVO.setCancelReasonDetail(cancelReasonDetail); // 프론트에서 받은 상세 사유

                 // 각 상품별 실제 취소 금액 계산 (사용자 정의 가격 정책 반영)
                    long itemUnitPrice = 0; // 상품 1개당 단가

                    // 옵션이 선택된 경우 (goodsOptNo가 유효한 경우)
                    if (detail.getGoodsOptNo() != null && detail.getGoodsOptNo() > 0) {
                        itemUnitPrice = detail.getGoodsOptPrice(); // 옵션 단가 사용
                    } else {
                        itemUnitPrice = detail.getGoodsPrice(); // 상품 기본 단가 사용
                    }

                    // 최종 취소 금액은 단가 * 수량
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

         // 3. PG사(카카오페이) API를 통한 결제 취소 요청
            if (payment != null && payment.getTid() != null && "카카오페이".equals(order.getOrderPayMethodNm())) {
                log.info("카카오페이 결제 취소 API 호출 시도: orderNo={}, tid={}, totalAmount={}",
                         orderNo, payment.getTid(), payment.getTotalAmount());

                // **** 이 부분을 수정해야 합니다 ****
                // 기존: Map<String, Object> kakaoCancelResult = null;
                // 기존: try { kakaoCancelResult = kakaoPayService.kakaoPayCancel(payment.getTid(), payment.getTotalAmount()); }

                // 1. CancelRequest 객체 생성
                // tid, cancelAmount, cid, cancelTaxFreeAmount 필요
                // cid는 kakaoPayService에서 가져올 수 있습니다.
                // cancelTaxFreeAmount는 0으로 고정하는 경우가 많습니다.
                // PaymentVO에서 cid를 가지고 있다면 PaymentVO.getCid()를 사용해도 됩니다. (현재 PaymentVO에 cid 필드 있음)
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

                // 카카오페이 취소 응답 확인 및 처리
                // 기존 Map으로 반환되던 것을 DTO 객체로 변경되었으므로 DTO 필드를 활용하여 검증
                if (cancelResponse == null ||
                    (!"CANCELED".equals(cancelResponse.getStatus()) && !"PARTIAL_CANCELED".equals(cancelResponse.getStatus()))) {

                    // DTO에서 에러 메시지를 직접 제공하지 않을 수 있으므로, 응답 전체를 로그에 남기는 것이 좋습니다.
                    String errorMessage = "카카오페이 취소 응답: " + (cancelResponse != null ? cancelResponse.getStatus() : "null response");
                    log.error("카카오페이 결제 취소 실패 (사용자 요청): orderNo={}, tid={}, 응답: {}", orderNo, payment.getTid(), cancelResponse);
                    throw new RuntimeException("카카오페이 결제 취소에 실패했습니다: " + errorMessage);
                }
                log.info("카카오페이 결제(orderNo={}) 성공적으로 취소되었습니다 (사용자 요청). 응답: {}", orderNo, cancelResponse);

                // PG사 취소 성공 시 Payment 테이블의 상태 업데이트 (PSC003: 결제 취소 완료)
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

                // 카카오페이 결제가 아니어도 payment 상태는 '취소 완료'로 업데이트 (무통장 입금 등 DB만 처리)
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
            // 트랜잭션 롤백을 위해 RuntimeException을 던집니다.
            throw new RuntimeException("주문 취소 처리 중 오류 발생", e);
        }
    }

}
