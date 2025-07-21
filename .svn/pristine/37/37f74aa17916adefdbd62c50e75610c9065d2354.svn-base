package kr.or.ddit.ddtown.service.goods.wishlist;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ddtown.mapper.goods.IWishlistMapper;
import kr.or.ddit.ddtown.service.goods.main.IGoodsService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.GoodsWishListVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WishlistServiceImpl implements IWishlistService {
	
	@Autowired
	private IWishlistMapper wishlistMapper;
	
	@Autowired
	private IGoodsService goodsService;
	
	/*
	 * 특정 상품이 특정 회원 찜 목록에 있느니
	 * @param username 회원 아이디
	 * @param goodsNo 상품 번호
	 * @return 찜 목록에 있으면 true, 없으면 false
	 */
	@Override
	public boolean isGoodsWished(String username, Integer goodsNo) {
		log.info("isGoodsWished() 서비스 호출!! 회원ID =" + username + ", 상품 번호 =" + goodsNo);
		
		try {
			//wishlistMapper의 checkWishlist 메소드를 호출하여 찜된 상품의 개수 확인
			//0보다 크면 찜되어 있는 것으로 판단!!
			return  wishlistMapper.checkWishlist(username, goodsNo) > 0;
		} catch (Exception e) {
			log.error("찜 여부 확인 중 오류 발생: " + e.getMessage(), e);
			//오류 발생 시에 false 반환하여 찜 돼 있지 않다고 처리!
			return false; 
		}
	}
	
	/*
	 * 특정 상품을 회원의 찜 목록에서 제거
	 * @param username 회원 아이디
	 * @param goodsNo 상품 번호
	 * @return 찜 삭제 성공 시 true, 실패 시 false
	 */
	@Transactional
	@Override
	public boolean removeWishlist(String username, Integer goodsNo) {
		log.info("removeWishlist() 서비스 호출!! 회원ID = " + username + ", 상품 번호 = " + goodsNo);
		
		try {
			//wishlistMapper의 deleteWishlist 메소드를 호출해서 찜 목록에서 상품 삭제
			wishlistMapper.deleteWishlist(username, goodsNo);
			log.info("찜 삭제 성공!! 회원ID=" + username + ", 상품 번호 = " + goodsNo);
			return true; //삭제 성공
		} catch (Exception e) {
			log.error("찜 삭제 중 오류 발생: " + e.getMessage(), e);
			//오류 발생 시 false 반환
			return false;
		}
	}
	/*
	 * 특정 상품 회원의 찜 목록에 추가
	 * @param username 회원 아이디
	 * @param goodsNo 상품 번호
	 * @return 찜 추가 성공 시 true, 실패 시 false
	 */
	@Transactional
	@Override
	public boolean addWishlist(String username, Integer goodsNo) {
		log.info("addWishlist() 서비스 호출: 회원ID = " + username + ", 상품 번호 = " + goodsNo);
		
		try {
			//1. 먼저 해당 상품이 이미 찜 돼 있는지 확인 (중복 추가 방지!)
			if(wishlistMapper.checkWishlist(username, goodsNo) > 0) {
				log.info("이미 찜된 상품입니다! 추가 작업을 건너 뜀: 회원 ID = " + username + ", 상품 번호 =" + goodsNo);
				
				return false; //이미 찜 돼 있으면 추가하지 않고 건너 false 반환
			}
			
			//2. 찜 VO 객체를 생성하고 데이터를 설정!
			GoodsWishListVO wishlist = new GoodsWishListVO();
			wishlist.setMemUsername(username);
			wishlist.setGoodsNo(goodsNo);
			
			//3.wishlistMapper를 통해 DB에 찜 정보 삽입
			wishlistMapper.insertWishlist(wishlist);
			log.info("찜 추가 성공!! 회원 ID = " + username + ", 상품 번호 = " + goodsNo);
			
			return true; //추가 성공!!
			
		} catch (Exception e) {
			log.error("찜 추가 중 오류 발생!! " + e.getMessage(), e);
			//오류 발생 시 false를 반환!!!
			return false;
		}
	}

	@Override
	public Collection<goodsVO> getWishlistForUser(String username) {
		log.info("getWishlistForUser() 서비스 호출!!! 회원ID = " + username);
		
		List<goodsVO> wishedGoodsList = new ArrayList<>(); //최종 반환할 상품 상세 정보 리스트!
		
		try {
			//1. IWishlistMapper를 통해 해당 회원의 찜 목록(GoodsWishListVO 객체들)을 가져옴!
			List<GoodsWishListVO> userWishlist = wishlistMapper.getWishlistByUsername(username);
			
			//2. 찜 목록이 비어있지 않다면! 각 찜 항목의 goodsNo를 사용하여 상품 상세 정보를 가져옴!
			if (userWishlist != null && !userWishlist.isEmpty()) {
				for(GoodsWishListVO wishItem : userWishlist) {
					int goodsNo = wishItem.getGoodsNo();
					
					//GoodsService의 getGoodsDetail 메소드 호출해서 상품 상세 정보 가져옴!
					goodsVO goodsDetail = goodsService.getGoodsDetail(goodsNo);
					
					if (goodsDetail != null) {
						wishedGoodsList.add(goodsDetail);
						log.debug("찜 상품 상세 정보 로드 성공!! 상품 정보 {}", goodsNo);
					} else {
						log.warn("찜 목록에서 상품 번호 {}에 해당하는 상세 정보를 찾을 수 없어요!!", goodsNo);
					}
				}
			}
			
			log.info("찜 목록 조회 완료! 회원ID = " + username + ", 조회된 상품 개수 = " + wishedGoodsList.size());
			
			return wishedGoodsList;
			
		} catch (Exception e) {
			log.error("찜 목록 조회 중 오류 발생!!!: " + e.getMessage(), e);
			//오류 발생 시 빈 리스트 반환!
			return new ArrayList<>();
			
		}
	}

	@Override
	public List<goodsVO> getWishedGoodsPagingListForUser(String username, PaginationInfoVO<goodsVO> pagingVO) {
	    log.info("getWishedGoodsPagingListForUser() 서비스 호출!! 회원ID = " + username);

	    try {
	        // 1. 전체 찜 상품 개수 조회
	        int totalCount = wishlistMapper.selectTotalWishedGoodsCount(username);
	        pagingVO.setTotalRecord(totalCount);
	        
	        // ⭐⭐⭐ 중요: setTotalRecord 호출 ⭐⭐⭐
	        pagingVO.setTotalRecord(totalCount); // 여기서 totalPage가 1차적으로 계산됨

	        // ⭐⭐⭐ 중요: 찜 목록 전용 페이지 보정 메서드 호출 ⭐⭐⭐
	        // 이 메서드가 totalPage, startPage, endPage를 최종적으로 올바르게 조정합니다.
	        pagingVO.applyWishlistPagination();
	        

	        // ⭐⭐ applyWishlistPagination() 적용 후 PaginationInfoVO의 핵심 값들을 로그로 출력 ⭐⭐
	        log.info("PagingVO after applyWishlistPagination - totalRecord: {}", pagingVO.getTotalRecord());
	        log.info("PagingVO after applyWishlistPagination - totalPage: {}", pagingVO.getTotalPage()); // ⭐⭐ 이게 1로 나오는지 확인 ⭐⭐
	        log.info("PagingVO after applyWishlistPagination - currentPage: {}", pagingVO.getCurrentPage());
	        log.info("PagingVO after applyWishlistPagination - startRow: {}", pagingVO.getStartRow());   // ⭐⭐ 이게 1로 나오는지 확인 (1페이지 기준) ⭐⭐
	        log.info("PagingVO after applyWishlistPagination - endRow: {}", pagingVO.getEndRow());     // ⭐⭐ 이게 10으로 나오는지 확인 (1페이지 기준) ⭐⭐
	        log.info("PagingVO after applyWishlistPagination - startPage: {}", pagingVO.getStartPage());
	        log.info("PagingVO after applyWishlistPagination - endPage: {}", pagingVO.getEndPage());

	        List<goodsVO> wishedGoodsList;
	        if (totalCount > 0) {
	            // 2. 페이징 처리된 찜 상품 목록 조회 (여기서 이미지가 채워져서 옴)
	            wishedGoodsList = wishlistMapper.selectWishedGoodsPagingList(username, pagingVO);
	            // ★★★ 문제의 가능성: 이 시점에서 이미 wishedGoodsList의 각 goodsVO에
	            // representativeImageUrl이 올바르게 채워져 있어야 합니다.

	            // 3. 만약 여기에 for 루프를 돌면서 goodsService.getGoodsDetail(goodsNo)를 다시 호출했다면 문제!
	            // (현재 코드에는 이 부분이 없으니 다행이지만, 이전에 goodsList()와 getGoodsDetail()에서 했던 실수가 여기에도 있을까봐 우려했습니다.)

	        } else {
	            wishedGoodsList = new ArrayList<>();
	        }

	        pagingVO.setDataList(wishedGoodsList);

	        log.info("페이징된 찜 목록 조회 완료! 회원ID = {}, 총 상품 개수 = {}, 현재 페이지 상품 개수 = {}",
	                username, totalCount, wishedGoodsList.size());

	        return wishedGoodsList;
	    } catch (Exception e) {
	        log.error("페이징된 찜 목록 조회 중 오류 발생!!!: " + e.getMessage(), e);
	        return new ArrayList<>();
	    }
	}
}
