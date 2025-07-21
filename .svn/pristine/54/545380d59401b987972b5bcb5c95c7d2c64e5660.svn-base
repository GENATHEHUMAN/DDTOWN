package kr.or.ddit.ddtown.controller.emp.artist;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ddtown.service.emp.artist.IArtistService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/artist")
public class ArtistManagementController {
	
	@Autowired
	private IArtistService artistService;
	
	/**
     * 아티스트 관리 페이지 및 목록 조회
     */
	@GetMapping("/artist-management")
	public String artistManagementPage(@ModelAttribute ArtistVO artistVO, Model model) {
		log.info("artistManagementPage() 실행. 검색 조건: {}", artistVO);

		PaginationInfoVO<ArtistVO> pagingVO = new PaginationInfoVO<>();
		int currentPage = artistVO.getPage();
		String searchType = artistVO.getSearchType();
		String searchWord = artistVO.getSearchWord();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			// 검색 후 목록 갈때 검색내용 적용
			model.addAttribute("searchType", artistVO.getSearchType());
			model.addAttribute("searchWord", artistVO.getSearchWord());
		}
		
		try {
			// 현재 페이지 전달 후, start/endRow, start/endPage 설정
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = artistService.selectArtistCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			List<ArtistVO> artistList = artistService.artistListWithPage(pagingVO);
			pagingVO.setDataList(artistList);
		} catch (Exception e) {
			log.error("아티스트 목록 조회 중 오류 발생", e);
			model.addAttribute("errorMessage", "아티스트 목록을 불러오는 중 오류가 발생했습니다!!");
		}
		model.addAttribute("pagingVO", pagingVO);
        return "emp/artist/artist-management";
	}
	
	@ResponseBody
	@PostMapping("/update")
	public ResponseEntity<Map<String, String>> updateArtist(
			 @ModelAttribute ArtistVO artistToUpdate, // artNo, artNm, artContent
			 @RequestParam(value = "artistFile", required = false) MultipartFile artistFile,
	         @RequestParam(value = "existingArtProfileImg", required = false) String existingArtProfileImg // JSP에서 기존 이미지 경로 전송 
			){
		log.info("updateArtist() 실행 요청 받음. ArtistVO 기본 정보: {}", artistToUpdate);
        log.info("기존 프로필 이미지 경로 (클라이언트 전달값): {}", existingArtProfileImg);

        if (artistFile != null && !artistFile.isEmpty()) {
            log.info("업로드된 새 파일명: {}, 파일 크기: {}", artistFile.getOriginalFilename(), artistFile.getSize());
        } else {
            log.info("새로운 프로필 이미지 파일이 업로드되지 않았습니다.");
        }

        Map<String, String> response = new HashMap<>();
		
        try {
        	// 1. 업로드된 파일 담기
        	artistToUpdate.setProfileImg(artistFile);
        	
        	// 2. 기존 이미지 경로 필드에 설정
        	artistToUpdate.setProfileImg(artistFile);
        	
        	log.info("서비스로 전달될 ArtistVO 최종 상태 : {}", artistToUpdate);
        	
        	if(artistToUpdate.getProfileImg() != null && !artistToUpdate.getProfileImg().isEmpty()) {
                log.info("서비스로 전달될 ArtistVO 내 profileImg 파일명: {}", artistToUpdate.getProfileImg().getOriginalFilename());
           }
        	
        	int updateStatus = artistService.updateArtist(artistToUpdate);
        	
        	if(updateStatus > 0){
        		response.put("status", "success");
        		response.put("message", "아티스트 정보가 성공적으로 업데이트 되었습니다.");
        		log.info("아티스트 정보 업데이트 성공: 아티스트 번호 {}, 최종 프로필 이미지 경로: {}", artistToUpdate.getArtNo(), artistToUpdate.getArtProfileImg());
        		if (artistFile != null && !artistFile.isEmpty() && StringUtils.isNotBlank(existingArtProfileImg) && !existingArtProfileImg.equals(artistToUpdate.getArtProfileImg())) {
                    log.info("새 프로필 이미지가 업로드되었으며, 기존 파일 ({})은 서버에 유지됩니다.", existingArtProfileImg);
                }
        		return ResponseEntity.ok(response);
        	}else {
        		response.put("status", "failed");
                response.put("message", "아티스트 정보 업데이트에 실패했습니다. (대상을 찾을 수 없거나 변경된 내용이 없습니다)");
                log.warn("아티스트 정보 업데이트 실패 (updateStatus <= 0, 예외 없음): 아티스트 번호 {}", artistToUpdate.getArtNo());
                return ResponseEntity.ok(response); 
        	}
		} catch (RuntimeException e) { // ArtistServiceImpl에서 발생시킨 RuntimeException 처리
            log.error("아티스트 정보 업데이트 중 서비스 로직 오류 발생: 아티스트 번호 {}", artistToUpdate.getArtNo(), e);
            response.put("status", "error");
            response.put("message", e.getMessage()); // 서비스에서 설정한 오류 메시지
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        } catch (Exception e) { // 그 외 예상치 못한 예외 포괄 처리
            log.error("아티스트 정보 업데이트 중 알 수 없는 서버 오류 발생: 아티스트 번호 {}", artistToUpdate.getArtNo(), e);
            response.put("status", "error");
            response.put("message", "서버 내부 오류로 인해 아티스트 정보 업데이트에 실패했습니다. 관리자에게 문의하세요.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
	}
}






