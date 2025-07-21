package kr.or.ddit.ddtown.controller.concert.schedule;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.concert.IConcertService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.concert.ConcertVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/concert/schedule")
public class ConcertScheduleController {
	
	@Autowired
	private IConcertService concertService;

	/**
	 * @param concertVO
	 * @param model
	 * @return 콘서트 일정 목록 페이지
	 */
	@GetMapping("/list")
	public String scheduleList(
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(name = "searchType", required = false) String searchType,
            @RequestParam(name = "searchWord", required = false) String searchWord,
            Model model) {
		log.info("scheduleList() 실행...!");
		
		PaginationInfoVO<ConcertVO> pagingVO = new PaginationInfoVO<>();
        pagingVO.setCurrentPage(currentPage);
		
		if(StringUtils.isNotBlank(pagingVO.getSearchWord())) {
			pagingVO.setSearchType(searchType);
            pagingVO.setSearchWord(searchWord);
			log.info("검색 조건 - Type: {}, Word: {}", pagingVO.getSearchType(), pagingVO.getSearchWord());
		}
		
		try {
			// 현재 페이지 전달 후, start/endRow, start/endPage 설정
			int totalRecord = concertService.selectConcertCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<ConcertVO> concertList = concertService.selectConcertList(pagingVO);
			pagingVO.setDataList(concertList);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "콘서트 목록을 불러오는 중 오류가 발생했습니다!!");
		}
		
		model.addAttribute("pagingVO", pagingVO);
		return "concert/schedule/list";
	}
	
	/**
	 * @param concertNo
	 * @param model
	 * @param ra
	 * @return 콘서트 상세보기 페이지
	 */
	@GetMapping("/detail/{concertNo}")
	public String scheduleDetail(@PathVariable int concertNo, Model model, RedirectAttributes ra) {
		log.info("scheduleDetail() 실행...!");
		
		try {
			ConcertVO concertVO = concertService.selectSchedule(concertNo);
			if(concertVO == null) {
				ra.addFlashAttribute("errorMessage", "해당되는 콘서트 정보 없음");
				return "redirect:/concert/schedule/list";
			}
			model.addAttribute("concertVO", concertVO);

		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "콘서트 일정 정보 불러오는중 오류 발생");
			return "redirect:/concert/schedule/list";
		}
		return "concert/schedule/detail";
	}
	
	
	/**
	 * @param model
	 * @return 콘서트 등록 페이지
	 */
	@GetMapping("/form")
	public String scheduleRegisterForm(Model model, RedirectAttributes ra) {
		log.info("scheduleRegisterForm() 실행...!");
		
		model.addAttribute("concertVO", new ConcertVO());
		return "concert/schedule/form";
	}
	
	
	/**
	 * @param concertVO
	 * @param ra
	 * @param model
	 * @return 콘서트 일정 등록 처리
	 */
	@PostMapping("/insert")
	public String scheduleInsert(
			@ModelAttribute ConcertVO concertVO,
			RedirectAttributes ra,
			Model model
			) {
		log.info("scheduleInsert() 실행...!");
		String goPage = "";
		// 유효성검사
		if(StringUtils.isBlank(concertVO.getConcertNm())) {
			model.addAttribute("errorMessage", "콘서트 제목을 입력해주세요!!");
			model.addAttribute("concertVO", concertVO);
			return "concert/schedule/form";
		}
		
		try {
			ServiceResult result = ServiceResult.OK;
			
			if(result.equals(ServiceResult.OK) && concertVO.getConcertNo() > 0) {
				ra.addFlashAttribute("successMessage", "콘서트 일정 등록 성공!!");
				String redirectUrl = "/concert/schedule/detail/" + concertVO.getConcertNo();
			    log.info("등록 성공 후 리다이렉트 URL: {}", redirectUrl); 	// URL 확인
			    goPage = "redirect:" + redirectUrl;
			} else {
				model.addAttribute("errorMessage", "콘서트 일정 등록 실패!!");
				model.addAttribute("concertVO", concertVO);
				goPage = "concert/schedule/form";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "시스템오류, 콘서트 일정 등록 실패!!");
			model.addAttribute("concertVO", concertVO);
			goPage = "concert/schedule/form";
		}
		
		return goPage;
	}
	
	
	/**
	 * @param concertNo
	 * @param model
	 * @param ra
	 * @return 콘서트 일정 수정 폼
	 */
	@GetMapping("/mod/{concertNo}")
	public String scheduleModForm(@PathVariable int concertNo, Model model, RedirectAttributes ra) {
		log.info("scheduleModForm() 실행...!");
		
		try {
			ConcertVO concertVO = concertService.selectSchedule(concertNo);
			if(concertVO == null) {
				ra.addFlashAttribute("errorMessage", "수정할 콘서트 일정 찾을수 없음");
				return "redirect:/concert/schedule/list";
			}
			
			model.addAttribute("concertVO", concertVO);
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "콘서트 일정 불러오는중 오류발생");
			return "redirect:/concert/schedule/list";
		}
		
		return "concert/schedule/mod";
	}
	
	/**
	 * @param concertNo
	 * @param concertVO
	 * @param ra
	 * @param model
	 * @return 콘서트 일정 수정 처리
	 */
	@PostMapping("/mod/{concertNo}")
	public String scheduleMod(
			@PathVariable int concertNo,
			@ModelAttribute ConcertVO concertVO,
			RedirectAttributes ra,
			Model model
			) {
		log.info("scheduleMod() 실행...!");
		String goPage = "";
		
		concertVO.setConcertNo(concertNo);
		
		if(StringUtils.isBlank(concertVO.getConcertNm())) {
			model.addAttribute("errorMessage", "콘서트 제목을 입력해주세요!!");
			model.addAttribute("concertVO", concertVO);
			return "concert/schedule/mod";
		}
		
		try {
			ServiceResult result = concertService.updateSchedule(concertVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("successMessage", "콘서트 일정 수정 성공!!");
				goPage = "redirect:/concert/schedule/detail/" + concertNo;
			} else {
				ra.addFlashAttribute("errorMessage", "콘서트 일정 수정 실패!!");
				model.addAttribute("concertVO", concertVO);
				goPage = "concert/schedule/mod";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "시스템오류, 콘서트 일정 수정 실패!!");
			model.addAttribute("concertVO", concertVO);
			goPage = "concert/schedule/mod";
		}
		return goPage;
	}
	
	/**
	 * @param concertNo
	 * @param ra
	 * @return 콘서트 일정 삭제 처리 -> 콘서트 일정 목록 페이지
	 */
	@PostMapping("/delete/{concertNo}")
	public String scheduleDelete(@PathVariable int concertNo, RedirectAttributes ra) {
		log.info("scheduleDelete() 실행...!");
		
		try {
			ServiceResult result = concertService.deleteSchedule(concertNo);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("successMessage", "콘서트 일정 삭제 성공!!");
			} else {
				ra.addFlashAttribute("errorMessage", "콘서트 일정 삭제 실패!!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "시스템오류, 콘서트 일정 삭제 실패!!");
		}
		return "redirect:/concert/schedule/list";
	}
}
