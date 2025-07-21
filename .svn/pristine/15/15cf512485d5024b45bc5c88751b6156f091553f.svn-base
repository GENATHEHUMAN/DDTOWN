package kr.or.ddit.ddtown.controller.community;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.ddtown.service.community.ICommunityMainPageService;
import kr.or.ddit.ddtown.service.follow.IFollowService;
import kr.or.ddit.ddtown.service.member.membership.IMembershipService;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.community.CommunityProfileVO;
import kr.or.ddit.vo.community.CommunityVO;
import kr.or.ddit.vo.security.CustomOAuth2User;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityViewController {

	@Autowired
	private ICommunityMainPageService artistMainPageService;

	@Autowired
	private IFollowService followService;
	
	@Autowired
	private IMembershipService membershipService;

	@Value("${media.server.url}")
	private String mediaServerUrl;
	
	@GetMapping("/gate/{artGroupNo}/apt/test")
	public String aptMain(CommunityVO communityVO,Model model) {

		log.info("아티스트 그룹 번호 & 페이징네이션 : " + communityVO);

		// 접속중인 사용자 정보 가져오기
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
	    	model.addAttribute("followFlag", "N");
	    	communityVO.setMyComuProfileNo(0);
	    }else {
	    	model.addAttribute("followFlag", "Y");
	    	model.addAttribute("userProfile", currentUserComu);
	    	communityVO.setMyComuProfileNo(currentUserComu.getComuProfileNo());
	    }
	    
	    // 멤버십 권한 확인 로직 추가
	    boolean hasMembership = false;
	    if(memUsername != null && !memUsername.isEmpty()) {
	    	try {
	    		hasMembership = membershipService.hasValidMembershipSubscription(memUsername, artGroupNo);
	    		log.info("사용자 {}의 아티스트 그룹 {} 멤버십 여부: {}", memUsername, artGroupNo, hasMembership);
	    	}catch (Exception e) {
				log.error("멤버십 구독 여부 확인 중 오류 발생: {}", e.getMessage());
				hasMembership = false;
			}
	    }
	    model.addAttribute("hasMembership", hasMembership);


		ArtistGroupVO artistGroupVO = artistMainPageService.getCommunityInfo(communityVO.getArtGroupNo());

		Integer membershipGoodsNo = artistMainPageService.getMembershipGoodsNo(artGroupNo);
		artistGroupVO.setMembershipGoodsNo(membershipGoodsNo);
		
		log.info("communityVO : " + artistGroupVO);

		Map<Object, Object> codeListMap = artistMainPageService.getCodeDetail();
		ObjectMapper objectMapper = new ObjectMapper();
		String codeMap = null;
		try {
			codeMap = objectMapper.writeValueAsString(codeListMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		// ✅ Model에 미디어 서버 주소를 담기
        model.addAttribute("mediaServerUrl", mediaServerUrl);

		model.addAttribute("artistGroupVO", artistGroupVO);
		// 요청 파라미터 다시 보내주기
		model.addAttribute("communityVO", communityVO);
		model.addAttribute("codeMap", codeMap);
		
		return "community/apt/test";
	}
}
