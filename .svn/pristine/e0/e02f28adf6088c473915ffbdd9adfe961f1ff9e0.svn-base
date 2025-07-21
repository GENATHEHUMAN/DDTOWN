package kr.or.ddit.ddtown.controller.admin.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.admin.notice.AdminNoticeService;
import kr.or.ddit.vo.corporate.notice.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	
	@Autowired
	private AdminNoticeService noticeService;
	
	@GetMapping("/list")
	public String noticeList(Model model) {
		log.info("관리자 noticeList() 실행..!!");
		
		List<NoticeVO> list = noticeService.getList();
		model.addAttribute("noticeList", list);
		
		return "admin/notice/noticeList";
	}
	
	@GetMapping("/detail")
	public String noticeDetail(@RequestParam int id, Model model) {
		log.info("관리자 noticeDetail() 실행..!!");
		
		NoticeVO noticeVO = null;
		noticeVO = noticeService.getDetail(id);
		model.addAttribute("noticeVO",noticeVO);
		
		return "admin/notice/noticeDetail";
	}
	
	@GetMapping("/form")
	public String noticeUpdateForm(@RequestParam int id, Model model) {
		log.info("관리자 noticeUpdateForm() 실행..!!");
		
		NoticeVO noticeVO = null;
		noticeVO = noticeService.getDetail(id);
		model.addAttribute("noticeVO",noticeVO);
		model.addAttribute("mode", "edit");
		
		return "admin/notice/noticeDetail";
	}
	
//	<form class="notice-form" id="noticeForm" 
//			action="${pageContext.request.contextPath}/admin/notice/save" method="post" enctype="multipart/form-data">
//	@PostMapping("/form")
//	public String noticeUpdate(NoticeVO noticeVO, Model model) {
//		log.info("noticeUpdate() 실행..!");
//		
//		noticeVO = noticeService.modNotice(id);
//		ServiceResult result = noticeService.updateNotice(noticeVO);
//		
//		return "admin/notice/noticeDetail";
//	}
	
	
	
//	@GetMapping("/search")
//	public String searchKeyword(@ModelAttribute("searchVO") NoticeSearchVO searchVO, Model model) {
//		log.info("searchKeyword() 실행..!!");
//		
//		List<NoticeVO> list = noticeService.searchKeyword(searchVO);
//		model.addAttribute("noticeList", list);
//		
//		return "corporate/notice/noticeList";
//	}
}
