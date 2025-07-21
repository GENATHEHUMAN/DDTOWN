package kr.or.ddit.ddtown.mapper.admin.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;


@Mapper
public interface AdminNoticeMapper {

	public List<NoticeVO> getList();

	public NoticeVO getDetail(int id);

	public int insertNotice(NoticeVO noticeVO);

	public boolean deleteNotice(int id);

	public int modifyNotice(NoticeVO noticeVO);

	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO);

	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	public void updateNoticeFileGroupToNull(int entNotiNo);

	public List<NoticeVO> selectRecentList();

	// 통계용
	public int getTotalNoticeCnt();

	public int getGongjiPrefixCnt();

	public int getAnnaePrefixCnt();

}
