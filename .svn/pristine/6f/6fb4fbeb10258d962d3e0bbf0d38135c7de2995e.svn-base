package kr.or.ddit.ddtown.mapper.goods;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.GoodsWishListVO;
import kr.or.ddit.vo.goods.goodsVO;

@Mapper
public interface IWishlistMapper {
	
	//위시리스트 안에 있는 상품인지 확인
	public int checkWishlist(@Param("username")String username, @Param("goodsNo")Integer goodsNo);
	
	//위시리스트에서 삭제
	public void deleteWishlist(String username, Integer goodsNo);

	//위시리스트에 추가
	public void insertWishlist(GoodsWishListVO wishlist);
	
	//해당 회원 찜 목록 가져오기!
	public List<GoodsWishListVO> getWishlistByUsername(String username);
	
	//관리자 품목 관리에서 상품 지우기 위해 필요함!
	public void deleteWishlistByGoodsNo(int goodsNo);

	/**
     * 특정 사용자의 전체 찜 상품 개수를 조회합니다.
     * @param username 사용자 ID
     * @return 전체 찜 상품 개수
     */
    public int selectTotalWishedGoodsCount(@Param("username") String username);

    /**
     * 특정 사용자의 찜 목록을 페이징하여 조회합니다.
     * @param username 사용자 ID
     * @param pagingVO 페이징 정보를 담은 VO (startRow, endRow 또는 offset, limit 등을 사용)
     * @return 페이징 처리된 찜 상품 목록
     */
    public List<goodsVO> selectWishedGoodsPagingList(
        @Param("username") String username,
        @Param("pagingVO") PaginationInfoVO<goodsVO> pagingVO
    );
}
