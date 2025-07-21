package kr.or.ddit.ddtown.service.emp.schedule;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.concert.ConcertNoticeVO;
import kr.or.ddit.vo.concert.ConcertVO;
import kr.or.ddit.vo.schedule.ScheduleDetailVO;
import kr.or.ddit.vo.schedule.ScheduleVO;

public interface IScheduleService {

	public ArtistGroupVO getList(String empUsername);

	public ScheduleDetailVO getDes(int id);

	public ServiceResult dateUpdate(ScheduleVO scheduleVO);

	public ServiceResult dateMove(ScheduleVO scheduleVO);

	public ServiceResult dateInsert(ScheduleVO scheduleVO);

	public ServiceResult dateDelete(int id);

	public List<ConcertVO> concertNoticeList(ScheduleVO scheduleVO);

	public ConcertVO selectConcertData(ConcertVO concertVO);

	public List<ConcertNoticeVO> noticeList(ScheduleVO scheduleVO);

	public ConcertNoticeVO selectNoticeData(ConcertNoticeVO noticeVO);

}
