package kr.or.ddit.ddtown.controller.admin.inquiry;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.admin.faqInquiry.IAdminFaqService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.faq.FaqVO;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/admin/faq")
public class AdminFaqController {

	@Autowired
	private IAdminFaqService faqService;
	
	@GetMapping("/list")
	public ResponseEntity<Map<Object, Object>> faqMainList(FaqVO faqVO, String searchCode){
		
		log.info("FAQ 목록 호출 중...");
		
		log.info("요청중...faqVO : "+ faqVO);
		/*
		 * log.info("요청중...faqVO : ", faqVO.getSearchType()); log.info("요청중...faqVO : ",
		 * faqVO.getSearchWord());
		 */
		
		PaginationInfoVO<FaqVO> pagingVO = new PaginationInfoVO<>();
		
		int currentPage = faqVO.getPage();
		String searchWord = faqVO.getSearchWord();
		String searchType = faqVO.getSearchType();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
		}
		
		if(StringUtils.isNotBlank(searchType)) {
			pagingVO.setSearchType(searchType);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		Map<Object, Object> map = faqService.faqAdminMain(pagingVO, searchCode);
		map.put("searchCode", searchCode);
		
		return new ResponseEntity<Map<Object, Object>>(map, HttpStatus.OK);
	}
	
	@GetMapping("/detailData/{faqNo}")
	public ResponseEntity<FaqVO> faqDetail(@PathVariable int faqNo){
		
		FaqVO faqVO = faqService.getFaqDetail(faqNo);
		
		
		return new ResponseEntity<FaqVO>(faqVO,HttpStatus.OK);
	}
	
	@PostMapping("/updateData/{faqNo}")
	public ResponseEntity<ServiceResult> updateData(FaqVO faqVO){
		
		ServiceResult result = null;
		
		log.info("FAQ 수정 중...");
		
		log.info("faqVO : " + faqVO);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        EmployeeVO memberVO = null;
        if(principal instanceof CustomUser) {
        	memberVO = ((CustomUser) principal).getEmployeeVO();
        }
		
        faqVO.setEmpUsername(memberVO.getEmpUsername());
        
        result = faqService.updateData(faqVO);
        
		return new ResponseEntity<ServiceResult>(result,HttpStatus.OK);
	}
	
	@PostMapping("/insert")
	public ResponseEntity<ServiceResult> insertData(FaqVO faqVO){
		
		ServiceResult result = null;
		
		log.info("FAQ 등록 중...");
		
		log.info("faqVO : " + faqVO);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        EmployeeVO memberVO = null;
        if(principal instanceof CustomUser) {
        	memberVO = ((CustomUser) principal).getEmployeeVO();
        }
		
        faqVO.setEmpUsername(memberVO.getEmpUsername());
        
        result = faqService.faqInsert(faqVO);
        
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PostMapping("/delete/{faqNo}")
	public ResponseEntity<ServiceResult> deleteData(@PathVariable int faqNo){
		log.info("FAQ 삭제 중...");
		
		ServiceResult result = faqService.deleteData(faqNo);
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
}
