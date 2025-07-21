package kr.or.ddit.vo.chat.dm;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatChannelVO {
	// private Set<WebSocketSession> sessions = new HashSet<>();	// 웹소켓 세션 관리 알아서 해줌. (STOMP가)
	
	// 채널 table 정보
	private Integer chatChannelNo;		// 채널 번호
	private Integer comuProfileNo;		// 커뮤니티 프로필 번호
	private Integer artGroupNo;			// 아티스트 그룹 번호
	private String chatTypeCode;		// 채팅 타입 : 일반, 파일
	private Date chatChannelOpenDate;	// 채널 오픈일
	private Date chatLastDate;			// 채팅한 날짜
	private String chatDelYn;			// 채널 폐쇄 여부
	
	// 채널 대상 아티스트 정보
	private String artistUsername;		// 아티스트 아이디
	private String artistComuNicknm;	// 아티스트 커뮤 닉네임
	
	// 현재 접속자 정보
	private String currentUsername;		// 로그인한 사용자 아이디
	private String myComuNicknm;		// 로그인한 사용자 닉네임
	private boolean isArtist;			// 아티스트 권한 여부
	private boolean hasMembership;		// 멤버십 구독 여부
	
	// 초기 메세지 목록
	private List<ChatMessageVO> initialMessages;
	
	// 읽지 않은 메세지 수
	private int unreadMessageCount;
	
	// 가장 최근 메세지 내용
	private String lastMessageContent;
	private Date lastMessageSendDate;
	private String lastMessageSender;
}
