package kr.or.ddit.ddtown.mapper.emp.artist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;

@Mapper
public interface IArtistMapper {
	
	//전체 아티스트 목록
	public List<ArtistVO> getAllArtists();
	// 목록 불러오는 메서드 (파라미터 페이지네이션 페이징VO)
	// 개수 세는 메서드
	public List<ArtistVO> getArtistList();
	public int updateArtist(ArtistVO artistToUpdate);
	
	// 페이지네이션에 필요한 것들
	public List<ArtistVO> artistListWithPage(PaginationInfoVO<ArtistVO> pagingVO);
    public int selectArtistCount(PaginationInfoVO<ArtistVO> pagingVO);

}
