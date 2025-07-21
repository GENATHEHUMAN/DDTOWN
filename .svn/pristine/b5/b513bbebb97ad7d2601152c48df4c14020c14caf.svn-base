package kr.or.ddit.ddtown.service.audition;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.audition.AuditionMapper;
import kr.or.ddit.vo.corporate.audition.AuditionVO;

@Service
public class AuditionServiceImpl implements AuditionService{
	
	@Autowired
	private AuditionMapper auditionMapper;
	//오디션 목록
	@Override
	public List<AuditionVO> auditionList() {
		
		List<AuditionVO> auditionList = auditionMapper.auditionList();
		System.out.println("리스트" + auditionList);
		return auditionList;
	}
	//오디션 상세보기
	@Override
	public AuditionVO detailAudition(int audiNo) {
		return auditionMapper.detailAudition(audiNo);
	}
	//이메일 중복 확인
	@Override
	public ServiceResult emailCheck(String email) {
		ServiceResult result = null;
		
		return null;
	}

}
