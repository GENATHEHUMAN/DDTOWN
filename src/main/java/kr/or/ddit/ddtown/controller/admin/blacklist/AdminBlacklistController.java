package kr.or.ddit.ddtown.controller.admin.blacklist;

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
import kr.or.ddit.ddtown.service.admin.blacklist.IBlacklistService;
import kr.or.ddit.ddtown.service.admin.report.IReportService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.blacklist.BlacklistVO;
import kr.or.ddit.vo.report.ReportVO;
import kr.or.ddit.vo.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/community/blacklist")

public class AdminBlacklistController {
	
	@Autowired
	private IBlacklistService blacklistService;
	
	@Autowired
	private IReportService reportService;
	
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
	
	@GetMapping("/list")
	public String blackListMain(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "searchCode", required = false, defaultValue = "all") String searchCode,
	        @RequestParam(name = "searchWord", required = false, defaultValue = "") String searchWord,				
	        @RequestParam(name = "badgeSearchType", required = false, defaultValue = "") String badgeSearchType,	
			Model model) {
		log.info("currentPage: {}, searchCode: {}, searchWord: {}", currentPage, searchCode, searchWord);
		
		PaginationInfoVO<BlacklistVO> pagingVO = new PaginationInfoVO<>();
		
		pagingVO.setSearchCode(searchCode);
		pagingVO.setSearchWord(searchWord);
		pagingVO.setBadgeSearchType(badgeSearchType);
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = blacklistService.selectBlacklistCount(pagingVO);	
		pagingVO.setTotalRecord(totalRecord);
		
		int fixedScreenSize = 10;
		
		int startRow = (currentPage - 1) * fixedScreenSize + 1;
	    int endRow = currentPage * fixedScreenSize;
		pagingVO.setStartRow(startRow); 
	    pagingVO.setEndRow(endRow);     	 

	  
	    Map<String, Object> totalCountParams = new HashMap<>();
	    int totalBlakcCount = blacklistService.totalBlakcCount(totalCountParams);
	    

		int blacklistCnt = blacklistService.blacklistCnt();
		 Map<String, Integer> blackReasonCnts = blacklistService.blackReasonCnts();		 
		
		log.info("blacklist() 실행...!");
		List<BlacklistVO> blackList = blacklistService.blackList(pagingVO);
		log.info("컨트롤러에서 Model에 추가할 blacklistReasonCounts: {}", blackReasonCnts);
		pagingVO.setDataList(blackList);
		
		log.info("가져온 신고 리스트: {}", blackList);
		model.addAttribute("blackList", blackList);
		model.addAttribute("pagingVO", pagingVO);
        model.addAttribute("searchCode", searchCode);
        model.addAttribute("searchWord", searchWord);
        model.addAttribute("totalBlackCount", totalRecord);
		model.addAttribute("blacklistCnt", blacklistCnt);
		model.addAttribute("blackReasonCnts", blackReasonCnts);
		model.addAttribute("badgeSearchType", badgeSearchType);
		model.addAttribute("totalBlakcCount", totalBlakcCount);

		return "admin/blacklist/blacklistList";
	}
	@GetMapping("/detail")
	public String blackListDetail(int banNo,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,	
			Model model) {
		BlacklistVO blacklistVO = blacklistService.blackDetail(banNo);
		log.info("가져온 신고자-----------------------: {}", blacklistVO);
		List<ReportVO> userReports = null;
		if(blacklistVO != null) {
			String memId = blacklistVO.getMemUsername();
			PaginationInfoVO<ReportVO> pagingVO = new PaginationInfoVO<>();
			pagingVO.setCurrentPage(currentPage);
			int totalCount = reportService.countUserReports(memId, pagingVO);
			pagingVO.setTotalRecord(totalCount);
			model.addAttribute("totalReportCount", totalCount);
			int fixedScreenSize = 10;
			
			int startRow = (currentPage - 1) * fixedScreenSize + 1;
		    int endRow = currentPage * fixedScreenSize;
			pagingVO.setStartRow(startRow);
		    pagingVO.setEndRow(endRow);     	 
			userReports = reportService.userReports(memId, pagingVO);
			model.addAttribute("pagingVO", pagingVO);
		}
		
		model.addAttribute("blacklist", blacklistVO);
		model.addAttribute("userReports", userReports);
		return "admin/blacklist/blacklistDetail";
	}
	@GetMapping("/form")
	public String blackListForm(@RequestParam(value = "reportNo", required = false) Integer  reportNo, Model model) {
		if(reportNo != null) {		
			ReportVO report = blacklistService.getReportDetail(reportNo);
			if(report != null) {	
				model.addAttribute("report", report);
			}else {
				 model.addAttribute("errorMessage", "해당 신고에 대한 회원 정보를 찾을 수 없습니다.");
			}
		}
		return "admin/blacklist/blacklistForm";
	}
	
	@PostMapping("/signup")
	public String blackListInsert(BlacklistVO blacklistVO, Model model, RedirectAttributes ra, Principal principal) {
		String goPage = "";
		String empUsername = principal.getName();
		log.info("auditionInsert->empUsername : {}", empUsername);
		blacklistVO.setEmpUsername(empUsername);
		
		log.info("register->auditionVO : {}", blacklistVO);
		Map<String, String> errors = new HashMap<>();
		
		if(StringUtils.isBlank(blacklistVO.getMemUsername())) {
			errors.put("MemUsername", "신고아이디를 입력해주세요!");
		}
		if(StringUtils.isBlank(blacklistVO.getBanReasonDetail())) {
			errors.put("BanReasonDetail", "상세내용을 입력해주세요!");
		}
		if(errors.size() > 0 ) {
			model.addAttribute("bodyText", "register-page");
			model.addAttribute("errors", errors);
			model.addAttribute("blacklistVO", blacklistVO);
			goPage = "redirect:/admin/community/blacklist/form";
		}else {		//에러가 없다면
			ServiceResult result;
			try {		
				result = blacklistService.blackSignup(blacklistVO);	
				
				log.info("=====================================================1 :{}", result);
				if(result.equals(ServiceResult.OK)) {					
					log.info("=====================================================2 ");
					ra.addFlashAttribute("message", "등록이 완료되었습니다!");
					goPage = "redirect:/admin/community/blacklist/detail?banNo="+blacklistVO.getBanNo();

				}else if(result.equals(ServiceResult.NOTEXIST)){			
					log.info("=====================================================3 ");
					ra.addFlashAttribute("message", "회원아이디가 존재하지 않습니다.");
					goPage = "redirect:/admin/community/blacklist/form";

				}else if(result.equals(ServiceResult.EXIST)){			
					log.info("=====================================================4 ");
					ra.addFlashAttribute("message", "등록 실패: 이미 블랙리스트에 등록되어 있는 사용자입니다.");
					goPage = "redirect:/admin/community/blacklist/form";

				}else {	
					log.info("=====================================================5 ");
					ra.addFlashAttribute("message", "등록 실패: 데이터 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                    goPage = "redirect:/admin/community/blacklist/form";

				}
			}catch(Exception e) {
				log.info("=====================================================6 ");
				e.printStackTrace();
				model.addAttribute("message",  "데이터 처리 중 서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요!");
				model.addAttribute("blacklistVO", blacklistVO); 
				goPage = "redirect:/admin/community/blacklist/form";
			}
		}
		log.info("=====================================================7{} ",goPage);
		return goPage;
	}
	
	
	@GetMapping("/modForm")
	public String blackListModForm(int banNo, Model model) {
		BlacklistVO blacklistVO = blacklistService.blackDetail(banNo);
		
		log.info("가져온 블랙 리스트: {}", blacklistVO);
		model.addAttribute("blacklist", blacklistVO);
		model.addAttribute("status", "u");
		return "admin/blacklist/blacklistMod";
	}

	@PostMapping("/update")
	public String blackListUpdate(BlacklistVO blacklistVO, Model model, RedirectAttributes ra, Principal principal) throws Exception{

		String goPage = "";
	
		String empUsername = principal.getName();
		log.info("auditionInsert->empUsername : {}", empUsername);
		blacklistVO.setEmpUsername(empUsername); 
		ServiceResult result = blacklistService.blackUpdate(blacklistVO);
		if(result.equals(ServiceResult.OK)) {				
			ra.addFlashAttribute("message", " 수정이 완료 되었습니다!");
			goPage = "redirect:/admin/community/blacklist/detail?banNo="+blacklistVO.getBanNo();
		}else {												
			model.addAttribute("message", "수정에 실패하였습니다! 다시 시도해주세요...!");
			model.addAttribute("auditionVO", blacklistVO);
			goPage = "redirect:/admin/community/blacklist/modForm?banNo="+blacklistVO.getBanNo();
		}
		return goPage;
	}

	@PostMapping("delete")
	public String blackListDelete(BlacklistVO blacklistVO, Model model, RedirectAttributes ra) {
		String goPage = "";
		ServiceResult result = blacklistService.blackDelete(blacklistVO);
		if(result.equals(ServiceResult.OK)) {			
			ra.addFlashAttribute("message", "해제되었습니다!");
			goPage = "redirect:/admin/community/blacklist/list";
		}else {											
			ra.addAttribute("message", "서버오류, 다시 시도해주세요!");
			goPage = "redirect:/admin/community/blacklist/detail?banNo=" + blacklistVO.getBanNo();
		}
		return goPage;
	}
	
	
}
