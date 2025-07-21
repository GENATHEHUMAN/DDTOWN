package kr.or.ddit.ddtown.service.emp.artist;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;

public interface IArtistService {
	
	// 전체 아티스트 조회
	List<ArtistVO> getAllArtists();
	List<ArtistVO> getArtistList(Map<String, String> searchParams);
	
	
	int updateArtist(ArtistVO artistToUpdate);
	
	// 페이지네이션에 필요한 것들
	public List<ArtistVO> artistListWithPage(PaginationInfoVO<ArtistVO> pagingVO) throws Exception;
    public int selectArtistCount(PaginationInfoVO<ArtistVO> pagingVO) throws Exception;
    
}
