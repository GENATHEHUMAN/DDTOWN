package kr.or.ddit.ddtown.service.coporate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.corporate.ICorporateMapper;
import kr.or.ddit.vo.artist.ArtistGroupVO;

@Service
public class CorporateServiceImpl implements ICorporateService{

	@Autowired
	private ICorporateMapper coporateMapper;
	
	@Override
	public List<ArtistGroupVO> getGroupList() {
		return coporateMapper.getGroupList();
	}

}
