package kr.or.ddit.ddtown.service.member.membership;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.member.membership.MembershipDescriptionVO;
import kr.or.ddit.vo.member.membership.MembershipSubscriptionsVO;

public interface IMembershipService {
	
	// 멤버십 구독 여부 확인
    boolean hasValidMembershipSubscription(String memUsername, int artGroupNo);

    // 총 레코드 수 ( sub )
	int selectTotalRecord(PaginationInfoVO<MembershipSubscriptionsVO> pagingVO, String empUsername, String mbspSubStatCode);

	// 총 레코드 수 ( des )
	int selectTotalDesRecord(PaginationInfoVO<MembershipDescriptionVO> pagingVO);
	
	// 멤버십 구독자 리스트 목록 조회 ( sub )
	List<MembershipSubscriptionsVO> selectMembershipSubList(
			PaginationInfoVO<MembershipSubscriptionsVO> pagingVO, String empUsername, String mbspSubStatCode);

	// 멤버십 구독자 리스트 목록 조회 ( des )
	List<MembershipDescriptionVO> selectMembershipDesList(PaginationInfoVO<MembershipDescriptionVO> pagingVO, String empUsername);

	// 아티스트 그룹 목록 전체 조회
	List<ArtistGroupVO> getArtistGroupListAll();

	// 플랜 등록
	Map<String, Object> registerMembershipDes(MembershipDescriptionVO desVO, String logEmpUsername);

	// 플랜 수정
	Map<String, Object> modifyMembershipDes(MembershipDescriptionVO desVO, String logEmpUsername);

	// 플랜 삭제
	ServiceResult deleteMembershipDes(int mbspNo, String currentEmpUsername);

	// 멤버십 생성
	void insertMembershipSub(MembershipSubscriptionsVO subscription);
	
	// 담당 아티스트 그룹 번호 조회
	int selectArtGroupNo(String empUsername);
	
	// 멤버십 구독 건수 조회
	Map<String, Integer> selectMembershipSubCounts(Integer artGroupNo);

	// 사용자의 멤버십 구독 리스트 조회
	List<MembershipSubscriptionsVO> getMyMembershipList(PaginationInfoVO<MembershipSubscriptionsVO> pagingVO);

	// 사용자 멤버십 토탈 레코드 수
	int getMySubTotalRecord(PaginationInfoVO<MembershipSubscriptionsVO> pagingVO);

	int getMbspNo(int artGroupNo);

	/**
	 * 그룹번호로 구독플랜가져오기
	 * @param artGroupNo
	 * @return
	 */
	MembershipDescriptionVO getMembershipInfo(int artGroupNo);

	/**
	 * 가장 많은 구매를 한 사용자 top3
	 * @param artGroupNo 
	 * @return
	 */
	List<MembershipSubscriptionsVO> getTopPayingUsers(int artGroupNo);

	/**
	 * 이번 달 멤버십 가입자 수
	 * @return
	 */
	List<MembershipSubscriptionsVO> getMonthlySignups();

	/**
	 * 통계용 멤버십 인기 플랜 top3 : 구독자 수
	 * @param artGroupNo
	 * @return
	 */
	List<MembershipDescriptionVO> getTopPopularMemberships();

	/**
	 * 월별 멤버십 플랜 매출
	 * @return
	 */
	List<MembershipDescriptionVO> getMonthlySalesTrendChartData();
}
