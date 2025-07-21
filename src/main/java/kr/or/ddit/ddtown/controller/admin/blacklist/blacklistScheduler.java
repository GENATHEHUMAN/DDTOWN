package kr.or.ddit.ddtown.controller.admin.blacklist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.ddit.ddtown.service.admin.blacklist.IBlacklistService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class blacklistScheduler {
	@Autowired
	private IBlacklistService blacklistService;
	
	@Scheduled(cron = "0 0 0 * * *")//"*/30 * * * * *"(30초),"0 0 0 * * *"(하루 정각)
	public void  blacklistScheduler() {
		log.info("블랙리스트 자동 해제 스케줄러 시작...");
		try {
			blacklistService.uploadBlackScheduler();
			log.info("블랙리스트 자동 해제 스케줄러 완료.");
		}catch (Exception e) {
				log.error("블릭리트스 만료 해제중 오류발생: {}", e.getMessage(), e);
		}
		
	}
}
