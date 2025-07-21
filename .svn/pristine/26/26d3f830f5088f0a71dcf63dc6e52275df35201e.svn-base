package kr.or.ddit.ddtown.controller.emp.live;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ddtown.service.community.ICommunityMainPageService;
import kr.or.ddit.vo.live.LiveStatDTO;
import kr.or.ddit.vo.live.LiveVO;

@RestController
@RequestMapping("/api/emp/live")
public class LiveStatsRestController {

	@Autowired
	private ICommunityMainPageService communityMainPageService;
	
	// 날짜 형식을 지정하기 위한 포매터
    private static final DateTimeFormatter ISO_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    
    /**
     * 특정 아티스트 그룹의 라이브 이력 통계를 조회
     * @param artGroupNo
     * @return JSON 차트 데이터
     */
    @GetMapping("/stats")
    public List<LiveStatDTO> getLiveStats(@RequestParam("artGroupNo")int artGroupNo){
    	
    	List<LiveVO> historyList = communityMainPageService.getLiveHistory(artGroupNo);
    	
    	// LiveVO를 LiveDTO로 변환
    	List<LiveStatDTO> statsData = historyList.stream()
    			.map(liveVO -> {
		    		Date liveDate = liveVO.getLiveStartDate();
		    		
		    		LocalDateTime localDateTime = liveDate.toInstant()
		    											  .atZone(ZoneId.systemDefault())
		    											  .toLocalDateTime();
		    		return new LiveStatDTO(
		    				localDateTime.format(ISO_FORMATTER),
		    				liveVO.getLiveHit()
		    				);
		    	})
    			.collect(Collectors.toList());

    	return statsData;
    }
}
