package kr.or.ddit.ddtown.controller.emp.live;

import java.security.Principal;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.community.ICommunityMainPageService;
import kr.or.ddit.ddtown.service.emp.artist.IArtistGroupService;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.live.LiveVO;

@Controller
@RequestMapping("/emp/live")
public class LiveManagementController {

	@Autowired
	private IArtistGroupService artistGroupService;

	@Autowired
	private ICommunityMainPageService communityMainService;

	@Value("${media.server.url}")
	private String mediaServerUrl;

	@GetMapping("/main")
	public String liveMain(
			Model model,
			Principal principal) {

		String empUsername = principal.getName();
		List<ArtistGroupVO> managedGroupList = artistGroupService.retrieveArtistGroupList(empUsername);

		if (managedGroupList != null && !managedGroupList.isEmpty()) {
			ArtistGroupVO managedGroup = managedGroupList.get(0);
			int artGroupNo2 = managedGroup.getArtGroupNo();

			LiveVO currentLive = communityMainService.getLiveBroadcastInfo(artGroupNo2);
			if (currentLive != null) {
				model.addAttribute("currentLive", currentLive);
			}

			List<LiveVO> historyList = communityMainService.getLiveHistory(artGroupNo2);
			model.addAttribute("historyList", historyList);

			model.addAttribute("managedArtGroupNo", artGroupNo2);
		} else {
			model.addAttribute("managedArtGroupNo", 0);
			model.addAttribute("historyList", Collections.emptyList()); 
		}
		model.addAttribute("mediaServerUrl", mediaServerUrl);
		return "emp/live/liveManagement";
	}

}
