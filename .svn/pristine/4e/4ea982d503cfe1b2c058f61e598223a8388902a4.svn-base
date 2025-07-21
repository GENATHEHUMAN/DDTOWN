package kr.or.ddit.ddtown.service.concert;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.concert.IConcertMapper;
import kr.or.ddit.vo.concert.ConcertVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ConcertServiceImpl implements IConcertService{
	
	@Autowired
	private IConcertMapper mapper;

	@Override
	public int getConcertCount(Map<String, Object> params) {
		
		return mapper.getConcertCount(params);
	}

	@Override
	public List<ConcertVO> getConcertList(Map<String, Object> params) {
		 log.info("getConcertList() 실행...!");
	        List<ConcertVO> list = mapper.getConcertList(params);
	        log.info("조회된 콘서트 목록 수: {}", list.size());
	        return list;
	}

	@Override
	public boolean createConcert(ConcertVO concertVO) {
		
		return false;
	}

	@Override
	public ConcertVO getConcertByNo(int concertNo) {
		return null;
	}

}
