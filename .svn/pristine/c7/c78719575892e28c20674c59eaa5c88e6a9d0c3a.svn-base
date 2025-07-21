package kr.or.ddit.ddtown.controller.emp.group;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.ddtown.service.emp.artist.IAlbumService;
import kr.or.ddit.ddtown.service.emp.artist.IArtistGroupService;
import kr.or.ddit.ddtown.service.emp.artist.IArtistService;
import kr.or.ddit.vo.artist.AlbumVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.artist.ArtistVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/emp/group")
public class CommunityGroupManagementController {

		@Autowired
		private IArtistGroupService artistGroupService;
		
		@Autowired
		private IArtistService artistService;
		
		@Autowired
		private IAlbumService albumService;
		
		@GetMapping("/group-management")
		public String retrieveGroup(Model model, Principal principal) {
			log.info("아티스트 그룹 목록 페이지 요청");
			
			// 1. 로그인ㅇ한 사용자의 ID를 가져오기
			String empUsername = principal.getName();
			log.info("로그인한 담당자 ID : {}", empUsername);
			
			// 2. 서비스 호출 시 담당 ID를 전달
	        List<ArtistGroupVO> groupList = artistGroupService.retrieveArtistGroupList(empUsername);
	        
	        // 전체 아티스트 목록을 가져오기 위함
	        List<ArtistVO> allArtists = artistService.getAllArtists();
	        
	        // 전체 앨범 목록을 가져오기 위함
	        List<AlbumVO> allAlbums = artistGroupService.getAllAlbums();
	        
	        // 그룹 없는 앨범
	        List<AlbumVO> albumsWithoutGroup = albumService.getAlbumsWithoutGroup();

	        model.addAttribute("artistGroupList", groupList);
	        model.addAttribute("allArtists", allArtists);
	        model.addAttribute("allAlbums", allAlbums);
	        model.addAttribute("albumsWithoutGroup", albumsWithoutGroup);
	        
	        log.info("전체 아티스트 수 (모달용): {}", allArtists != null ? allArtists.size() : 0);
	        log.info("그룹 미지정 앨범 수 (모달용): {}", albumsWithoutGroup != null ? albumsWithoutGroup.size() : 0);
	        
	        if (groupList != null && !groupList.isEmpty()) {
	            log.info("조회된 아티스트 그룹 수: {}", groupList.size());
	        } else {
	            log.info("조회된 아티스트 그룹이 없습니다.");
	        }
	        return "emp/group/group-management";
		}
		
		@ResponseBody
		@PostMapping("/update")
		public ResponseEntity<Map<String, Object>> updateArtistGroup(
				@ModelAttribute ArtistGroupVO groupToUpdate, 
				@RequestParam(value="existingGroupProfileImg", required = false) String existingGroupProfileImg
				) {
			log.info("updateArtistGroup() 실행 요청 받음.");
	        log.info("요청된 GroupVO (텍스트 필드 및 파일 바인딩 전): {}", groupToUpdate); // profileImage는 @ModelAttribute로 바인딩됨
	        log.info("요청된 existingGroupProfileImg: {}", existingGroupProfileImg);
	        
	        if(groupToUpdate.getProfileImage() !=null && !groupToUpdate.getProfileImage().isEmpty()){
	        	log.info("업로드된 새 그룹 프로필 파일: {}", groupToUpdate.getProfileImage().getOriginalFilename());
	        } else {
	            log.info("새로운 그룹 프로필 파일이 업로드되지 않았습니다.");
	        }
	        
	        Map<String, Object> response = new HashMap<>();
	        
	        try {
	        	groupToUpdate.setArtGroupProfileImg(existingGroupProfileImg);
	        	
	        	log.info("서비스로 전달될 최종 GroupVO: {}", groupToUpdate);
	            if(groupToUpdate.getProfileImage() != null && !groupToUpdate.getProfileImage().isEmpty()) {
	                log.info("서비스로 전달될 GroupVO 내 profileImage 파일명: {}", groupToUpdate.getProfileImage().getOriginalFilename());
	            }
	            
	        	int cnt = artistGroupService.updateArtistGroupAndMembersAndAlbums(groupToUpdate);
	        	
	        	if (cnt > 0) {
	                response.put("status", "success");
	                response.put("message", "그룹 정보가 성공적으로 업데이트 되었습니다.");
	                log.info("그룹 정보 업데이트 성공: 그룹번호 {}, 최종 프로필 이미지 경로: {}", groupToUpdate.getArtGroupNo(), groupToUpdate.getArtGroupProfileImg());
	                return ResponseEntity.ok(response);
	            } else {
	                response.put("status", "failed");
	                response.put("message", "그룹 정보 업데이트에 실패했습니다. (변경된 내용이 없거나 서버 내부 문제)");
	                log.warn("그룹 정보 업데이트 실패 (서비스 로직, 반환값 0): 그룹번호 {}", groupToUpdate.getArtGroupNo());
	                return ResponseEntity.ok(response); 
	            }
				
			} catch (RuntimeException e) { // 서비스에서 발생시킨 RuntimeException 처리
	            log.error("그룹 정보 업데이트 중 서비스 로직 오류 발생: 그룹번호 {}", groupToUpdate.getArtGroupNo(), e);
	            response.put("status", "error");
	            response.put("message", e.getMessage()); // 서비스에서 전달한 오류 메시지
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        } catch (Exception e) { // 그 외 예상치 못한 예외 처리
	            log.error("그룹 정보 업데이트 중 알 수 없는 서버 오류 발생: 그룹번호 {}", groupToUpdate.getArtGroupNo(), e);
	            response.put("status", "error");
	            response.put("message", "서버 내부 오류로 인해 그룹 정보 업데이트에 실패했습니다: " + e.getMessage());
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
		}
}
