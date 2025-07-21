package kr.or.ddit.ddtown.service.goods.notice;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;

public interface IGoodsNoticeService {

	public List<goodsNoticeVO> noticeList();

	public List<goodsNoticeVO> search(goodsNoticeVO notice);

	public goodsNoticeVO getMainNotice(); 
	
    public int getTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO);

    public List<goodsNoticeVO> getAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO);

	public List<goodsNoticeVO> getrecentGoodsNotices(int limit);

}
