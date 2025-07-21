package kr.or.ddit.ddtown.controller.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.ddtown.service.community.ICommunityMainPageService;
import kr.or.ddit.ddtown.service.follow.IFollowService;
import kr.or.ddit.ddtown.service.member.membership.IMembershipService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.community.CommunityPostVO;
import kr.or.ddit.vo.community.CommunityProfileVO;
import kr.or.ddit.vo.community.CommunityVO;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityMainPageControllerTest {

	@Autowired
	private ICommunityMainPageService artistMainPageService;

	@Autowired
	private IFollowService followService;
	
	@Autowired
	private IMembershipService membershipService;

	@Value("${media.server.url}")
	private String mediaServerUrl;


	@GetMapping("/gate/{artGroupNo}/apt/api/test")
	public ResponseEntity<Map<Object, Object>> aptMain(CommunityVO communityVO) {

		Map<Object, Object> map = new HashMap<>();
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    MemberVO memberVO = null;
	    if(principal instanceof CustomUser) {
	        memberVO = ((CustomUser) principal).getMemberVO();
	    }else if(principal instanceof CustomOAuth2User) {
	        memberVO = ((CustomOAuth2User) principal).getMemberVO();
	    }

	    // 접속중인 사용자가 해당 아티스트 커뮤니티에 팔로우 하고 있는 지 여부
	    int artGroupNo = communityVO.getArtGroupNo();
	    String memUsername = "";
	    if(memberVO != null) {
	    	memUsername = memberVO.getMemUsername();
	    }
	    Map<String, Object> currentUser = new HashMap<String, Object>();
	    currentUser.put("artGroupNo", artGroupNo);
	    currentUser.put("memUsername", memUsername);

	    CommunityProfileVO currentUserComu = artistMainPageService.currentUserComufollowing(currentUser);

	    // 해당 커뮤니티에 팔로우가 되어 있지 않다면
	    if(currentUserComu == null) {
	    	map.put("followFlag", "N");
	    	communityVO.setMyComuProfileNo(0);
	    }else {
	    	map.put("followFlag", "Y");
	    	map.put("userProfile", currentUserComu);
	    	communityVO.setMyComuProfileNo(currentUserComu.getComuProfileNo());
	    }

		PaginationInfoVO<CommunityVO> pagingVO = new PaginationInfoVO<>();
		int page = communityVO.getPage();

		if(StringUtils.isNotBlank(communityVO.getSearchWord())) {
			pagingVO.setSearchWord(communityVO.getSearchWord());
		}
		if(StringUtils.isNotBlank(communityVO.getSearchType())) {
			pagingVO.setSearchType(communityVO.getSearchType());
		}

		pagingVO.setCurrentPage(page);
		communityVO.setStartRow(pagingVO.getStartRow());
		communityVO.setEndRow(pagingVO.getEndRow());

		List<CommunityPostVO> postVO = null;
		int totalRecord = 0;
		String currentPost = "";

		if(communityVO.isArtistTabYn()) {
			communityVO.setBoardTypeCode("ARTIST_BOARD");
			postVO = artistMainPageService.getPostList(communityVO);
			totalRecord = artistMainPageService.getPostTotal(communityVO);
			map.put("artistPostVO", postVO);
			map.put("fanPostVO", new CommunityVO());
			currentPost = "artist";
			log.info("현재 탭 : " + currentPost);
			log.info("게시물 정보 : " + postVO);
		}else {
			communityVO.setBoardTypeCode("FAN_BOARD");
			postVO = artistMainPageService.getPostList(communityVO);
			totalRecord = artistMainPageService.getPostTotal(communityVO);
			map.put("fanPostVO", postVO);
			map.put("artistPostVO", new CommunityVO());
			currentPost = "fan";
			log.info("현재 탭 : " + currentPost);
			log.info("게시물 정보 : " + postVO);
		}

		if(postVO != null && totalRecord > 0) {
			pagingVO.setTotalRecord(totalRecord);
		}else {
			pagingVO.setTotalRecord(0);
		}
		
		ArtistGroupVO artistGroupVO = artistMainPageService.getCommunityInfo(communityVO.getArtGroupNo());

		map.put("pagingVO", pagingVO);
		
		map.put("tab", communityVO.isArtistTabYn());
		
		map.put("artistGroupVO", artistGroupVO);
		
		return new ResponseEntity<Map<Object,Object>>(map, HttpStatus.OK);
	}
	
//	@GetMapping("/worldcup/test")
//	public String worldCupPage() {
//		
//		return "community/worldcupTest";
//	}
//	
//	@GetMapping("/worldcup/artist/list")
//	public ResponseEntity<List<ArtistVO>> artistList(){
//		
//		List<ArtistVO> artistList = artistMainPageService.artistList();
//		
//		return new ResponseEntity<List<ArtistVO>>(artistList, HttpStatus.OK);
//	}
//	
//	@PostMapping("/worldcup/insert")
//	public ResponseEntity<Map<Object, Object>> worldCupWinner(WorldcupVO worldcupVO){
//		
//		log.info("artNo : " + worldcupVO.getArtNo());
//		
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//	    MemberVO memberVO = null;
//	    if(principal instanceof CustomUser) {
//	        memberVO = ((CustomUser) principal).getMemberVO();
//	    }else if(principal instanceof CustomOAuth2User) {
//	        memberVO = ((CustomOAuth2User) principal).getMemberVO();
//	    }
//	    
//	    worldcupVO.setMemUsername(memberVO.getMemUsername());
//	    
//	    ServiceResult result = artistMainPageService.worldcupWinner(worldcupVO);
//	    
//	    List<WorldcupVO> winnerList = artistMainPageService.winnerList();
//	    
//		Map<Object, Object> map = new HashMap<>();
//		
//		map.put("result", result);
//		map.put("winnerList", winnerList);
//	    
//		return new ResponseEntity<Map<Object, Object>>(map, HttpStatus.OK);
//	}


}
