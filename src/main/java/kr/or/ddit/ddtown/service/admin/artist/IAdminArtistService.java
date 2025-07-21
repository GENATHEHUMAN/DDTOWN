package kr.or.ddit.ddtown.service.admin.artist;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;

public interface IAdminArtistService {

	/**
	 * 페이징 처리된 아티스트 목록 가져오기
	 * @param pagingVO
	 * @param artDelYn
	 * @return
	 */
	public List<ArtistVO> getArtistList(PaginationInfoVO<ArtistVO> pagingVO, String artDelYn);

	/**
	 * 페이징 처리된 총 레코드 수 가져오기
	 * @param pagingVO
	 * @param artDelYn
	 * @return
	 */
	public int getTotalRecord(PaginationInfoVO<ArtistVO> pagingVO, String artDelYn);

	/**
	 * 특정 아티스트 번호를 통해 아티스트 정보 가져오기
	 * @param artNo
	 * @return
	 */
	public ArtistVO getArtistDetail(int artNo);

	/**
	 * 아티스트 정보 수정
	 * @param artistVO
	 * @return 성공시 OK 실패시 FAILED
	 */
	public ServiceResult updateArtist(ArtistVO artistVO);

	/**
	 * 아티스트 등록
	 * @param artistVO
	 * @return
	 */
	public ServiceResult registArtist(ArtistVO artistVO);

	/**
	 * 아티스트 은퇴 처리
	 * @param artistVO
	 * @return
	 */
	public ServiceResult deleteArtist(ArtistVO artistVO);

	/**
	 * 그룹번호를 가지고있는 아티스트 목록 가져오기
	 * @param artGroupNo
	 * @return
	 */
	public List<ArtistVO> getArtistListByGroupNo(int artGroupNo);

	/**
	 * 그룹 수정시 해당 그룹에 추가할 은퇴를 제외한 아티스트 목록을 가져온다
	 * @return
	 */
	public List<ArtistVO> getArtistListAll();

	/**
	 * 아티스트 관리 요약본 (총 인원수 , 활동 인원수, 은퇴 인원수)
	 * @return
	 */
	public Map<String, Object> selectSummaryMap();

}
