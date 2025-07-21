package kr.or.ddit.ddtown.service.chat.dm;

import java.security.Principal;
import java.util.List;

import kr.or.ddit.vo.chat.dm.ChatMessageVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;

public interface IChatMessageService {

	// 채팅 메세지 저장, 필터링, 권한별 웹소켓 전송
	ChatMessageVO saveAndProcessChatMessage(ChatMessageVO message, Principal principal);
	
	// 파일 첨부 상세 저장
	void insertAttachFileDetail(AttachmentFileDetailVO fileDetailVO);

	// 마지막 메세지 번호 조회
	Integer selectLastMessageNo(int chatChannelNo);

	// 무한 스크롤 : 페이지네이션 조회
	List<ChatMessageVO> getChatMessagesByChannelPaged(int chatChannelNo, int offset, int limit);
}
