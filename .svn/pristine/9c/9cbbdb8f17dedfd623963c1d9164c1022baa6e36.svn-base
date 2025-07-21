package kr.or.ddit.ddtown.controller.admin.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.inquiry.IAdminInquiryService;
import kr.or.ddit.vo.inquiry.InquiryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/inquiry")
public class AdminInquiryController {

	@Autowired
	private IAdminInquiryService adminInquiryService;
	
	@GetMapping("/list")
	public ResponseEntity<List<InquiryVO>> inquiryList(){
		
		log.info("리스트 목록 가져오는 중...");
		
		List<InquiryVO> list = adminInquiryService.getList();
		
		return new ResponseEntity<List<InquiryVO>>(list, HttpStatus.OK);
	}
	
}
