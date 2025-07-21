package kr.or.ddit.ddtown.mapper.emp.artist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.artist.AlbumVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;

@Mapper
public interface ArtistGroupMapper {

    public List<ArtistGroupVO> retrieveArtistGroupList(@Param("empUsername") String empUsername); 

    public ArtistGroupVO retrieveArtistGroup(int artGroupNo); 
    
    public List<AlbumVO> getAllAlbums();

    public List<AlbumVO> getGroupAlbum(@Param("artGroupNoParam") int artGroupNo);
    
    public int updateArtistGroup(ArtistGroupVO groupToUpdate);

    
    public int unassignArtistsFromGroup(int artGroupNo); 
    public int assignArtistsToGroup(@Param("artGroupNo") int artGroupNo, @Param("artistIds") List<Integer> newMemberArtNoList); 

    public int unassignAlbumsFromGroup(int artGroupNo); 
    
    public int assignAlbumsToGroup(@Param("artGroupNo") int artGroupNo, @Param("albumIds") List<Integer> newAlbumIdList);

    // 아티스트 그룹 목록 조회
	public List<ArtistGroupVO> getArtistGroupListAll();

	// 해당 아티스트 그룹 담당자 조회
	public String getEmpUsernameByArtistGroupNo(int selectedArtGroupNo);
	
	public List<ArtistGroupVO> selectAllArtistGroups();	

	/**
	 * 직원 아이디로 담당 아티스트 그룹 리스트 조회
	 */
	List<ArtistGroupVO> selectArtistGroupsByEmpUsername(String empUsername);

}