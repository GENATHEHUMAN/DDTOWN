package kr.or.ddit.ddtown.controller.emp.concert;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.concert.ISeatService;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.concert.ConcertVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/concert")
public class EmpConcertSeatController {

	@Autowired
	private ISeatService seatService;

	@GetMapping("/seat")
	public String empConcertSeatManagement(Model model) {
		List<ConcertVO> concertList = seatService.selectConcertList();

		// 모달창에 넣을 좌석 등급 정보 가져오기
		List<CommonCodeDetailVO> gradeList = seatService.selectGradeList();


		model.addAttribute("concertList", concertList);
		model.addAttribute("gradeList", gradeList);
		return "emp/concert/seat_management";
	}

}
