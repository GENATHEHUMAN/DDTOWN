package kr.or.ddit.ddtown.controller.inquiry;

import java.lang.ProcessBuilder.Redirect;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

// 1:1 문의 jsp 출력하기 위한 컨트롤러

@Slf4j
@Controller
@RequestMapping("/inquiry")
public class InquiryViewController {

	@PreAuthorize("permitAll()")
	@GetMapping("/main")
	public String main(RedirectAttributes red) {
		log.info("1:1문의 페이지 호출됨...");
		
		return "inquiry/main";
	}
	
	@GetMapping("/detail/{inqNo}")
	public String detail() {
		log.info("1:1문의 상세페이지 호출됨...");
		
		return "inquiry/detail";
	}
	
	@GetMapping("/update/{inqNo}")
	public String update() {
		return "inquiry/form";
	}
	
	
}
