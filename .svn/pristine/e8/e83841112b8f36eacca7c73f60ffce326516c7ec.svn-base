package kr.or.ddit.ddtown.mapper.community;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.community.CommunityVO;

@Mapper
public interface ICommunityMapper {

	/**
	 * 아티스트 그룹 생성시 커뮤니티 테이블 생성
	 * @param communityVO
	 * @return
	 */
	public int registCommunity(CommunityVO communityVO);

	/**
	 * 커뮤니티 테이블 삭제여부 Y 변경
	 * @param artGroupNo
	 * @return
	 */
	public int deleteCommunity(int artGroupNo);

}
