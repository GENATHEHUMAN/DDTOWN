package kr.or.ddit.vo.community;

import java.util.List;

import kr.or.ddit.vo.BaseVO;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@ToString(callSuper = true)
public class CommunityVO extends BaseVO{
	private int artGroupNo;
	private String comuActCode;
	private String comuNm;
	private String comuContent;
	private Integer fileGroupNo;
	
	private String memUsername;			// 현재 접속중인 유저아이디
	
	private String boardTypeCode;		// 게시판 형태(ARTIST_BOARD / FAN_BOARD)
	
	private int myComuProfileNo;		// 커뮤니티 프로필 번호

	// 해당 VO가 artist쪽인지 아닌지 true : 아티스트 관련 게시물 / false : 팬 관련 게시물
	private boolean artistTabYn = true;
	
	private List<CommonCodeDetailVO> codeList;
	
	private int totalFan;
	private int totalArtist;
	
	private int comuPostTotalCount;
	
	private int startRow;			// 시작 row
	private int endRow;				// 끝 row
	
	
	private CommunityVO(int page, String searchWord, String searchType) {
		super(page, searchWord, searchType);
	}

	
	
}
