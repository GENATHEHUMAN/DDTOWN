package kr.or.ddit.ddtown.controller.corporate.audition;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.audition.AuditionService;
import kr.or.ddit.vo.corporate.audition.AuditionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/corporate/audition")
public class AuditionController {
	
	@Autowired
	private AuditionService auditionService;
	
	//목록 이동
	@GetMapping("/list")
	public String auditionList(Model model) {
		log.info("audition() 실행...!");
		List<AuditionVO> auditionList = auditionService.auditionList();
		
		log.info("가져온 오디션 리스트: {}", auditionList);
		model.addAttribute("auditionList", auditionList);
		return "audition/form";
	}
	//상세보기 이동
	@GetMapping("/detail.do")
	public String auditionDetail(int audiNo, Model model) {
		AuditionVO auditionVO = auditionService.detailAudition(audiNo);
		model.addAttribute("audition",auditionVO);
		return "audition/detail";
	}
	
	//지원 폼 이동
	@GetMapping("/supportForm.do")
	public String auditionSupportForm(int audiNo, Model model) {
		AuditionVO auditionVO = auditionService.detailAudition(audiNo);
		model.addAttribute("audition",auditionVO);
		return "audition/support";
	}
	
	//이메일 중복확인 요청
	public ResponseEntity<ServiceResult> emailCheck(@RequestBody Map<String, String> param){
		log.info("emailCheck->email : " + param.get("memEmail"));
		ServiceResult result = auditionService.emailCheck(param.get("memEmail"));
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	//지원하기 등록
	@PostMapping("/insert.do")
	public String auditionInsert() {
		
		return "audition/support";
	}
}
