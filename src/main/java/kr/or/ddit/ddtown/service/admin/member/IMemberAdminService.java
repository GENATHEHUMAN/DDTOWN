package kr.or.ddit.ddtown.service.admin.member;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.member.MemCodeListVO;
import kr.or.ddit.vo.member.MemberAdminVO;
import kr.or.ddit.vo.order.OrderCancelVO;
import kr.or.ddit.vo.order.OrdersVO;

public interface IMemberAdminService {

	public List<MemberAdminVO> getMemberList();

	public MemberAdminVO getMember(String memUsername);

	public List<MemCodeListVO> getCodeList();

	public ServiceResult updateMember(MemberAdminVO memberVO);

	public ServiceResult deleteMember(String memUsername);

	public int getTotalRecord(PaginationInfoVO<MemberAdminVO> pagingVO, String searchCode);

	public List<MemberAdminVO> getDataList(PaginationInfoVO<MemberAdminVO> pagingVO, String searchCode);

	/**
	 * 오늘 신규가입수 불러오기
	 * @return
	 */
	public int getTodayRegisterUser();

	// 총 멤버수 가져오기
	public int getTotalMemCnt();

	// 정상 회원 수 가져오기
	public int getGeneralMemCnt();

	// 탈퇴 회원 수 가져오기
	public int getOutMemCnt();

	// 블랙리스트 회원 수 가져오기
	public int getBlackMemCnt();

	// 팔로우 중인 커뮤니티 정보 가져오기
	public List<MemberAdminVO> joinComuList(String memUsername);

	// 차트에 뿌려줄 게시글, 댓글 수 
	public List<Map<Object, Object>> cntChartData(MemberAdminVO memberAdminVO);

	// 회원이 가입한 멤버십
	public List<Map<Object, Object>> membershipList(String memUsername);

	// 회원이 주문한 상품목록 가져오기
	public List<OrdersVO> orderVOList(String memUsername);

	// 상품관련 통계 수치
	public List<Map<Object, Object>> orderCntList(String memUsername);

	// 선택한 차트의 판매 차트인 경우 주문내역 가져오기
	public List<OrdersVO> selectOrderList(PaginationInfoVO<OrdersVO> pagingVO);

	// 선택한 차트의 판매 차트인 경우 총 개수 가져오기
	public int orderListTotalRecord(PaginationInfoVO<OrdersVO> pagingVO);

	// 선택한 차트가 취소 차트인 경우 취소 내역 가져오기
	public List<OrderCancelVO> cancelOrderList(PaginationInfoVO<OrdersVO> pagingVO);

	// 선택한 취소 내역의 길이 가져오기
	public int cancelListTotalRecord(PaginationInfoVO<OrdersVO> pagingVO);

}
