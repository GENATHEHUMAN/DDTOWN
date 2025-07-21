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
        
        if (artistGroupInfo != null) {
            return ResponseEntity.ok(artistGroupInfo);
        } else {
            log.warn("artGroupNo {}에 해당하는 아티스트 정보가 없습니다.", artGroupNo);
            return ResponseEntity.notFound().build();
        }
    }
}
