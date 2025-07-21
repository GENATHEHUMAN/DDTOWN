package kr.or.ddit.ddtown.service.coporate;

import java.util.List;

import kr.or.ddit.vo.artist.ArtistGroupVO;

public interface ICorporateService {

	/** 기업용 아티스트 그룹 목록 가져오기
	 * 각  ArtistGroupVo에는 그룹 정보와 함께 데뷔 앨범 정보(albumVO필다)가 포함되어야 함
	 * @return ArtistGroupVO 객체 리스트
	 */
	List<ArtistGroupVO> getGroupList();

}
