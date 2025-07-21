package kr.or.ddit.ddtown.mapper.concert.schedule;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.concert.ConcertSeatMapVO;
import kr.or.ddit.vo.concert.ConcertVO;
import kr.or.ddit.vo.concert.TicketVO;

/**
 *
 */
@Mapper
public interface IConcertScheduleMapper {

	/** 콘서트 일정 목록 조회 */
    public List<ConcertVO> selectConcertList(PaginationInfoVO<ConcertVO> pagingVO);

    /** 콘서트 일정 개수 조회 (검색 조건 포함) */
    public int selectConcertCount(PaginationInfoVO<ConcertVO> pagingVO);

	/** 콘서트 일정 등록 */
    public int insertSchedule(ConcertVO concertVO);

    /** 콘서트 일정 상세 조회 */
    public ConcertVO selectSchedule(int concertNo);

    /** 콘서트 일정 수정 */
    public int updateSchedule(ConcertVO concertVO);

    /** 콘서트 일정 삭제 */
    public int deleteSchedule(int concertNo);

    // 콘서트 일정 불러오기
	public List<ConcertVO> getConcertList(ConcertVO concertVO);

	// 해당 콘서트 좌석 정보 조회
	public List<ConcertSeatMapVO> getConcertSeatMap(int concertNo);

	// 해당 콘서트 전체 좌석 조회
	public List<TicketVO> getAllTicketList(int concertNo);


	/**
	 * 콘서트 티켓 예매 업데이트
	 * @param ticketToUpdate
	 */
	public void updateTicketReservation(TicketVO ticketToUpdate);

	// 상태 필터링용 콘서트 일정 리스트 조회
	public List<ConcertVO> selectConcertListWithStatusFilter(Map<String, Object> params);

	// 상태 필터링용 콘서트 일정 개수 조회
	public int selectConcertCountWithStatusFilter(Map<String, Object> params);

	// 상태 필터링 건수 조회용
	public List<Map<String, Object>> selectConcertCountsByStatus();

	// 콘서트번호로 총 좌석 수 조회
	public Integer selectTotalSeatsByConcertNo(int concertNo);

	// 콘서트번호로 티켓조회용
	public List<Map<String, Object>> selectTicketsByConcertNo(int concertNo);

	// 콘서트번호로 총 판매금액 조회용
	public Integer selectTotalSalesByConcertNo(int concertNo);

	// ConcertMapper.java
	public List<Map<String, Object>> selectDailyTicketStats(
	    @Param("concertNo") int concertNo,
	    @Param("startDate") String startDate,
	    @Param("endDate") String endDate
	);

	public List<Map<String, Object>> selectDailyTicketStatsByGradeSection(
	    @Param("concertNo") int concertNo,
	    @Param("startDate") String startDate,
	    @Param("endDate") String endDate
	);

	public List<Map<String, Object>> selectDailyReservedSeats(
		@Param("concertNo") int concertNo,
		@Param("startDate") String startDate,
		@Param("endDate") String endDate
	);

	/**
	 * 일정 시간 마다 체크해서 콘서트 상태 변경
	 * 상태코드 예정-> 진행
	 */
	public void updateConcertStatCodeLiving();

	/**
	 * 일정 시간 마다 체크해서 콘서트 상태 변경
	 * 상태코드 진행 -> 종료
	 */
	public void updateConcertStatCodeEnd();

	/**
	 * 일정 시간마다 체크해서 콘서트 예매상태 변경
	 * 상태코드 예정 -> 선예매
	 */
	public void updateConcertRvStatCodePreSale();

	/**
	 * 일정 시간마다 체크해서 콘서트 예매상태 변경
	 * 상태코드 선예매 -> 예매
	 */
	public void updateConcertRvStatCodeOnSale();

	/**
	 * 일정 시간마다 체크해서 콘서트 예매상태 변경
	 * 상태코드 예매 , 매진 -> 종료
	 */
	public void updateConcertRvStatCodeEnd();

	/**
	 * 티켓에 있는 콘서트 번호 가져오기
	 * @return
	 */
	public List<Integer> selectConcertNo();

	/**
	 * 티켓 콘서트별로 티켓 수량 매진되었으면 상태값 변경
	 * @param concertNo
	 */
	public void updateRvStatCodeAllSale(int concertNo);

	// 콘서트번호로 총 좌석 수 조회
	public int getTotalSeatCount(int concertNo);
	
	// === 자식 테이블 삭제 메서드들 ===
	/** 해당 콘서트의 티켓들 삭제 */
	public int deleteTicketsByConcertNo(int concertNo);
	
	/** 해당 콘서트의 좌석 맵 삭제 */
	public int deleteConcertSeatMapByConcertNo(int concertNo);
}
