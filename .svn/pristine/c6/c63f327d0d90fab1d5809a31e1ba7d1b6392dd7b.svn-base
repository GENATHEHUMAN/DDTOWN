package kr.or.ddit.ddtown.controller.admin.artist;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.admin.artist.IAdminArtistService;
import kr.or.ddit.ddtown.service.stat.IStatService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;
import kr.or.ddit.vo.community.CommunityPostVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/community/artist")
public class AdminArtistController {

	@Autowired
	private IAdminArtistService artistService;

	@Autowired
	private IStatService statService;

	@GetMapping("/list")
	public String artistList(
			@RequestParam(defaultValue = "1", required = true) int currentPage,
			@RequestParam(required = false, defaultValue = "artist") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue="all") String artDelYn,
			Model model) {
		PaginationInfoVO<ArtistVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchType(searchType);
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
		}
		int totalRecord = artistService.getTotalRecord(pagingVO, artDelYn);
		pagingVO.setTotalRecord(totalRecord);
		List<ArtistVO> artistList = artistService.getArtistList(pagingVO, artDelYn);
		pagingVO.setDataList(artistList);

		Map<String, Object> summaryMap = artistService.selectSummaryMap();
		Set<String> keySet = summaryMap.keySet();
		Iterator<String> iteKey = keySet.iterator();
		while(iteKey.hasNext()) {
			String key = iteKey.next();
			log.info("key : {}, value : {}",key, summaryMap.get(key));
		}
		log.info("pagingVO : {}", pagingVO);
		model.addAttribute("summaryMap", summaryMap);
		model.addAttribute("pagingVO", pagingVO);
		return "admin/artist/artistList";
	}

	@GetMapping("/detail")
	public String artistDetail(@RequestParam int artNo, Model model) {
		ArtistVO artistVO = artistService.getArtistDetail(artNo);
		log.info("artistVO : {}", artistVO);

		List<goodsVO> memberGoodsStat = statService.getMemberGoodsStat(artNo);
		List<CommunityPostVO> mostLikePostStat = statService.getMostLikePostStat(artNo);
		log.info("memberGoodsStat : {}",memberGoodsStat);

		model.addAttribute("artistVO", artistVO);
		model.addAttribute("memberGoods", memberGoodsStat);
		model.addAttribute("hotPost", mostLikePostStat);
		return "admin/artist/artistDetail";
	}

	@GetMapping("/form")
	public String artistForm() {
		return "admin/artist/artistForm";
	}

	@GetMapping("/update")
	public String artistUpdateForm(@RequestParam int artNo,Model model) {
		Map<String, Object> map = new HashMap<>();
		ArtistVO artistVO = artistService.getArtistDetail(artNo);
		log.info("artistVO : {}",artistVO);
		map.put("status", "U");
		map.put("artistVO", artistVO);
		model.addAttribute("data", map);
		return "admin/artist/artistForm";
	}

	@PostMapping("/update")
	public String artistUpdate(ArtistVO artistVO, Model model) {
		log.info("artistVO : {}", artistVO);
		String path = "";
		Map<String, Object> map = new HashMap<>();
		ServiceResult result = artistService.updateArtist(artistVO);
		if(ServiceResult.OK.equals(result)) {
			path = "redirect:/admin/community/artist/detail?artNo="+artistVO.getArtNo();
		}else {
			map.put("status", "U");
			map.put("artistVO", artistVO);
			model.addAttribute("data", map);
			path = "/admin/artist/artistForm";
		}
		return path;
	}

	@PostMapping("/register")
	public String artistRegister(ArtistVO artistVO, Model model) {
		log.info("artistVO : {}", artistVO);
		String path = "";
		ServiceResult result = artistService.registArtist(artistVO);
		if(ServiceResult.OK.equals(result)) {
			path = "redirect:/admin/community/artist/detail?artNo="+artistVO.getArtNo();
		}else {
			model.addAttribute("artistVO", artistVO);
			path = "/admin/artist/artistForm";
		}
		return path;
	}

	@PostMapping("/deleteArtist")
	public String artistDelete(ArtistVO artistVO, RedirectAttributes ra) {
		log.info("artistVO : {}",artistVO);
		String path = "";
		ServiceResult result = artistService.deleteArtist(artistVO);
		if(ServiceResult.OK.equals(result)) {
			path = "redirect:/admin/community/artist/list";
		}else {
			ra.addFlashAttribute("msg", "삭제 처리실패");
			path = "redirect:/admin/community/artist/detail?artNo="+artistVO.getArtNo();
		}
		return path;
	}
}
