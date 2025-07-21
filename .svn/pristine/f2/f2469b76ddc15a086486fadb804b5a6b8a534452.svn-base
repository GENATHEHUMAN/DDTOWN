package kr.or.ddit.ddtown.service.community.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.community.IConcertNoticeMapMapper;
import kr.or.ddit.vo.community.CommunityNoticeVO;
import kr.or.ddit.vo.community.ConcertNoticeMapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ConcertNoticeMapServiceImpl implements IConcertNoticeMapService {

	@Autowired
    private IConcertNoticeMapMapper mapper;

    @Override
    public int insertConcertNoticeMap(ConcertNoticeMapVO mapVO) {
        return mapper.insertConcertNoticeMap(mapVO);
    }

    @Override
    public int deleteConcertNoticeMap(int artScheduleNo, int comuNotiNo) {
        return mapper.deleteConcertNoticeMap(artScheduleNo, comuNotiNo);
    }

    @Override
    public List<CommunityNoticeVO> selectNoticeByArtScheduleNo(int artScheduleNo) {
        return mapper.selectNoticeByArtScheduleNo(artScheduleNo);
    }

    @Override
    public ConcertNoticeMapVO selectMapByArtScheduleNoAndNotiNo(int artScheduleNo, int comuNotiNo) {
        return mapper.selectMapByArtScheduleNoAndNotiNo(artScheduleNo, comuNotiNo);
    }

}
