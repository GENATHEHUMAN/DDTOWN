package kr.or.ddit.ddtown.controller.goods;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.ddtown.service.goods.cart.ICartService;
import kr.or.ddit.ddtown.service.goods.main.IGoodsService;
import kr.or.ddit.ddtown.service.goods.notice.IGoodsNoticeService;
import kr.or.ddit.ddtown.service.goods.wishlist.IWishlistService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import kr.or.ddit.vo.goods.goodsOptionVO;
import kr.or.ddit.vo.goods.goodsVO;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/goods")
public class goodsController {
	
	@Autowired
	public IGoodsService service;
	
	@Autowired
	public IGoodsNoticeService noticeservice;
	
	@Autowired
	public IWishlistService wishlistservice;
	
	@Autowired
	public ICartService cartService;
	
	@GetMapping("/main")
    public String goodsShopList(
            Model model,
            @AuthenticationPrincipal Object principal,
            @RequestParam(name="currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(required = false) String searchWord, 
            @RequestParam(name="searchType", required = false, defaultValue = "newest") String searchType, 
            @RequestParam(name="artGroupNo", required = false) Integer artGroupNo, // 아티스트 필터링용
            HttpServletRequest request
            ) {

        PaginationInfoVO<goodsVO> pagingVO = new PaginationInfoVO<>();
        pagingVO.setCurrentPage(currentPage);   
        
        pagingVO.setSearchType(searchType);
        pagingVO.setSearchWord(searchWord);
        pagingVO.setArtGroupNo(artGroupNo); 
        
        log.info("### GoodsController - goodsShopList 호출: currentPage={}, searchWord={}, searchType={}, artGroupNo={}",
                 currentPage, searchWord, searchType, artGroupNo);

        service.retrieveUserGoodsList(pagingVO);

        log.info("### GoodsController - retrieveUserGoodsList 호출 결과: totalRecord={}, dataList.size={}",
                 pagingVO.getTotalRecord(), pagingVO.getDataList() != null ? pagingVO.getDataList().size() : 0);

        MemberVO authMember = null;
        if (principal instanceof CustomUser) {
            authMember = ((CustomUser) principal).getMemberVO();
        } else if (principal instanceof CustomOAuth2User) {
            authMember = ((CustomOAuth2User) principal).getMemberVO();
        }

        boolean isLoggedIn = (authMember != null && authMember.getMemUsername() != null && !authMember.getMemUsername().isEmpty());
        model.addAttribute("isLoggedIn", isLoggedIn);
        
        if (isLoggedIn) {
            String memUsername = authMember.getMemUsername();
            int cartItemCount = cartService.getCartItemCount(memUsername);
            model.addAttribute("cartItemCount", cartItemCount);
            log.info("### GoodsController - cartItemCount for {}: {}", memUsername, cartItemCount);
        } else {
            model.addAttribute("cartItemCount", 0); 
        }
        
        if (isLoggedIn && pagingVO.getDataList() != null) {
            String username = authMember.getMemUsername();
            List<Integer> wishedGoodsNos = wishlistservice.getWishlistForUser(username)
                                             .stream()
                                             .map(wish -> wish.getGoodsNo())
                                             .collect(Collectors.toList());

            for (goodsVO goods : pagingVO.getDataList()) {
                goods.setWished(wishedGoodsNos.contains(goods.getGoodsNo()));
            }
        }

        model.addAttribute("pagingVO", pagingVO);

        goodsNoticeVO noticeToShow = noticeservice.getMainNotice();
        model.addAttribute("notice", noticeToShow);

        List<ArtistGroupVO> artistList = service.getArtistGroups(); 
        model.addAttribute("artistList", artistList);

        model.addAttribute("searchType", searchType);
        model.addAttribute("searchWord", searchWord); 
        model.addAttribute("artGroupNo", artGroupNo); 

        return "goods/main";
    }
	
	@GetMapping("/detail")
	public String goodsShopDetail(
			@RequestParam("goodsNo") int goodsNo, 
			Model model,
			@AuthenticationPrincipal Object principal
			) throws Exception {
		
		MemberVO authMember = null;
		log.info("### 디버그: 주입된 principal 객체: {}", principal); 
		
		
		if (principal instanceof CustomUser) { 
            CustomUser customUser = (CustomUser) principal;
            authMember = customUser.getMemberVO();
            log.info("### 디버그: CustomUser 타입에서 MemberVO 추출: {}", authMember);
        } else if (principal instanceof CustomOAuth2User) { 
            CustomOAuth2User customOAuth2User = (CustomOAuth2User) principal;
            authMember = customOAuth2User.getMemberVO();
            log.info("### 디버그: CustomOAuth2User 타입에서 MemberVO 추출: {}", authMember);
        } else {
            log.warn("### 디버그: 알 수 없는 Principal 타입: {}", principal.getClass().getName());
        }
        
        model.addAttribute("memberInfo", authMember);
        log.info("상세 페이지 컨트롤러 호출! 인증된 회원 정보: {}", authMember != null ? authMember.getMemUsername(): "비회원");
        
        boolean isLoggedIn = (authMember != null && authMember.getMemUsername() != null && !authMember.getMemUsername().isEmpty());
        model.addAttribute("isLoggedIn", isLoggedIn);
        
        if (isLoggedIn) {
            String memUsername = authMember.getMemUsername();
            int cartItemCount = cartService.getCartItemCount(memUsername); 
            model.addAttribute("cartItemCount", cartItemCount); 
            log.info("### GoodsController - detail cartItemCount for {}: {}", memUsername, cartItemCount);
        } else {
            model.addAttribute("cartItemCount", 0); 
        }
		goodsVO goods = service.getGoodsDetail(goodsNo);
		model.addAttribute("goods", goods);
		log.info("서비스에서 반환된 goodsVO: {}", goods);
		log.info("컨트롤러에서 받은 goodsNo: {}", goodsNo);
		
	    log.info("### DB에서 가져온 goods 객체 전체 내용: {}", goods);
		
		List<goodsOptionVO> optionList = service.optionList(goodsNo);
		model.addAttribute("optionList", optionList);
		log.info("옵션 목록: {}", optionList);
	
		return "goods/detail";
	}
	
	@PostMapping("/wishlist")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> toggleWishlist (
			@RequestBody Map<String, Integer> payload,
			@AuthenticationPrincipal Object principal
			) {
		Map<String, Object> response = new HashMap<>();
		MemberVO authMember = null;
		String username = null;
		
        if (principal instanceof CustomUser) {
            authMember = ((CustomUser) principal).getMemberVO();
        } else if (principal instanceof CustomOAuth2User) {
            authMember = ((CustomOAuth2User) principal).getMemberVO();
        }
        
        if (authMember != null) {
            username = authMember.getMemUsername();
        }

        if (username == null || username.isEmpty()) { 
            response.put("status", "error");
            response.put("message", "로그인이 필요합니다.");
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED); 
        }

        Integer goodsNo = payload.get("goodsNo");
        
        if(goodsNo == null) {
        	response.put("status", "error");
        	response.put("message", "상품 번호가 누락됐습니다!");
        	
        	return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
        
        try {
			boolean isWished = wishlistservice.isGoodsWished(username, goodsNo);
			
			if (isWished) {
				if (wishlistservice.removeWishlist(username, goodsNo)) {
					response.put("status", "success");
					response.put("message", "찜이 해제됐습니다!");
					response.put("action", "removed");
					
				} else {
					response.put("status", "error");
					response.put("message", "찜 해제 실패했습니다!");

				}
				
			} else {
				if (wishlistservice.addWishlist(username, goodsNo)) {
					response.put("status", "success");
					response.put("message", "찜 목록에 추가됐습니다!");
					response.put("action", "added");
					
					 log.info(">>>>>> 컨트롤러: addWishlist 서비스 호출 성공! USER: {}, GOODS_NO: {}", username, goodsNo);
				} else {
					response.put("status", "error");
					response.put("message", "찜 추가에 실패했습니다!");
				}
			}
			
			return new ResponseEntity<>(response, HttpStatus.OK);
		} catch (Exception e) {
			log.error("찜 토글 중 서버 오류 발생!!!" + e.getMessage(), e);
			response.put("status", "error");
			response.put("message", "찜 처리 중 서버 오류가 발생했습니다!!");
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/wishlist")
	public String getWishlistItem(
			Model model,
			@AuthenticationPrincipal Object principal,
			@RequestParam(name="currentPage", required = false, defaultValue = "1") int currentPage, 
			@RequestParam(name="itemsPerPage", required = false, defaultValue = "10") int itemsPerPage, 
			RedirectAttributes ra
			) {
		log.info("getWishlistItem() 컨트롤러 호출!!!!");

		MemberVO authMember = null;
		if (principal instanceof CustomUser) {
			authMember = ((CustomUser) principal).getMemberVO();
		} else if (principal instanceof CustomOAuth2User) {
			authMember = ((CustomOAuth2User) principal).getMemberVO();
		}

		if (authMember == null || authMember.getMemUsername() == null || authMember.getMemUsername().isEmpty()) {
			log.warn("getWishlistPage() - 비로그인 상태 접근 시도!");
			ra.addFlashAttribute("message", "로그인이 필요한 페이지입니다.");
			return "redirect:/login.html"; 
		}

		String username = authMember.getMemUsername();
		model.addAttribute("isLoggedIn", true); 

		PaginationInfoVO<goodsVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setScreenSize(itemsPerPage);

		log.info("### WishlistController - getWishlistItem 호출: currentPage={}, itemsPerPage={}", currentPage, itemsPerPage);

		List<goodsVO> wishedGoodsList = new ArrayList<>(); 
		try {
			wishedGoodsList = wishlistservice.getWishedGoodsPagingListForUser(username, pagingVO);
			log.info("getWishlistPage() - 회원 {}의 찜 목록 상품 개수: {}", username, wishedGoodsList.size());
		} catch (Exception e) {
			log.error("getWishlistPage() - 찜 목록 조회 중 오류 발생: {}", e.getMessage(), e);
			model.addAttribute("errorMessage", "찜 목록을 불러오는 중 오류가 발생했습니다.");
		}

		// 3. 모델에 데이터 추가
		model.addAttribute("wishedGoodsList", wishedGoodsList); 
		model.addAttribute("pagingVO", pagingVO);
		return "goods/wishlist";
	}
	
	@GetMapping("/wishlist/status")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getWishlistStatus(
	        @RequestParam(required = false) Integer goodsNo, 
	        @AuthenticationPrincipal Object principal) {

	    Map<String, Object> response = new HashMap<>();

	    if (goodsNo == null) {
	        response.put("isWished", false);
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    }
	    
	    if (principal == null) {
	        response.put("isWished", false);
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    }
	    
	    MemberVO authMember = null;
	    if (principal instanceof CustomUser) {
	        authMember = ((CustomUser) principal).getMemberVO();
	    } else if (principal instanceof CustomOAuth2User) {
	        authMember = ((CustomOAuth2User) principal).getMemberVO();
	    }

	    if (authMember == null || authMember.getMemUsername() == null) {
	        response.put("isWished", false);
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    }
	    
	    String username = authMember.getMemUsername();
	    
	    log.info(">>>>>> getWishlistStatus: DB 조회 시작 (username: {}, goodsNo: {})", username, goodsNo);
	    boolean isWished = wishlistservice.isGoodsWished(username, goodsNo);
	    log.info(">>>>>> getWishlistStatus: DB 조회 결과 isWished = {}", isWished);
	    
	    response.put("isWished", isWished);
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
}
