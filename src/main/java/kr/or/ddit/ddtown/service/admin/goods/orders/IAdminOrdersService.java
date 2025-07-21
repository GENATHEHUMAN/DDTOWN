package kr.or.ddit.ddtown.service.admin.goods.orders;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.order.OrdersVO;

public interface IAdminOrdersService {
	/**
	 * 전체 주문 내역 총 개수 조회
	 * @param pagingVO
	 * @return 조건에 맞는 주문 내역의 총 개수
	 */
	public int getTotalOrdersCount(PaginationInfoVO<OrdersVO> pagingVO);

	/**
	 * 현재 페이지 해당 주문 내역 목록 조회
	 * @param pagingVO
	 * @return 조회된 주문 객체 리스트
	 */
	public List<OrdersVO> getAllOrders(PaginationInfoVO<OrdersVO> pagingVO);
	
	/**
	 * 
	 * @param orderId 조회할 주문의 고유 ID
	 * @return 조회된 주문의 상세 정보가 담긴 객체
	 * 해당 주문 없을 경우 null 반환
	 */
	public OrdersVO getOrderDetail(int orderNo);

	public ServiceResult cancelOrder(int orderNo, String empUsername);

	public int updateOrderStatusAndMemo(OrdersVO orderVO);

	public Map<String, Object> getOrderStatusCounts(Map<String, Object> searchMap);

	public Map<String, Long> getDailySales(Map<String, Object> searchMap);

	public List<Map<String, Object>> getTopSellingGoods(int i, Map<String, Object> searchMap);

}
