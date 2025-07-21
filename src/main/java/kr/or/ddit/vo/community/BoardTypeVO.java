package kr.or.ddit.vo.community;

import java.util.Date;

import lombok.Data;

@Data
public class BoardTypeVO {

	private String btBoardTypeCode;		// 게시판 유형코드
	private String boardNm;				// 게시판 명
	private Date boardRegDate;			// 게시판 생성일자
	private String boardReplyYn;		// 댓글 사용여부
	
	private boolean boardReplyTf;		// 댓글 사용여부 TRUE/FALSE
	
}
