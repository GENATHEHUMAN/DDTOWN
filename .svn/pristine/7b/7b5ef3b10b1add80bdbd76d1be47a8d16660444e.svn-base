package kr.or.ddit.ddtown.mapper.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsVO;

@Mapper
public interface IGoodsSearchMapper {
	/**
     * 검색 조건에 맞는 상품의 총 개수를 조회
     * @param pagingVO 검색어, 검색타입 등 포함
     * @return 조건에 맞는 전체 상품 수
     */
    public int selectGoodsCount(PaginationInfoVO<goodsVO> pagingVO);

    /**
     * 검색 조건에 맞는 상품 목록을 페이지 단위로 조회
     * @param pagingVO 검색어, 정렬, 현재 페이지 등 포함
     * @return 현재 페이지에 해당하는 상품 목록
     */
    public List<goodsVO> selectGoodsList(PaginationInfoVO<goodsVO> pagingVO);

	public int selectUserGoodsListCount(PaginationInfoVO<goodsVO> pagingVO);

	public List<goodsVO> selectUserGoodsList(PaginationInfoVO<goodsVO> pagingVO);
	
	public List<Map<String, Object>> selectGoodsStatusCounts();

	public int getTotalGoodsCount();

	public List<Map<String, Object>> selectGoodsStockCounts(); 
}
