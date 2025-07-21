package kr.or.ddit.ddtown.controller.emp.audition;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.emp.audition.IEmpAuditionService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.audition.AuditionUserVO;
import kr.or.ddit.vo.corporate.audition.AuditionVO;
import kr.or.ddit.vo.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/audition")
public class EmpAuditionController {

	@Autowired
	private IEmpAuditionService empAuditionService;

	private String getCurrentEmpUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			if (customUser.getEmployeeVO() != null) {
				return customUser.getEmployeeVO().getEmpUsername();
			}
		}
		return null;
	}

	// 일정목록 이동
	@GetMapping("/schedule")
	public String auditionList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
            @RequestParam(name = "searchType", required = false, defaultValue = "all") String searchType,			//드롭박스
            @RequestParam(name = "searchWord", required = false, defaultValue = "") String searchWord,				//검색창
            @RequestParam(name = "badgeSearchType", required = false, defaultValue = "") String badgeSearchType,	//뱃지
			Model model) {
		log.info("currentPage: {}, searchType: {}, searchWord: {}, badgeSearchType: {}", currentPage, searchType, searchWord, badgeSearchType);
		PaginationInfoVO<AuditionVO> pagingVO = new PaginationInfoVO<>();
		
		pagingVO.setSearchType(searchType);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setBadgeSearchType(badgeSearchType);

		//검색 후 목록 페이지로 이동 할 때		
		pagingVO.setCurrentPage(currentPage);
		
		//"총 오디션" 수를 위한 파라미터 맵 생성(검색영향X)
	    Map<String, Object> totalCountParams = new HashMap<>();
	    int totalAuditionCount = empAuditionService.totalReportCount(totalCountParams);
		
		int totalRecord = empAuditionService.selectAuditionCount(pagingVO);	//총 게시글 수
		pagingVO.setTotalRecord(totalRecord);	//총 게시글 수 전달 후, 총 페이지 수 설정
		//페이징 관련
		int fixedScreenSize = 10;
		
		int startRow = (currentPage - 1) * fixedScreenSize + 1;
	    int endRow = currentPage * fixedScreenSize;
		pagingVO.setStartRow(startRow); // 계산된 startRow 설정
	    pagingVO.setEndRow(endRow);     // 계산된 endRow 설정	 
		
		//오디션 진행상테 현황 수
		Map<String, Integer> auditionStatCnts = empAuditionService.auditionStatCnts();
		
		log.info("audition() 실행...!");
		List<AuditionVO> EmpauditionList = empAuditionService.auditionList(pagingVO);
		pagingVO.setDataList(EmpauditionList);

		log.info("가져온 오디션 리스트: {}", EmpauditionList);
		log.info("컨트롤러: JSP로 전달되는 auditionStatCnts: {}", auditionStatCnts);
		model.addAttribute("auditionList", EmpauditionList);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("searchType", searchType);
        model.addAttribute("searchWord", searchWord);
        model.addAttribute("badgeSearchType", badgeSearchType);
		model.addAttribute("auditionStatCnts", auditionStatCnts);
		model.addAttribute("totalAuditionCount", totalAuditionCount);

		return "emp/audition/schedule/list";
	}

	// 일정 상세보기
	@GetMapping("/detail.do")
	public String auditionDetail(int audiNo, Model model) {
		AuditionVO auditionVO = empAuditionService.detailAudition(audiNo);
		model.addAttribute("audition", auditionVO);
		return "emp/audition/schedule/detail";
	}

	// 등록페이지 이동
	@GetMapping("/form.do")
	public String auditionForm() {
		return "emp/audition/schedule/form";
	}

	//일정 등록하기
	@PostMapping("/insert.do")
	public String auditionInsert(AuditionVO auditionVO, Model model, RedirectAttributes ra, Principal principal) {
		
		
		log.info("----------------------------------- insert start");
		log.info(auditionVO.toString());
		log.info("----------------------------------- insert end");
		
		String goPage = "";
		//직원 아이디 불러오기
		String empUsername = principal.getName();
		log.info("auditionInsert->empUsername : {}", empUsername);
		
		auditionVO.setEmpUsername(empUsername);

		log.info("register->auditionVO : {}", auditionVO);
		//유효성 검사를 위한 에러맵 생성
		Map<String, String> errors = new HashMap<>();
		if (StringUtils.isBlank(auditionVO.getAudiTitle())) {
			errors.put("ApplicantNm", "제목을 입력해주세요!");
		}
		if (StringUtils.isBlank(auditionVO.getAudiContent())) {
			errors.put("ApplicantNm", "제목을 입력해주세요!");
		}
		//유효성 검사에서 에러가 있다면 실행
		if (errors.size() > 0) { // 실패
			model.addAttribute("errors", errors);
			model.addAttribute("auditionVO", auditionVO);
			goPage = "redirect:/emp/audition/form.do";
		} else {	//에러가 없다면
			ServiceResult result;
			try {
				result = empAuditionService.insertAudition(auditionVO);

				if (result.equals(ServiceResult.OK)) {			//성공시
					ra.addFlashAttribute("message", "오디션 일정이 등록되었습니다.");
					goPage = "redirect:/emp/audition/schedule";
				} else {										//실패시
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					model.addAttribute("audition", auditionVO);
					goPage = "/emp/audition/form.do";
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("Message", "데이터 처리 중 서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요!");
				model.addAttribute("auditionVO", auditionVO);
				goPage = "redirect:/emp/audition/form.do"; // 등록 페이지로 이동
			}

		}
		return goPage;
	}

	// 수정하기 이동
	@GetMapping("/updateForm.do")
	public String auditionUpdate(int audiNo, Model model) {
		AuditionVO auditionVO = empAuditionService.detailAudition(audiNo);
		model.addAttribute("audition", auditionVO);
		model.addAttribute("status", "u");
		return "emp/audition/schedule/mod";
	}
	//오디션 수정하기
	@PostMapping("/update.do")
	public String auditionupdate(AuditionVO auditionVO, Model model, RedirectAttributes ra, Principal principal)
			throws Exception {
		
		
		log.info("----------------------------------- update start");
		log.info(auditionVO.toString());
		log.info("----------------------------------- update end");

		String goPage = "";
		// 현재 로그인한 직원 아이디 불러오기
		String empUsername = principal.getName();
		log.info("auditionInsert->empUsername : {}", empUsername);

		auditionVO.setEmpUsername(empUsername);

		log.info("register->auditionVO : {}", auditionVO);
		ServiceResult result = empAuditionService.updateAudition(auditionVO);
		if (result.equals(ServiceResult.OK)) {				//성공시
			ra.addFlashAttribute("message", " 수정이 완료 되었습니다!");
			goPage = "redirect:/emp/audition/detail.do?audiNo=" + auditionVO.getAudiNo();
		} else {											//실패시
			model.addAttribute("message", "수정에 실패하였습니다! 다시 시도해주세요...!");
			model.addAttribute("auditionVO", auditionVO);
			goPage = "/emp/audition/updateForm.do";
		}
		return goPage;
	}
	
	// 오디션 일정 삭제하기
	@PostMapping("/delete.do")
	public String auditionDelete(int audiNo, Model model, RedirectAttributes ra) {
		String goPage = "";
		ServiceResult result = empAuditionService.deleteAudition(audiNo);
		if (result.equals(ServiceResult.OK)) {// 삭제완료
			ra.addFlashAttribute("message", "삭제가 완료되었습니다!");
			goPage = "redirect:/emp/audition/schedule";
		} else { // 삭제 실패
			ra.addFlashAttribute("message", "서버오류, 다시 시도해주세요!");
			goPage = "redirect:/emp/audition/detail.do?audiNo=" + audiNo;
		}
		return goPage;
	}
	
	/**
	 * 지원자 정보 매핑
	 * 
	 * @return
	 */
	 @GetMapping("/applicant") public String applicantList(
			 @RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			 @RequestParam(name = "searchType", required = false, defaultValue = "all") String searchType,			//오디션 선택 드롭박스
//			 @RequestParam(name = "searchCode", required = false, defaultValue = "all") String searchCode,
		  	 @RequestParam(name = "searchWord", required = false, defaultValue = "") String searchWord,						//검색부분
		  	 @RequestParam(name = "auditionStatusCode", required = false, defaultValue = "all") String auditionStatusCode,	//탭 부분
		  	 @RequestParam(name = "badgeSearchType", required = false, defaultValue = "all") String badgeSearchType,		//뱃지 부분
			 Model model) {
		 
		 log.info("currentPage: {}, searchType: {}, searchWord: {}", currentPage, searchType, searchWord);
		 log.info("auditionStatusCode (audiStatCode): {}", auditionStatusCode);
		 
		 
		 PaginationInfoVO<AuditionUserVO> pagingVO = new PaginationInfoVO<>();
		 
		 pagingVO.setSearchType(searchType);
//		 pagingVO.setSearchCode(searchCode);
		 pagingVO.setSearchWord(searchWord);
		 pagingVO.setAuditionStatusCode(auditionStatusCode);
		 pagingVO.setBadgeSearchType(badgeSearchType);
		 
		 pagingVO.setCurrentPage(currentPage);
		 
		//"총 지원" 수를 위한 파라미터 맵 생성(검색영향X)
		 Map<String, Object> totalCountParams = new HashMap<>();
		 totalCountParams.put("auditionStatusCode", auditionStatusCode);	//탭 부분 값 반영
		 totalCountParams.put("searchType", searchType);					//오디션 선택 드롭박스 값 반영
		 int totalApplicantCount = empAuditionService.totalApplicantCount(totalCountParams);
		 
		 
		 int totalRecord = empAuditionService.auditionUserCount(pagingVO);//목록 불러오기위한 지원자 수 카운트
		 pagingVO.setTotalRecord(totalRecord);


		 int fixedScreenSize = 10;

		 int startRow = (currentPage - 1) * fixedScreenSize + 1;
		 int endRow = currentPage * fixedScreenSize;
		 pagingVO.setStartRow(startRow); // 계산된 startRow 설정
		 pagingVO.setEndRow(endRow); // 계산된 endRow 설정
		 
		 Map<String, Integer> auditionStatCount = empAuditionService.auditionStatCnts();	//오디션 상태별 수
		 
		 Map<String, Object> totalAuditionParams = new HashMap<>(); 
		 int totalAuditionCount = empAuditionService.totalReportCount(totalAuditionParams);
		 
		 //심사결과 유형별 수
		 Map<String, Integer> appStatCodeCnt = empAuditionService.appStatCodeCnt(pagingVO);
		 //지원자 목록		 
		 List<AuditionUserVO> auditionUserList = empAuditionService.auditionUserList(pagingVO);
		 pagingVO.setDataList(auditionUserList);
		 
		 log.info("가져온 지원자 리스트: {}", auditionUserList);
		 log.info("-----------------------------------------------------");
		 
		 List<AuditionVO> auditionDropdownList = empAuditionService.auditionDropdownList(auditionStatusCode);
		 
		 model.addAttribute("AuditionUserList", auditionUserList);
			model.addAttribute("pagingVO", pagingVO);
			model.addAttribute("searchType", searchType);
//			model.addAttribute("searchCode", searchCode);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("auditionStatusCode", auditionStatusCode);
			model.addAttribute("appStatCodeCnt", appStatCodeCnt);
			model.addAttribute("totalApplicantCount", totalApplicantCount);
			model.addAttribute("auditionStatCount", auditionStatCount);
			model.addAttribute("totalAuditionCount", totalAuditionCount);
			
			model.addAttribute("auditionDropdownList", auditionDropdownList);
		 
		 return "emp/audition/applicant/list"; 
	 }
	 

	
	
}
