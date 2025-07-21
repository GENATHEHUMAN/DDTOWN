package kr.or.ddit.ddtown.controller.chat.dm;

import java.security.Principal;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

import kr.or.ddit.ddtown.service.chat.dm.IChatMessageService;
import kr.or.ddit.vo.chat.dm.ChatMessageVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class DMChatMessageController {
	
	private final IChatMessageService chatMessageService;
	
	@MessageMapping("/chat/dm/message")
	@PreAuthorize("hasAnyRole('ARTIST', 'MEMBERSHIP', 'EMPLOYEE', 'ADMIN')")
	public void processMessage(@Payload ChatMessageVO message, Principal principal) {
		
		try {
			chatMessageService.saveAndProcessChatMessage(message, principal);
		} catch (Exception e) {
			log.error("웹소켓 메세지 처리 중 오류 발생 : {}", e.getMessage(), e);
		}
	}
}
