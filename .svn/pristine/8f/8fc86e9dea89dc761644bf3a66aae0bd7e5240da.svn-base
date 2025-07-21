package kr.or.ddit.ddtown.controller.alert;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ddtown.service.alert.IAlertService;
import kr.or.ddit.ddtown.service.follow.IFollowService;
import kr.or.ddit.vo.alert.AlertVO;
import kr.or.ddit.vo.live.LiveVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/alert")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class AlertAPIController {

    @Autowired
    private IAlertService alertService;
    @Autowired
    private IFollowService followService;
    
    // 테스트용 엔드포인트
    @GetMapping("/test")
    public ResponseEntity<String> test() {
        log.info("테스트 엔드포인트 호출됨");
        return ResponseEntity.ok("DDTOWN 알림 API 서버 정상 동작 중!");
    }

    @PostMapping("/live-start")
    public ResponseEntity<?> sendLiveStartAlert(@RequestBody Map<String, Object> params) {
        log.info("라이브 알림 API 호출됨, params={}", params);

        Object artGroupNoObj = params.get("artGroupNo");
        Integer artGroupNo = null;
        if (artGroupNoObj instanceof Integer) {
            artGroupNo = (Integer) artGroupNoObj;
        } else if (artGroupNoObj instanceof String) {
            artGroupNo = Integer.parseInt((String) artGroupNoObj);
        }
        if (artGroupNo == null) {
            log.error("artGroupNo가 null입니다.");
            return ResponseEntity.badRequest().body("artGroupNo is required");
        }

        log.info("artGroupNo: {}", artGroupNo);

        // 1. 현재 라이브 정보 조회
        LiveVO liveVO = alertService.getCurrentLiveByArtGroupNo(artGroupNo);
        log.info("조회된 라이브 정보: {}", liveVO);
        
        if (liveVO == null) {
            log.warn("진행중인 라이브가 없습니다. artGroupNo={}", artGroupNo);
            return ResponseEntity.status(404).body("진행중인 라이브가 없습니다.");
        }

        // 2. 팔로워 조회
        List<String> followerUsernames = followService.getFollowerUsernamesForAlert(artGroupNo);
        log.info("팔로워 목록: {}", followerUsernames);

        if (followerUsernames.isEmpty()) {
            log.warn("팔로워가 없습니다. artGroupNo={}", artGroupNo);
            return ResponseEntity.ok().body("팔로워가 없어 알림을 보낼 수 없습니다.");
        }
        
        // 4. 알림 생성 및 전송
        AlertVO alert = new AlertVO();
        alert.setAlertTypeCode("ATC004");
        alert.setRelatedItemTypeCode("ITC004");
        alert.setRelatedItemNo(liveVO.getLiveNo());
        alert.setArtGroupNo(artGroupNo);
        alert.setArtGroupNm(liveVO.getArtGroupNm());
        alert.setAlertContent("'" + liveVO.getArtGroupNm() +"' 의 라이브 방송이 시작됐습니다!!!");
        alert.setAlertUrl("/community/gate/" + artGroupNo + "/apt?refresh=" + System.currentTimeMillis() + "#liveArea");
        
        log.info("생성할 알림 정보: {}", alert);

        try {
            alertService.createAlert(alert, followerUsernames);
            log.info("라이브 알림 전송 완료! 대상: {}", followerUsernames);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.error("알림 전송 실패", e);
            return ResponseEntity.status(500).body("알림 전송 실패: " + e.getMessage());
        }
    }
}
