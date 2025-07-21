package kr.or.ddit.ddtown.controller.emp.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/emp/notice")
public class NoticeManagementController {

	@GetMapping("/list")
	public String noticeList() {
		return "emp/notice/noticeList";
	}
	
	@GetMapping("/detail")
	public String noticeDetail() {
		return "emp/notice/noticeDetail";
	}
	
	@GetMapping("/update")
	public String noticeUpdate() {
		return "emp/notice/noticeUpdate";
	}
	
	@GetMapping("/register")
	public String noticeRegitser() {
		return "emp/notice/noticeRegister";
	}
	
	
}
