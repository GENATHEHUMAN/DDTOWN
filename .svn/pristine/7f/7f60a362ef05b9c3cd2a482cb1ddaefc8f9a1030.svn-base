package kr.or.ddit.ddtown.controller.emp.artist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.emp.artist.IArtistGroupService;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/emp")
public class ArtistGroupManagementController {

		@Autowired
		private IArtistGroupService artistGroupService;
		
		@RequestMapping("/group-management")
		private String retrieveGroup(Model model) {
			log.info("아티스트 그룹 목록 페이지 요청");
			
			 // 서비스 계층을 호출하여 아티스트 그룹 목록을 가져옵니다.
	        List<ArtistGroupVO> groupList = artistGroupService.retrieveArtistGroupList();

	        // Model 객체에 조회된 그룹 목록을 추가합니다.
	        // JSP에서는 "artistGroupList"라는 이름으로 이 목록에 접근할 수 있습니다.
	        model.addAttribute("artistGroupList", groupList);

	        if (groupList != null && !groupList.isEmpty()) {
	            log.info("조회된 아티스트 그룹 수: {}", groupList.size());
	        } else {
	            log.info("조회된 아티스트 그룹이 없습니다.");
	        }

	        return "emp/group-management";
		}
}
