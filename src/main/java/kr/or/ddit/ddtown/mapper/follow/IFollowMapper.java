package kr.or.ddit.ddtown.mapper.follow;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.artist.ArtistGroupVO;

@Mapper
public interface IFollowMapper {

	/**
	 * 특정 회원이 팔로우하는 아티스트 그룹 목록 조회용
	 * @param memUsername	회원 아이디
	 * @return 회원이 팔로우한 아티스트 그룹 목록
	 */
	public List<ArtistGroupVO> selectFollowedArtistGroups(@Param("memUsername") String memUsername);
	
	/**
	 * 특정 회원이 특정 아티스트 그룹을 이미 팔로우하고있는지 체크용
	 * @param followerUsername	회원 아이디
	 * @param artGroupNo	아티스트 그룹번호
	 * @return 이미 팔로우면 1, 아니면 0 반환
	 */
	public int checkFollowExists(@Param("followerUsername") String followerUsername, @Param("artGroupNo") int artGroupNo);
	
	
	/**
	 * 특정 아티스트의 팔로워 수 조회
	 * @param artGroupNo	아티스트 그룹번호
	 * @return	아티스트의 팔로워 수 
	 */
	public int selectFollowerCnt(@Param("artGroupNo") int artGroupNo);
	
	/**
	 * 특정 회원이 팔로우하는 아티스트 그룹 수 조회
	 * @param memUsername	회원 아이디
	 * @return	팔로잉 수
	 */
	public int selectFollowingCnt(@Param("memUsername") String memUsername);
	
	/**
	 * 아티스트 그룹번호로 아티스트 그룹명 조회
	 * @param artGroupNo	아티스트 그룹번호
	 * @return 아티스트 그룹명
	 */
	public String selectArtistGroupName(@Param("artGroupNo") int artGroupNo); 
}
