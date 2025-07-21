package kr.or.ddit.vo.artist;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import lombok.Data;

@Data
public class AlbumVO {
	
	private int albumNo;
	private int artGroupNo;
	private String albumImg;
	private String albumNm;
	private String albumDetail;
	private Date albumRegDate;
	
	// 앨범 수록곡
	private List<AlbumSongVO> albumSongs;
	
	
	/**
	 *  앨범의 타이틀 곡 이름을 리턴한다.
	 *  AlbumSongVO의 sonTitleYn 필다가 'Y'인 곡을 찾는다.
	 * @return 타이틀 곡 이름 / 없으면 NULL
	 */
	public String getTitleSong() {
		if(albumSongs == null || albumSongs.isEmpty()) {
			return null;
		}
		
		// AlbumSongVO 리스트에서 songTitleYn이 "Y"인 첫 번째 곡을 찾습니다.
		// Optional 객체가 값을 가지고 있다면 (isPresent()), 해당 곡의 이름(getSongNm())을 반환.
		Optional<AlbumSongVO> titleSongOpt = albumSongs.stream()
												   .filter(song -> "Y".equalsIgnoreCase(song.getSongTitleYn()))
												   .findFirst();
		if(titleSongOpt.isPresent()) {
			return titleSongOpt.get().getSongNm();
		}
		
		return null;
	}
}
