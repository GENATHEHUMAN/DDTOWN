package kr.or.ddit.ddtown.controller.concert;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.or.ddit.ddtown.service.concert.IConcertService;
import kr.or.ddit.vo.concert.ConcertVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/concert")
public class ConcertController {
	
	@Autowired
	private IConcertService concertService;

	@GetMapping("/schedule")
	public String concertList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
		log.info("concertListPage() 실행...!");
		
		
		
		try {
			Map<String, Object> params = new HashMap<>();
			
			List<ConcertVO> concertList = concertService.getConcertList(params);
			int totalCnt = concertService.getConcertCount(params);
			
			model.addAttribute("concertList", concertList);
			model.addAttribute("totalCnt", totalCnt);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "콘서트 목록을 불러오는 중 오류가 발생했습니다!!");
		}
		return "concert/concertScheduleList";
	}
	
	@GetMapping("/schedule/new")
	public String newConcertSchedule(Model model) {
		log.info("newConcertSchedule() 실행...!");
		model.addAttribute("concertVO", new ConcertVO());
		return "concert/concertScheduleForm";
	}
	
	@PostMapping("/schedule/new")
	public String createConcertSchedule(@ModelAttribute ConcertVO concertVO, RedirectAttributes ra) {
		log.info("createConcertSchedule() 실행...!");
		
		try {
            boolean success = concertService.createConcert(concertVO);
            if (success) {	// 일정 등록 성공
                ra.addFlashAttribute("successMessage", "새로운 콘서트 일정이 성공적으로 등록되었습니다.");
                return "redirect:/concert/schedule";
            } else {		// 일정 등록 실패
                log.warn("콘서트 일정 등록 실패 (결과: false): {}", concertVO.getConcertNm());
                ra.addFlashAttribute("errorMessage", "콘서트 일정 등록에 실패했습니다.");
                return "redirect:/concert/schedule/new"; // 작성폼으로 다시
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("errorMessage", "오류 발생: " + e.getMessage());
            return "redirect:/concert/schedule/new";	// 작성폼으로 다시
        }
	}
	
	@GetMapping("/schedule/edit/{concertNo}")
	public String editConcertScheduleForm(@PathVariable("concertNo") int concertNo, Model model) {
	    log.info("editConcertScheduleForm() 실행...!");
	    try {
			ConcertVO concertVO = concertService.getConcertByNo(concertNo); 
			if(concertVO == null) {
				log.warn("수정할 콘서트가 없습니다!! (번호: {})", concertNo);
				model.addAttribute("errorMessage", "해당 콘서트 정보를 찾을수없음!!");
				return "redirect:/concert/schedule";
			}
			model.addAttribute("concertVO", concertVO);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "콘서트 정보를 가져오는중 오류발생!!!");
			return "redirect:/concert/schedule";
		}
		return "concert/concertScheduleEditForm";
	}
	
}
