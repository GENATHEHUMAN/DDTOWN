package kr.or.ddit.ddtown.controller.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.goods.IGoodsNoticeService;
import kr.or.ddit.ddtown.service.goods.IGoodsService;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/goods")
public class goodsController {
	
	@Autowired
	public IGoodsService service;
	
	@Autowired
	public IGoodsNoticeService noticeservice;
	
	@GetMapping("/main")
	public String goodsShopList(Model model) {
		List<goodsVO> goodsList = service.goodsList();
		model.addAttribute("goodsList", goodsList);
		
		goodsNoticeVO noticeToShow = noticeservice.getMainNotice();
		model.addAttribute("notice", noticeToShow);

		return "goods/main";
	}

}
