package kr.or.ddit.ddtown.mapper.community;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.community.CommunityNoticeVO;

@Mapper
public interface ICommunityNoticeMapper {

	/** 커뮤니티 일정 목록 조회 */
	public List<CommunityNoticeVO> selectNoticeList(PaginationInfoVO<CommunityNoticeVO> pagingVO);

	/** 커뮤니티 일정 개수 조회 (검색 조건 포함) */
	public int selectNoticeCount(PaginationInfoVO<CommunityNoticeVO> pagingVO);

	 /** 커뮤니티 일정 상세 조회 */
	public CommunityNoticeVO selectNotice(int comuNotiNo);

	/** 커뮤니티 일정 등록 */
	public int insertNotice(CommunityNoticeVO noticeVO);

	/** 커뮤니티 일정 수정 */
	public int updateNotice(CommunityNoticeVO noticeVO);

	/** 커뮤니티 일정 삭제 */
	public int deleteNotice(int comuNotiNo);

	/** 사용자 시점 공지사항 목록 조회 */
	public List<CommunityNoticeVO> clientPointOfViewCommunityNoticeList(PaginationInfoVO<CommunityNoticeVO> pagingVO);

	/** 해당 아티스트의 모든 공지사항 목록 조회 */
	public List<CommunityNoticeVO> allNoticeList(int artGroupNo);
	
	
}
