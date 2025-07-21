package kr.or.ddit.ddtown.service.alert;

import java.util.List;
import java.util.Optional;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.alert.AlertSettingVO;
import kr.or.ddit.vo.alert.AlertVO;
import kr.or.ddit.vo.live.LiveVO;

public interface IAlertService {
	
	
	/**
	 * 알림 생성 (수신자들한테도 실시간 발송용)
	 * @param alert	알림
	 * @param recipientUsernames 알림을 받을 회원들
	 */
	public void createAlert(AlertVO alert, List<String> recipientUsernames) throws Exception;
	
	/**
	 * 특정 회원의 알림 목록 조회 ( 페이징 적용 )
	 * @param memUsername 회원 아이디
	 * @return 알림 목록
	 */
	public List<AlertVO> getAlertsByUsername(PaginationInfoVO<AlertVO> pagingVO) throws Exception;
	
	/**
	 * 특정 회원의 안읽은 알림 개수 조회용
	 * @param memUsername	회원 아이디
	 * @return 안읽은 알림 개수
	 */
	public int getUnreadAlertCnt(String memUsername) throws Exception;
	
	/**
	 * 알림 읽음처리용
	 * @param alertNo	알림 번호
	 * @param memUsername	회원 아이디
	 * @return	성공 여부
	 */
	public boolean markAsRead(long alertNo, String memUsername) throws Exception;
	
	/**
	 * 특정 회원의 모든 알림 읽음처리용
	 * @param memUsername	회원 아이디
	 */
	public void markAllAsRead(String memUsername) throws Exception;
	
	/**
	 * 알림 삭제 처리 (논리적으로)
	 * @param alertNo	알림 번호
	 * @param memUsername	회원 아이디
	 * @return	성공 여부
	 */
	public boolean markAsDeleted(long alertNo, String memUsername) throws Exception;
	
	/**
	 * 회원의 알림 설정 조회용
	 * @param memUsername	회원 아이디
	 * @return	알림 설정
	 */
	public Optional<List<AlertSettingVO>> getAlertSettings(String memUsername) throws Exception;
	
	/**
	 * 회원 알림 설정 저장/수정
	 * @param settings	저장/수정할 알림 설정들
	 * @param memUsername	설정 변경할 회원 아이디
	 */
	public void saveAlertSettings(List<AlertSettingVO> settings, String memUsername) throws Exception;

	/**
	 * 기본 알림 설정 (모두 켜짐)
	 * 전체 알림 유형 호출 후 모두 'Y'설정
	 * @param username	회원 아이디
	 * @return 기본 알림 설정 목록
	 */
	public List<AlertSettingVO> createDefalutAlertForUser(String username) throws Exception;

	public LiveVO getCurrentLiveByArtGroupNo(Integer artGroupNo);

	/**
	 * 특정 회원의 전체 알림 개수 조회 (페이징용)
	 * @param pagingVO 페이징 정보
	 * @return 전체 알림 개수
	 */
	public int getAlertTotalCount(PaginationInfoVO<AlertVO> pagingVO) throws Exception;

}
