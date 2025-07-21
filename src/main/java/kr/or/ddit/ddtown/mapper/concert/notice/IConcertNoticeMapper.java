package kr.or.ddit.ddtown.mapper.concert.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.concert.ConcertNoticeVO;

@Mapper
public interface IConcertNoticeMapper {

	/** 콘서트 일정 목록 조회 */
	public List<ConcertNoticeVO> selectNoticeList(PaginationInfoVO<ConcertNoticeVO> pagingVO);

	/** 콘서트 일정 개수 조회 (검색 조건 포함) */
	public int selectNoticeCount(PaginationInfoVO<ConcertNoticeVO> pagingVO);

	 /** 콘서트 일정 상세 조회 */
	public ConcertNoticeVO selectNotice(int concertNotiNo);

	/** 콘서트 일정 등록 */
	public int insertNotice(ConcertNoticeVO noticeVO);

	/** 콘서트 일정 수정 */
	public int updateNotice(ConcertNoticeVO noticeVO);

	/** 콘서트 일정 삭제 */
	public int deleteNotice(int concertNotiNo);
	
	
}
