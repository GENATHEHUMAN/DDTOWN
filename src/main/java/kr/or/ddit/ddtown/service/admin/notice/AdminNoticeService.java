package kr.or.ddit.ddtown.service.admin.notice;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

public interface AdminNoticeService {

	public NoticeVO getDetail(int id);

	public void createNotice(NoticeVO noticeVO);

	public int modifyNotice(NoticeVO noticeVO, List<Integer> deleteFileNos) throws Exception;

	public boolean deleteNotice(int id) throws Exception;

	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO);

	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	public List<NoticeVO> selectRecentList();

	// 통계용 시작
	public int getTotalNoticeCnt();

	public int getGongjiPrefixCnt();

	public int getAnnaePrefixCnt();
	// 끝


}
