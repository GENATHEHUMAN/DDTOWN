package kr.or.ddit.ddtown.mapper.orders;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.order.OrderCancelVO;

@Mapper
public interface ICancelMapper {
    /**
     * 새로운 주문 취소/환불 기록을 삽입합니다.
     * @param cancelVO 삽입할 OrderCancelVO 객체
     * @return 삽입된 행의 수
     */
    public int insertCancel(OrderCancelVO cancelVO);

    /**
     * 기존 주문 취소/환불 기록의 상태 및 최종 처리 정보를 업데이트합니다.
     * @param cancelVO 업데이트할 정보가 담긴 OrderCancelVO 객체 (cancelNo를 기준으로 업데이트)
     * @return 업데이트된 행의 수
     */
    public int updateCancelStatus(OrderCancelVO cancelVO);

    public List<OrderCancelVO> selectFilteredCancelRefunds(PaginationInfoVO<OrderCancelVO> pagingVO);
    
    public int selectTotalCancelRefundCount(PaginationInfoVO<OrderCancelVO> pagingVO);

	public OrderCancelVO selectCancelDetail(int cancelNo);
	
	/**
     * 취소/환불 상세 정보를 업데이트합니다.
     * @param orderCancelVO 업데이트할 정보가 담긴 OrderCancelVO 객체
     * @return 업데이트된 레코드 수
     */
	public int updateCancelRefund(OrderCancelVO orderCancelVO);
	
	public void insertOrderCancel(OrderCancelVO orderCancelVO);
	
    /**
     * 각 주문 취소/환불 상태별 개수를 조회합니다.
     * 모든 정의된 상태를 포함하며, 해당 상태의 주문이 없으면 개수는 0으로 반환됩니다.
     * @return 각 상태별 주문 개수를 담은 Map 리스트 (STATUS_CODE, STATUS_NAME, COUNT)
     */
    public List<Map<String, Object>> selectCancelRefundStatusCounts();

    /**
     * 전체 주문 취소/환불 건수를 조회합니다. (필터와 무관하게 모든 건수 대상)
     * @return 전체 주문 취소/환불 건수
     */
    public int getTotalCancelRefundCountIgnoreFilter();

	public List<Map<String, Object>> selectCancelReasonCounts();

	public List<Map<String, Object>> selectDailyCancelCounts(Map<String, Object> searchMap);
}
