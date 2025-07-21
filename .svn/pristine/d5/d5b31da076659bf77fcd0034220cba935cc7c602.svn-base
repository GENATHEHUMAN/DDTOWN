package kr.or.ddit.ddtown.service.goods.notice;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;

public interface IGoodsNoticeService {

	public List<goodsNoticeVO> noticeList();

	public List<goodsNoticeVO> search(goodsNoticeVO notice);

	public goodsNoticeVO getMainNotice(); //굿즈샵 메인 상단에 보여줄 공지사항 1개
	
	// --- 새로 추가할 페이징 관련 메서드 ---
    // 1. 전체 공지사항 개수 조회 (검색 조건 포함)
    public int getTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO);

    // 2. 페이징 처리된 공지사항 목록 조회 (검색 조건 포함)
    public List<goodsNoticeVO> getAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO);

	public List<goodsNoticeVO> getrecentGoodsNotices(int limit);

}
