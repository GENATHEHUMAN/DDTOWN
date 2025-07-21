package kr.or.ddit.security;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomErrorController implements ErrorController{
	
	@GetMapping("/error")
	public String errorPage(Model model, HttpServletRequest req, HttpServletRequest request, HttpServletResponse response) {
		Object status = req.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		String errorPage = "error/error";
		
		if(status != null) {
			Integer statusCode = Integer.valueOf(status.toString());
			
			model.addAttribute("statusCode", statusCode);
			
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				errorPage = "error/404";
				model.addAttribute("message", "요청하신 페이지를 찾을 수 없습니다");
			}else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				errorPage = "error/500";
				model.addAttribute("message", "서버 내부에 오류가 발생했습니다. 다시 시도해주세요");
			}else {
				model.addAttribute("message", "알 수 없는 오류가 발생했습니다. 상태 코드: " + statusCode);
			}
		}else {
			model.addAttribute("statusCode", "N/A");
			model.addAttribute("message", "오류가 발생했습니다.");
		}
		return errorPage;
	}
}
