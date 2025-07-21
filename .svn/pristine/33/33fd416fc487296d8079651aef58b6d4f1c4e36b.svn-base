package kr.or.ddit.vo.chat.dm;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessageVO {

	public enum MessageType {
		ENTER, TALK, EXIT, MENTION_ALL, FILE;
	}
	
	private MessageType type;			// 메세지 타입
	private Integer chatNo;				// 메세지 번호
	private Integer chatChannelNo;		// 채널 번호
	private String username;			// 송신자
	private Integer attachDetailNo;		// 첨부 파일 상세 번호
	private String chatMsgTypeCode;		// dm
	private String chatContent;			// 메세지 내용
	private Date chatSendDate;			// 일자
	private Integer comuProfileNo;		// 커뮤니티 프로필 번호
	
	private String userProfileImgPath;	// 프로필 이미지 경로 URL
	private String comuNicknm;			// 닉네임
	private String fileUrl;				// JSP 이미지 Url 전달용
	private boolean isArtistMessage;	// 아티스트 메세지 여부
	
	public void setChatMsgTypeCode(String chatMsgTypeCode) {
		this.chatMsgTypeCode = chatMsgTypeCode;
		if("CMTC001".equals(chatMsgTypeCode)) {
			this.type = MessageType.TALK;
		} else if("CMTC002".equals(chatMsgTypeCode)) {
			this.type = MessageType.FILE;
		} else {
			this.type = MessageType.TALK;
		}
	}
}
