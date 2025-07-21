package kr.or.ddit.ddtown.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.ddtown.service.auth.IUserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DDTWController {

	@Autowired
	private IUserService userService;

	@GetMapping(value={"/","/main"})
	public String mainPage() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentUser = authentication.getName();	// 현재 로그인한 사용자 아이디
		log.info("name : {}", currentUser);
		return "corporate/main";
	}

	@GetMapping("/login")
	public String loginForm(Model model) {
		model.addAttribute("bodyText", "login-page");
		return "auth/loginForm";
	}

	@GetMapping("/emplogin")
	public String empLoginForm() {
		return "auth/empLoginForm";
	}

}
