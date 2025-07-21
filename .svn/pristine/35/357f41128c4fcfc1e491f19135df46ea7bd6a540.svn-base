package kr.or.ddit.vo.community;

import lombok.Data;

@Data
public class CommunityReportVO {
	
	private int reportNo;					// 신고번호								* mapper 처리
	private int artGroupNo;					// 아티스트 그룹							* 필수
	private String memUsername;				// 신고자									* 컨트롤러에서 처리
	private String targetMemUsername;		// 신고 처리 대상자							* 프로필번호와 그룹 번호로 조회
	private String reportReasonCode;		// 신고 사유 코드  (스팸, 욕설, 음란물, 기타)	* 필수
	private String reportTargetTypeCode;	// 신고 대상 유형 (게시글, 댓글, 채팅)			* 필수
	private String reportStatCode;			// 신고 진행 상태 코드 (접수됨, 처리완료)		* mapper 또는 service에서 처리
	private String reportResultCode;		// 신고 결과코드(조치없음, 콘텐츠 삭제, 숨김 처리, 블랙리스트) * mapper 또는 service에서 처리
	private Integer targetComuPostNo;			// 신고 게시글 번호 						* 필수
	private String targetBoardTypeCode;		// 신고 게시글 타입 (아티스트 게시글, 팬 게시글)	* 필수
	private Integer targetComuReplyNo;			// 신고 댓글 번호							* 필수
	private Integer targetChatNo;				// 신고 채팅 번호							* 처리 x
	
	private int targetComuProfileNo;		// 신고 처리 대상자 커뮤니티 번호				* 필수
	
	private String reportYn;
	
}
