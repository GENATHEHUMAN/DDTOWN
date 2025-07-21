package kr.or.ddit.ddtown.controller.emp.membership;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.ddtown.service.member.membership.IMembershipService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.member.membership.MembershipSubscriptionsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/membership/sub")
public class MembershipSubController {
	
	@Autowired
	private IMembershipService membershipService;
	
	@GetMapping("/list")
	public String membershipSubList(
			@RequestParam(name = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "searchWord", required = false) String searchWord,
			@RequestParam(name = "mbspSubStatCode", required = false) String mbspSubStatCode,
			Principal principal,
			Model model
			) {
		log.info("직원 멤버십 구독자 목록 요청");
		
		PaginationInfoVO<MembershipSubscriptionsVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSearchWord(searchWord);
		
		String empUsername = principal.getName();
		log.info("로그인한 직원 ID: {}",empUsername);
		
		try {
			
			int artGroupNo = membershipService.selectArtGroupNo(empUsername);
			Map<String, Integer> subCounts = membershipService.selectMembershipSubCounts(artGroupNo);
			model.addAttribute("subCounts", subCounts);
			
			int totalRecord = membershipService.selectTotalRecord(pagingVO, empUsername, mbspSubStatCode);
			pagingVO.setTotalRecord(totalRecord);
			
			log.info("totalRecord : {}", totalRecord);
			
			List<MembershipSubscriptionsVO> list = membershipService.selectMembershipSubList(
					pagingVO, empUsername, mbspSubStatCode);
			
			log.info("list {}: ", list.size());
			
			pagingVO.setDataList(list);
			model.addAttribute("pagingVO", pagingVO);
			model.addAttribute("mbspSubStatCode", mbspSubStatCode);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "emp/membership/sub/list";
	}
	
	@GetMapping(value = "/chartData/monthlySignups", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<MembershipSubscriptionsVO> getMonthlySignupsChartData() {
		return membershipService.getMonthlySignups();
	}
	
	@GetMapping(value = "/chartData/topPayingUsers", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<MembershipSubscriptionsVO> getTopPayingUsersChartData(Principal principal) {
		
		String empUsername = principal.getName();
		int artGroupNo = membershipService.selectArtGroupNo(empUsername);
		
		return membershipService.getTopPayingUsers(artGroupNo);
	}
}
