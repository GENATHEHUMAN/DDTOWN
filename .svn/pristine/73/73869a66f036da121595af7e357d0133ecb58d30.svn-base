package kr.or.ddit.ddtown.controller.emp.post;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.ddtown.service.emp.postManagement.IPostManagementService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;
import kr.or.ddit.vo.community.CommunityPostVO;
import kr.or.ddit.vo.community.CommunityReplyVO;
import kr.or.ddit.vo.security.CustomUser;
import kr.or.ddit.vo.user.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/post")
public class PostManagementController {

	@Autowired
	private IPostManagementService postManagementService;
	
	@GetMapping("/list")
	public String postList(
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(name = "searchWord", required = false) String searchWord,
            @RequestParam(name = "searchType", required = false) String searchType,
            Model model) {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        EmployeeVO memberVO = null;
        if(principal instanceof CustomUser) {
            memberVO = ((CustomUser) principal).getEmployeeVO();
        }
        
        PaginationInfoVO<CommunityPostVO> pagingVO = new PaginationInfoVO<>();
        
        if(StringUtils.isNotBlank(searchType)) {
        	pagingVO.setSearchType(searchType);
        	pagingVO.setSearchType(searchType);
        }
        
        if(StringUtils.isNotBlank(searchWord)) {
        	pagingVO.setSearchWord(searchWord);
        	pagingVO.setSearchWord(searchWord);
        }
        
        if(pagingVO.getEmpUsername() == null) {
        	pagingVO.setEmpUsername(memberVO.getEmpUsername());
        	
        }
        
        pagingVO.setCurrentPage(currentPage);
        
        List<CommunityPostVO> postList = postManagementService.getPost(pagingVO);
        
        int totalRecord = postManagementService.totalRecord(memberVO.getEmpUsername());
        
        pagingVO.setDataList(postList);
        pagingVO.setTotalRecord(totalRecord);
        
        model.addAttribute("pagingVO", pagingVO);
        
        // 아티스트 목록 가져오기
        List<ArtistVO> artistList = postManagementService.empArtistList(memberVO.getEmpUsername());
        model.addAttribute("artistList", artistList);
        
		return "emp/post/postList"; 
	}
	
	@GetMapping("/detail/{comuPostNo}")
	public String postDetail(@PathVariable int comuPostNo, Model model) {
		
		CommunityPostVO postVO = postManagementService.selectPost(comuPostNo);
		
		model.addAttribute("artistVO", postVO);
		
		return "emp/post/postDetail"; 
	}
	
	@GetMapping("/replyList/{comuPostNo}")
	public ResponseEntity<Map<Object, Object>> postReplyList(PaginationInfoVO<CommunityReplyVO> pagingVO, @PathVariable int comuPostNo){
		
		if(pagingVO.getCurrentPage() == 0) {
			pagingVO.setCurrentPage(1);
		}
		
		pagingVO.setComuPostNo(comuPostNo);
		
		List<CommunityReplyVO> replyVOList = postManagementService.postReplyList(pagingVO);
		
		int replyTotalRecord = postManagementService.replyTotalRecord(pagingVO);
		
		log.info("total : " + replyTotalRecord);
		
		pagingVO.setDataList(replyVOList);
		pagingVO.setTotalRecord(replyTotalRecord);
		
		Map<Object, Object> map = new HashMap<>();
		map.put("pagingVO", pagingVO);
		
		return new ResponseEntity<Map<Object,Object>>(map, HttpStatus.OK);
	}
}
