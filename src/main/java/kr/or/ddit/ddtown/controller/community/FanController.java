package kr.or.ddit.ddtown.controller.community;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class FanController {

	
	@GetMapping("/fan.do")
	public String fanCommunity() {	
		return "community/fan";
	}
	
}
