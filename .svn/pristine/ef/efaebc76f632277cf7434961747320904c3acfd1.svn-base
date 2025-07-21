package kr.or.ddit.ddtown.service.goods.cancel;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.admin.goods.order.IAdminOrdersMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.ddtown.mapper.orders.ICancelMapper;
import kr.or.ddit.ddtown.mapper.orders.IPaymentMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.order.OrderCancelVO;
import kr.or.ddit.vo.order.OrderDetailVO;
import kr.or.ddit.vo.order.OrdersVO;
import kr.or.ddit.vo.order.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CancelServiceImpl implements ICancelService {
	
	@Autowired
	private IAdminOrdersMapper adminOrdersMapper; //주문 상태 업뎃용
	
	@Autowired
	private IGoodsMapper goodsMapper; //재고 복구용
	
	@Autowired
	private ICancelMapper cancelMapper; //Cancel 테이블 기록용
	
	@Autowired
	private IPaymentMapper paymentMapper; //결제 상태 업데이트용
	
	/*
	 * @Autowired private IKakaoPayService kakaoPayService;
	 */
	
	@Override
    @Transactional
    public ServiceResult processAdminOrderCancel(OrdersVO order, String empUsername) {
        log.info("### CancelServiceImpl - processAdminOrderCancel 호출: orderId={}, empUsername={}", order.getOrderNo(), empUsername);

        try {
            // 1. ORDERS 테이블의 주문 상태를 '취소 완료'로 변경 (OSC008)
            OrdersVO updateOrderVO = new OrdersVO();
            updateOrderVO.setOrderNo(order.getOrderNo());
            updateOrderVO.setOrderStatCode("OSC008"); // 공통 코드 '취소 완료'

            int statusUpdateCount = adminOrdersMapper.updateOrder(updateOrderVO);
            if (statusUpdateCount <= 0) {
                log.error("주문(orderId={}) 상태 변경 실패. (ORDERS 테이블)", order.getOrderNo());
                throw new RuntimeException("주문 상태 변경 실패");
            }
            log.info("주문(orderId={}) 상태가 '취소 완료(OSC008)'로 변경되었습니다.", order.getOrderNo()); 

            // 2. 주문 상세 정보의 재고 복구 및 CANCEL 테이블 기록 
            if (order.getOrderDetailList() != null && !order.getOrderDetailList().isEmpty()) {
                for (OrderDetailVO detail : order.getOrderDetailList()) {
                    // 각 주문 상세 항목에 대해 재고 복구
                    log.info("### CancelServiceImpl - 재고 복구 시도: orderDetNo={}, goodsNo={}, goodsOptNo={}, orderDetQty={}",
                             detail.getOrderDetNo(), detail.getGoodsNo(), detail.getGoodsOptNo(), detail.getOrderDetQty());

                 // ★★★ 수정된 재고 복구 로직: increaseGoodsStock 하나로 통일 ★★★
                    // 옵션이 없는 경우 goodsOptNo에 0을 전달하여 SQL의 (GOODS_OPT_NO IS NULL) 조건에 일치시킵니다.
                    Integer goodsOptNoToUse = (detail.getGoodsOptNo() != null && detail.getGoodsOptNo() > 0) 
                                              ? detail.getGoodsOptNo() 
                                              : 0; // 옵션이 없으면 0을 전달

                    int updatedRows = goodsMapper.increaseGoodsStock(
                        detail.getGoodsNo(),
                        goodsOptNoToUse,
                        detail.getOrderDetQty() // orderDetQty가 SQL의 orderQty 파라미터로 매핑됩니다.
                    );

                    log.info("### CancelServiceImpl - increaseGoodsStock 호출 (재고 복구): 상품번호={}, 옵션번호={}, 수량={}, 결과={}",
                             detail.getGoodsNo(), goodsOptNoToUse, detail.getOrderDetQty(), updatedRows);
                    // ★★★ 수정된 재고 복구 로직 끝 ★★★


                    if (updatedRows == 0) {
                        log.error("상품(goodsNo={}, goodsOptNo={}) 재고 복구 실패. 주문 수량={}",
                                  detail.getGoodsNo(), detail.getGoodsOptNo(), detail.getOrderDetQty());
                        throw new RuntimeException("재고 복구 실패");
                    }

                    // 각 주문 상세 항목에 대해 CANCEL 테이블에 취소 기록 INSERT
                    OrderCancelVO cancelVO = new OrderCancelVO();
                    cancelVO.setOrderNo(order.getOrderNo());
                    cancelVO.setGoodsNo(detail.getGoodsNo()); 

                    cancelVO.setCancelType("CT003"); // 관리자 주문 취소
                    cancelVO.setCancelReasonCode("CRC001"); // 예시: 관리자 취소 (실제로는 프론트에서 넘어온 값 사용)
                    cancelVO.setCancelStatCode("CSC003"); // 취소 완료

                    cancelVO.setEmpUsername(empUsername);
                    cancelVO.setMemUsername(order.getCustomerId());
                    cancelVO.setCancelReasonDetail("관리자 직접 전체 취소 (PG사 미연동)"); 

                    // 현재 루프의 상품에 대한 취소 수량
                    cancelVO.setCancelItemQty(detail.getOrderDetQty());

                    long itemUnitPrice = 0; // 상품 1개당 단가

                    // 옵션이 선택된 경우 (goodsOptNo가 유효한 경우)
                    if (detail.getGoodsOptNo() != null && detail.getGoodsOptNo() > 0) {
                        itemUnitPrice = detail.getGoodsOptPrice(); // 옵션 단가 사용
                    } else {
                        itemUnitPrice = detail.getGoodsPrice(); // 상품 기본 단가 사용
                    }

                    // 최종 취소 금액은 단가 * 수량
                    int calculatedCancelPrice = (int) (itemUnitPrice * detail.getOrderDetQty());

                    cancelVO.setCancelReqPrice(calculatedCancelPrice); // 각 상품별 취소 요청 금액 (DB 기록용)
                    cancelVO.setCancelResPrice(calculatedCancelPrice); // 각 상품별 최종 처리 금액 (DB 기록용)

                    cancelVO.setCancelAccountNo(null); // 계좌 정보는 PG사 연동 시 필요
                    cancelVO.setCancelAccountHol(null); // 계좌 정보는 PG사 연동 시 필요

                    int cancelInsertCount = cancelMapper.insertCancel(cancelVO);
                    if (cancelInsertCount <= 0) {
                        log.error("CANCEL 테이블에 상품(goodsNo={}) 취소 기록 INSERT 실패. orderId={}", detail.getGoodsNo(), order.getOrderNo());
                        throw new RuntimeException("상품 취소 기록 생성 실패");
                    }
                    log.info("CANCEL 테이블에 주문(orderId={}) 상품(goodsNo={}) 취소 기록이 성공적으로 추가되었습니다.", order.getOrderNo(), detail.getGoodsNo());
                }
            } else {
                log.warn("### CancelServiceImpl - 주문(orderNo={}) 상세 정보가 없어 재고 복구 및 취소 기록 대상이 없습니다.", order.getOrderNo());
                // 이 경우, 전체 취소가 불가능하다고 판단할 수 있으므로, 예외를 던지는 것이 좋습니다.
                throw new RuntimeException("주문 상세 정보 없음. 재고 복구 및 취소 기록 불가.");
            }

            // 3. 결제 정보 조회 (PG사 연동이 없어도 payment 상태는 업데이트해야 하므로 유지)
            // PaymentVO payment = paymentMapper.selectPaymentByOrderNo(order.getOrderNo()); // 이 부분은 굳이 payment 정보가 필요 없으므로 삭제하거나 PaymentVO의 payMethodCode로 대체 가능
            
            // 4. PG사(카카오페이) API 호출 부분 완전 제거
            // 모든 결제 방법에 대해 Payment 테이블 상태만 '취소 완료'로 업데이트
            PaymentVO paymentStatusUpdate = new PaymentVO();
            paymentStatusUpdate.setOrderNo(order.getOrderNo()); 
            paymentStatusUpdate.setPaymentStatCode("PSC003"); // 결제 취소 완료 공통 코드
            int paymentStatusUpdateCount = paymentMapper.updatePaymentStatus(paymentStatusUpdate);
            if (paymentStatusUpdateCount <= 0) {
                log.error("결제(orderNo={}) 상태를 '취소 완료(PSC003)'로 업데이트 실패.", order.getOrderNo());
                throw new RuntimeException("결제 상태 업데이트 실패");
            }
            log.info("결제(orderNo={}) 상태가 '취소 완료(PSC003)'로 성공적으로 변경되었습니다. (PG사 미연동)", order.getOrderNo());
            
            return ServiceResult.OK;
            
        } catch (Exception e) {
            log.error("CancelServiceImpl에서 주문 취소 처리 중 예외 발생: {}", e.getMessage(), e);
            throw new RuntimeException("주문 취소 처리 중 오류 발생", e);
        }
    }

    /**
     * 검색 및 필터링 조건에 따라 취소/환불 내역을 조회합니다.
     * 이 메서드는 사용자가 검색 또는 필터링 조건을 입력했을 때 AJAX 요청으로 호출됩니다.
     * @param filterParams 검색 키워드(searchKeyword)와 상태 코드(statusCode)를 포함하는 Map
     * @return 필터링된 OrderCancelVO 목록
     */
    @Override
    public int getTotalCancelRefundCount(PaginationInfoVO<OrderCancelVO> pagingVO) {
        log.info("getTotalCancelRefundCount() 호출: 필터링 조건 - {}", pagingVO.getSearchMap());
        return cancelMapper.selectTotalCancelRefundCount(pagingVO);
    }

	@Override
	public OrderCancelVO selectCancelDetail(int cancelNo) {
		return cancelMapper.selectCancelDetail(cancelNo); // 매퍼 호출
	}

	@Override
	public int updateCancelRefund(OrderCancelVO orderCancelVO) {
        log.info("취소/환불 데이터 업데이트 서비스 호출: {}", orderCancelVO);
        return cancelMapper.updateCancelRefund(orderCancelVO);
	}

    @Override
    public List<OrderCancelVO> getFilteredCancelRefunds(PaginationInfoVO<OrderCancelVO> pagingVO) {
        log.info("getFilteredCancelRefunds() 호출: 필터링 조건 - {}", pagingVO.getSearchMap());
        // PaginationInfoVO 객체에는 이미 startRow와 endRow가 계산되어 있으므로, Mapper는 이 값들을 사용하면 됩니다.
        return cancelMapper.selectFilteredCancelRefunds(pagingVO);
    }
    
    // ⭐⭐⭐ 새로 추가할 메서드 구현 ⭐⭐⭐
    // IAdminGoodsCancelRefundService 인터페이스를 이 클래스가 구현하고 있다고 가정합니다.
    @Override
    public Map<String, Integer> getCancelRefundStatusCounts(Map<String, Object> searchMap) {
        // 매퍼에서 List<Map<String, Object>>를 가져옵니다.
        List<Map<String, Object>> rawCounts = cancelMapper.selectCancelRefundStatusCounts(); // 매퍼는 그대로 List 반환

        // List를 Map<String, Integer>로 변환
        Map<String, Integer> statusCountsMap = rawCounts.stream()
            .collect(Collectors.toMap(
                map -> (String) map.get("STATUS_CODE"), // 키: STATUS_CODE
                map -> ((Number) map.get("COUNT")).intValue() // 값: COUNT (Number를 Integer로 변환)
            ));
        
        // 데이터가 없는 상태 코드에 대해 0을 보장하고 싶다면, 미리 정의된 모든 상태 코드를 넣어줄 수 있습니다.
        // 예: 모든 취소 상태 코드를 가져와서 맵에 초기화 (선택 사항)
        // Map<String, Integer> finalStatusCounts = new HashMap<>();
        // finalStatusCounts.put("CSC001", statusCountsMap.getOrDefault("CSC001", 0));
        // finalStatusCounts.put("CSC002", statusCountsMap.getOrDefault("CSC002", 0));
        // finalStatusCounts.put("CSC003", statusCountsMap.getOrDefault("CSC003", 0));
        // return finalStatusCounts;
        
        return statusCountsMap; // 변환된 맵 반환
    }
    
    @Override
    public int getTotalCancelRefundCountIgnoreFilter() {
        log.info("getTotalCancelRefundCountIgnoreFilter 서비스 메서드 실행");
        int totalCount = cancelMapper.getTotalCancelRefundCountIgnoreFilter();
        log.info("조회된 전체 주문 취소/환불 건수 (필터 무시): {}", totalCount);
        return totalCount;
    }
    
    /**
     * 취소/환불 사유별 건수를 조회합니다.
     * @return Map<String, Long> key: 사유 코드(예: CRC001), value: 건수
     */
    public Map<String, Long> getCancelReasonCounts() {
        List<Map<String, Object>> rawData = cancelMapper.selectCancelReasonCounts();
        Map<String, Long> cancelReasonCounts = new LinkedHashMap<>(); // 순서 유지를 위해 LinkedHashMap

        for (Map<String, Object> row : rawData) {
            // ⭐ Mapper에서 정의한 ALIAS (대문자)와 일치해야 합니다.
            String reasonCode = (String) row.get("CANCELREASONCODE");
            Long reasonCount = ((Number) row.get("REASONCOUNT")).longValue();
            cancelReasonCounts.put(reasonCode, reasonCount);
        }
        log.info("### AdminOrderService - getCancelReasonCounts - Final Map: {}", cancelReasonCounts);
        return cancelReasonCounts;
    }

    /**
     * 일별 취소 요청 건수를 조회합니다.
     * @param searchMap 검색 조건 (orderDateStart, orderDateEnd 등)
     * @return Map<String, Long> key: 날짜(MM-dd), value: 건수
     */
    public Map<String, Long> getDailyCancelCounts(Map<String, Object> searchMap) {
        List<Map<String, Object>> rawData = cancelMapper.selectDailyCancelCounts(searchMap);
        Map<String, Long> dailyCancelCounts = new LinkedHashMap<>();
        
        // ⭐⭐⭐ 이 두 줄의 변수 선언과 아래 사용되는 모든 부분을 정확히 일치시켜야 합니다. ⭐⭐⭐
        // 'dbInputFormatter'와 'chartOutputFormatter'로 통일합니다.
        DateTimeFormatter dbInputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); 
        DateTimeFormatter chartOutputFormatter = DateTimeFormatter.ofPattern("MM-dd");
        // ⭐⭐⭐ 이 부분을 정확히 확인하고 수정하세요! ⭐⭐⭐

        // 날짜 범위 설정 (기본은 최근 7일)
        LocalDate endDate = LocalDate.now();
        LocalDate startDate = endDate.minusDays(6);

        // searchMap에 날짜 조건이 있다면 적용
        if (searchMap != null) { // && searchMap.get("orderDateStart") != null && !((String) searchMap.get("orderDateStart")).isEmpty()
            String startDateStr = (String) searchMap.get("orderDateStart");
            String endDateStr = (String) searchMap.get("orderDateEnd");

            if (startDateStr != null && !startDateStr.isEmpty()) {
                // ⭐⭐ 여기도 'dbInputFormatter'로 수정 ⭐⭐
                startDate = LocalDate.parse(startDateStr, dbInputFormatter);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                // ⭐⭐ 여기도 'dbInputFormatter'로 수정 ⭐⭐
                endDate = LocalDate.parse(endDateStr, dbInputFormatter);
            }
        }
        
        // 모든 날짜에 0으로 초기화
        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
            // ⭐⭐ 여기도 'chartOutputFormatter'로 수정 ⭐⭐
            dailyCancelCounts.put(date.format(chartOutputFormatter), 0L);
        }

        // DB에서 가져온 실제 데이터로 덮어쓰기
        for (Map<String, Object> row : rawData) {
            String cancelDateStr = (String) row.get("CANCELDATE");
            Long dailyCount = ((Number) row.get("DAILYCOUNT")).longValue();

            // ⭐⭐ 여기도 'dbInputFormatter'로 수정 ⭐⭐
            LocalDate dbDate = LocalDate.parse(cancelDateStr, dbInputFormatter);
            // ⭐⭐ 여기도 'chartOutputFormatter'로 수정 ⭐⭐
            dailyCancelCounts.put(dbDate.format(chartOutputFormatter), dailyCount);
        }
        log.info("### AdminOrderService - getDailyCancelCounts - Final Map: {}", dailyCancelCounts);
        return dailyCancelCounts;
    }
}
