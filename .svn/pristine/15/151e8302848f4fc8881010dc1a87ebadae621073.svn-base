package kr.or.ddit.ddtown.controller.header;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ddtown.service.goods.cart.ICartService;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequestMapping("/api/cart") 
@Slf4j 
public class CartRestController {

    @Autowired 
    private ICartService cartService;

    private MemberVO extractMemberVO(Object principal) {
        if (principal instanceof CustomUser) {
            return ((CustomUser) principal).getMemberVO();
        } else if (principal instanceof CustomOAuth2User) {
            return ((CustomOAuth2User) principal).getMemberVO();
        }
        return null; // 로그인되지 않았거나 알 수 없는 Principal 타입일 경우
    }

    @GetMapping("/count")
    public ResponseEntity<Integer> getCartItemCount(@AuthenticationPrincipal Object principal) {
        int cartItemCount = 0; // 장바구니 개수 초기값
        MemberVO authMember = extractMemberVO(principal); 
        
        if (authMember != null && authMember.getMemUsername() != null && !authMember.getMemUsername().isEmpty()) {
            String memUsername = authMember.getMemUsername();
            try {
                // ICartService를 통해 장바구니 개수를 조회
                cartItemCount = cartService.getCartItemCount(memUsername);
                log.info("API 호출 - 장바구니 개수 조회: 사용자={}, 개수={}", memUsername, cartItemCount);
            } catch (Exception e) {
                // 장바구니 개수 조회 중 오류 발생 시, 로그를 남기고 0과 HTTP 500 상태 코드를 반환
                log.error("API - 장바구니 개수를 가져오는 중 오류 발생: {}", e.getMessage());
                return new ResponseEntity<>(0, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        // 성공적으로 개수를 조회했거나 비로그인 상태일 경우, 개수와 HTTP 200 OK 상태 코드를 반환
        return new ResponseEntity<>(cartItemCount, HttpStatus.OK);
    }
}