package kr.or.ddit.ddtown.service.goods.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.goods.IGoodsNoticeMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GoodsNoticeServiceImpl implements IGoodsNoticeService {
	
	
	@Autowired
	private IGoodsNoticeMapper mapper;
	
	//공지사항 리스트 만들어서 목록으로 띄우기
	@Override
	public List<goodsNoticeVO> noticeList() {
		
		return mapper.noticeList();
	}
	
	//공지사항에서 검색하기
	@Override
	public List<goodsNoticeVO> search(goodsNoticeVO notice) {

		return mapper.search(notice);
	}
	
	//메인에 띄울 공지사항 하나 가져오기
	@Override
	public goodsNoticeVO getMainNotice() {
		
		goodsNoticeVO mainNotice = mapper.selectMainNotice();
		
		return mainNotice;
	}

	// --- 새로 추가하는 페이징 관련 메서드 구현 ---

    @Override
    public int getTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO) {
        log.info("getTotalGoodsNoticeCount() 호출: searchType={}, searchWord={}", pagingVO.getSearchType(), pagingVO.getSearchWord());
        try {
            int totalCount = mapper.selectTotalGoodsNoticeCount(pagingVO); // 매퍼 메서드 호출
            log.info("getTotalGoodsNoticeCount() 결과: 총 공지사항 수 = {}", totalCount);
            return totalCount;
        } catch (Exception e) {
            log.error("getTotalGoodsNoticeCount() 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("전체 공지사항 수 조회 중 오류 발생", e);
        }
    }

    @Override
    public List<goodsNoticeVO> getAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO) {
        log.info("getAllGoodsNotices() 호출: currentPage={}, startRow={}, endRow={}, searchType={}, searchWord={}",
                 pagingVO.getCurrentPage(), pagingVO.getStartRow(), pagingVO.getEndRow(),
                 pagingVO.getSearchType(), pagingVO.getSearchWord());
        try {
            List<goodsNoticeVO> noticeList = mapper.selectAllGoodsNotices(pagingVO); // 매퍼 메서드 호출
            log.info("getAllGoodsNotices() 결과: 조회된 공지사항 개수 = {}", noticeList != null ? noticeList.size() : 0);
            return noticeList;
        } catch (Exception e) {
            log.error("getAllGoodsNotices() 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("페이징된 공지사항 목록 조회 중 오류 발생", e);
        }
    }

    @Override
    // ⭐ int limit 파라미터를 받도록 메서드 시그니처를 수정합니다. ⭐
    public List<goodsNoticeVO> getrecentGoodsNotices(int limit) {
        log.info("getrecentGoodsNotices 서비스 메서드 실행, limit: {}", limit);
        // 매퍼의 selectRecentGoodsNotices 메서드에 limit 값을 전달합니다.
        List<goodsNoticeVO> noticeList = mapper.selectRecentGoodsNotices(limit);
        log.info("조회된 굿즈샵 공지사항 수: {}", noticeList != null ? noticeList.size() : 0);
        return noticeList;
    }

	
}
