package kr.or.ddit.ddtown.service.coporate;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

public interface ICoNoticeService {

	public List<NoticeVO> getList();

	public NoticeVO getDetail(int id);


	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO);

	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

}
