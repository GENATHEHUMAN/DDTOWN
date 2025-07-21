package kr.or.ddit.ddtown.controller.admin.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminInquiryViewController {

	@GetMapping("/inquiry/detail/{inqNo}")
	public String adminInquiryDetail() {
		
		log.info("관리자 1대1 문의 상세페이지 요청 중...");
		
		return "admin/faq_inquiry/inquiryDetail";
	}
	
	@GetMapping("/faq/detail/{faqNo}")
	public String adminFaqDetail() {
		log.info("관리자 FAQ 상세페이지 요청 중...");
		
		return "admin/faq_inquiry/faqDetail";
	}
}
