package kr.or.ddit.ddtown.service.emp.artist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.emp.artist.ArtistGroupMapper;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ArtistGroupServiceImpl implements IArtistGroupService{
	
	@Autowired
	private ArtistGroupMapper artistGroupMapper;
	
	public List<ArtistGroupVO> retrieveArtistGroupList() {
		log.info("retrieveArtistGroupList() 메소드 실행");
		
		List<ArtistGroupVO> groupList = artistGroupMapper.retrieveArtistGroupList();
		
		if (groupList == null || groupList.isEmpty()) {
            log.info("조회된 아티스트 그룹 목록이 없습니다.");
        } else {
            log.info("조회된 아티스트 그룹 수: {}", groupList.size());
        }

        return groupList;
	}

	@Override
	public ArtistGroupVO retrieveArtistGroup(int artGroupNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
