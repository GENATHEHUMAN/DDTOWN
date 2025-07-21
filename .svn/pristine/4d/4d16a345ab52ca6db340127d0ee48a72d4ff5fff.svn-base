package kr.or.ddit.ddtown.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ddtown.service.emp.artist.IArtistGroupService;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/artistGroup")
public class ArtistGroupApiController {

	@Autowired 
    private IArtistGroupService groupService;

    @GetMapping("/{artGroupNo}")
    public ResponseEntity<ArtistGroupVO> getArtistGroupInfo(@PathVariable int artGroupNo) {
    	
        ArtistGroupVO artistGroupInfo = groupService.retrieveArtistGroup(artGroupNo);

        log.info(" DB에서 조회한 아티스트 정보 : {}", artistGroupInfo);
        
        // 3. 조회 결과가 있는지 확인합니다.
        if (artistGroupInfo != null) {
            // 4. 정보가 있으면, VO 객체를 그대로 반환합니다. 
            //    Spring이 이 객체를 보고 아래와 같은 JSON으로 자동 변환해줍니다.
            //    { "artGroupNo": 21, "artGroupNm": "에스파", "artGroupDebut": "2020-11-17", ... }
            return ResponseEntity.ok(artistGroupInfo);
        } else {
        	 // ✅ 데이터가 없을 경우에도 로그를 남겨 원인을 파악하기 쉽게 합니다.
            log.warn("artGroupNo {}에 해당하는 아티스트 정보가 없습니다.", artGroupNo);
            return ResponseEntity.notFound().build();
        }
    }
}
