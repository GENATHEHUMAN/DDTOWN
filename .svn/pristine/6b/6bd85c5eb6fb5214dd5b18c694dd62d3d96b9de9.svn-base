package kr.or.ddit.vo.member;



import java.sql.Date;

import lombok.Data;

@Data
public class MemberAdminVO {

	private String memUsername;			// 회원 아이디
	private String memStatCode;			// 회원 상태 코드
	private String memRegPath;			// 회원 가입경로
	private String memNicknm;			// 회원 닉네임
	private String memBirth;			// 회원 생년월일
	private String memZipCode;			// 회원 우편번호
	private String memAddress1;			// 회원 상세주소1
	private String memAddress2;			// 회원 상세주소2
	private Date memModDate;			// 회원 최종 수정일자
	private Date memRegDate;			// 회원 최초 가입일자
	
	private int rowNum;					// 페이지 네이션 순번
	
	private String memStatDetCode;		// 회원 상태 DESCRIPTION
	private String memRegDetCode;		// 회원 가입 경로 DESCRIPTION
	
	private PeopleAdminVO peopleVO;		// 사용자 테이블
	
	private int totalMemCnt;			// 총 회원 수
	private int generalMemCnt;			// 정상 총 회원 수
	private int outMemCnt;				// 탈퇴 총 회원수
	private int blackMemCnt;			// 블랙리스트 총 회원수
	
	private int currentMemCnt;			
	
	private int comuProfileNo;			// 회원 커뮤니티 번호
	private int postCnt;				// 커뮤니티 작성 게시글 수
	private int replyCnt;				// 커뮤니티 작성 댓글 수
	
	private int artGroupNo;				// 커뮤니티 아티스트 그룹 번호
	private String comuProfileImg;		// 커뮤니티 프로필 이미지
	private Date comuRegDate;			// 커뮤니티 가입날짜
	
	private String comuDelYn;			// 커뮤니티 탈퇴여부
	private String comuNm;				// 커뮤니티 명
	private String comuNicknm;			// 커뮤니티 닉네임

}
