package kr.or.ddit.ddtown.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.community.ICommunityLSNMapper;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.concert.ConcertNoticeVO;
import kr.or.ddit.vo.schedule.ScheduleVO;

@Service
public class CommunityLSNService implements ICommunityLSNService {

	@Autowired
	private ICommunityLSNMapper lSNMapper;

	@Override
	public List<ScheduleVO> scheduleList(int artGroupNo) {
		List<ScheduleVO> list = lSNMapper.scheduleList(artGroupNo);
		
		changeAllDay(list);
		
		return list;
	}

	private void changeAllDay(List<ScheduleVO> list) {
		for(int i=0; i<list.size(); i++) {
			ScheduleVO vo = list.get(i);
			String status = vo.getAllDayStatus();
			if(status.equals("Y")) {
				vo.setAllDay(true);
				continue;
			}
			
			vo.setAllDay(false);
		}
	}

	@Override
	public List<ConcertNoticeVO> noticeList(int artGroupNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CommonCodeDetailVO> getCodeList() {
		
		List<CommonCodeDetailVO> noticeCodeList = lSNMapper.getCodeList();
		
		return noticeCodeList;
	}
	
}
