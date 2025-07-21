package kr.or.ddit.ddtown.controller.header;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.ddtown.service.goods.cart.ICartService;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GetGoodsCountController {
	
	@Autowired
    private ICartService cartService; 
    private MemberVO extractMemberVO(Object principal) {
        if (principal instanceof CustomUser) {
            return ((CustomUser) principal).getMemberVO();
        } else if (principal instanceof CustomOAuth2User) {
            return ((CustomOAuth2User) principal).getMemberVO();
        }
        return null;
    }
	
    /**
     * 현재 로그인된 사용자의 장바구니 상품 개수를 Model에 추가합니다.
     * 이 값은 모든 뷰에서 ${cartItemCount}로 접근 가능합니다.
     */
    @ModelAttribute("cartItemCount") 
    public int addCartItemCountToModel(@AuthenticationPrincipal Object principal
    		) {
        int cartItemCount = 0; 
        MemberVO authMember = extractMemberVO(principal); 

        if (authMember != null && authMember.getMemUsername() != null && !authMember.getMemUsername().isEmpty()) {
            String memUsername = authMember.getMemUsername();
            try {
                cartItemCount = cartService.getCartItemCount(memUsername);
            } catch (Exception e) {
                log.error("GlobalHeaderDataLoader에서 장바구니 개수를 가져오는 중 오류 발생: {}", e.getMessage());
            }
        }
        log.debug("Header cartItemCount added to Model: {}", cartItemCount);
        return cartItemCount;
    }

    /**
     * 현재 로그인 상태 여부를 Model에 추가합니다.
     * 이 값은 모든 뷰에서 ${isLoggedIn}으로 접근 가능합니다.
     */
    @ModelAttribute("isLoggedIn")
    public boolean addIsLoggedInToModel(@AuthenticationPrincipal Object principal) {
        return extractMemberVO(principal) != null;
    }

}
