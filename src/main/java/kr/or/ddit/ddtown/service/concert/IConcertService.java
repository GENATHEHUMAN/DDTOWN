package kr.or.ddit.ddtown.service.concert;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.concert.ConcertSeatMapVO;
import kr.or.ddit.vo.concert.ConcertVO;
import kr.or.ddit.vo.concert.TicketVO;

public interface IConcertService {

	/** 콘서트 일정 등록 */
    public ServiceResult insertSchedule(ConcertVO concertVO, String regiUsername) throws Exception;

    /** 콘서트 일정 상세 조회 */
    public ConcertVO selectSchedule(int concertNo) throws Exception;

    /** 콘서트 일정 목록 조회 */
    public List<ConcertVO> selectConcertList(PaginationInfoVO<ConcertVO> pagingVO) throws Exception;

    /** 콘서트 일정 개수 조회 */
    public int selectConcertCount(PaginationInfoVO<ConcertVO> pagingVO) throws Exception;

    /** 콘서트 일정 수정 */
    public ServiceResult updateSchedule(ConcertVO concertVO) throws Exception;

    /** 콘서트 일정 삭제 */
    public ServiceResult deleteSchedule(int concertNo) throws Exception;

    // 콘서트 예매 코드별 가져오기 : 유정 ( 예정 빼고 다 가져오기 )
	public List<ConcertVO> getConcertList(ConcertVO concertVO);

	// 해당 콘서트 좌석 정보 조회
	public List<ConcertSeatMapVO> getConcertSeatMap(int concertNo);

	// 해당 콘서트의 전체 좌석 조회
	public List<TicketVO> getAllTicketList(int concertNo);

	/**
	 * 티켓정보 업데이트 : 예매
	 * @param ticketToUpdate
	 */
	public void updateTicketReservation(TicketVO ticketToUpdate);

	// 상태 필터링용 콘서트 일정 목록 조회
	public List<ConcertVO> selectConcertListWithStatusFilter(PaginationInfoVO<ConcertVO> pagingVO, String statusFilter) throws Exception;

	// 상태 필터링용 콘서트 일정 개수
	public int selectConcertCountWithStatusFilter(PaginationInfoVO<ConcertVO> pagingVO, String statusFilter) throws Exception;

	// 상태 필터링 건수 조회용
	public Map<String, Integer> selectConcertCountsByStatus() throws Exception;

	// 좌석 상태 확인
	public Map<String, Object> getSeatStatus(int concertNo);

	public List<Map<String, Object>> getDailyTicketStats(int concertNo, String startDate, String endDate);

	public List<Map<String, Object>> getDailyTicketStatsByGradeSection(int concertNo, String startDate, String endDate);

	public List<Map<String, Object>> getDailyReservedSeats(int concertNo, String startDate, String endDate);

	/**
	 * 스케쥴 어노테이션을 활용해서 공연시간에 맞춰서 진행 종료 등으로 변환
	 */
	public void updateConcertStatCode();

	/**
	 * 티켓에 있는 콘서트번호를 통해 좌석이 매진되었는지 확인
	 */
	public void checkAndUpdateConcertStatCodeAllSaled();
}
