package kr.or.ddit.ddtown.mapper.admin.goods.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.order.OrdersVO;

@Mapper
public interface IAdminOrdersMapper {

	public int getTotalOrdersCount(PaginationInfoVO<OrdersVO> pagingVO);

	public List<OrdersVO> getAllOrders(PaginationInfoVO<OrdersVO> pagingVO);

	public OrdersVO getOrderDetail(int orderNo);
	
	/**
     * 주문 정보를 업데이트합니다.
     * 주로 주문 상태(orderStatCode) 변경이나 관리자 메모(adminOrderMemo) 변경에 사용됩니다.
     * @param updateOrderVO 업데이트할 정보(orderId는 필수)가 담긴 OrdersVO 객체
     * @return 업데이트된 행의 수 (보통 1)
     */
	public int updateOrder(OrdersVO updateOrderVO);
	
	// ⭐ 새로 추가할 메서드 ⭐
    public List<OrdersVO> getOrdersWithDetailsForList(PaginationInfoVO<OrdersVO> pagingVO);

	public Map<String, Object> selectOrderStatusCounts(Map<String, Object> searchMap);

	/**
     * 일별 매출액 조회 쿼리 (특정 기간 또는 최근 N일)
     * @param searchMap 날짜 필터 (orderDateStart, orderDateEnd) 포함
     * @return 날짜(yyyy-MM-dd)와 매출액을 담은 List<Map<String, Object>>
     */
    List<Map<String, Object>> selectDailySales(Map<String, Object> searchMap);

    /**
     * 인기 상품 TOP N 조회 쿼리
     * @param searchMap limit 값 및 날짜 필터 (orderDateStart, orderDateEnd) 포함
     * @return 상품명과 판매 수량을 담은 List<Map<String, Object>>
     */
    List<Map<String, Object>> selectTopSellingGoods(Map<String, Object> searchMap);
}
