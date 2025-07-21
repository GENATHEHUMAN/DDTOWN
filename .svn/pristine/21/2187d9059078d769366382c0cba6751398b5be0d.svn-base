package kr.or.ddit.ddtown.mapper.community;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.community.CommunityNoticeVO;
import kr.or.ddit.vo.community.ConcertNoticeMapVO;

@Mapper
public interface IConcertNoticeMapMapper {
	
	public int insertConcertNoticeMap(ConcertNoticeMapVO mapVO);
    public int deleteConcertNoticeMap(@Param("artScheduleNo") int artScheduleNo, @Param("comuNotiNo") int comuNotiNo);
    public List<CommunityNoticeVO> selectNoticeByArtScheduleNo(int artScheduleNo);
    public ConcertNoticeMapVO selectMapByArtScheduleNoAndNotiNo(@Param("artScheduleNo") int artScheduleNo, @Param("comuNotiNo") int comuNotiNo);
}
