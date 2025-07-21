package kr.or.ddit.ddtown.controller.chat.dm;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.ddtown.service.chat.dm.IChatChannelService;
import kr.or.ddit.ddtown.service.chat.dm.IChatMessageService;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.chat.dm.ChatChannelVO;
import kr.or.ddit.vo.chat.dm.ChatMessageVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/chat/dm")
@PreAuthorize("hasAnyRole('ARTIST', 'MEMBERSHIP', 'EMPLOYEE', 'ADMIN')")
public class DMChatChannelController {
	
	private final IChatChannelService chatChannelService;
	private final IChatMessageService chatMessageService;
	private final IFileService fileService;
	
	// 채팅 리스트 화면
	@GetMapping("/channel")
	public String channelForm() {
		return "chat/dm/channel";
	}
	
	// 모든 채팅방 목록 반환 (JSON 형태)
	@GetMapping("/channels")
	@ResponseBody
	public List<ChatChannelVO> channelList(String username) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentUser = authentication.getName();	// 현재 로그인한 사용자 아이디
		log.info("name : {}", currentUser);
		return chatChannelService.findAllChannels(currentUser);
	}
	
	// 채팅방 생성
	@PostMapping("/channel")
	@ResponseBody
	public ChatChannelVO createChannel(@ModelAttribute ChatChannelVO chatChannelVO) {
		int comuProfileNo = chatChannelVO.getComuProfileNo();
		int artGroupNo = chatChannelVO.getArtGroupNo();
		String chatTypeCode = chatChannelVO.getChatTypeCode();
		
		return chatChannelService.createChatChannel(comuProfileNo, artGroupNo, chatTypeCode);
	}
	
	// 채팅방 입장 화면
	@GetMapping("/channel/enter/{chatChannelNo}")
	public String channelDetail(Model model, 
								@PathVariable int chatChannelNo,
								Principal principal
								) {
		// 현재 로그인한 사용자 ID
		String username = principal.getName();
		int initialmessageLimit = 50;
		int initialMessageOffset = 0;
		
		// 1. 채널 정보 조회
		ChatChannelVO chatChannelVO = chatChannelService.getChatChannelDetail(chatChannelNo, username, initialmessageLimit);
		
		if (chatChannelVO == null) {
            log.warn("Chat channel {} not found or is not a DM_CHANNEL (CTC001).", chatChannelNo);
            return "redirect:/error/404";
        }
		
		// 2. 접근 제어 - 알림을 통해 들어온 경우도 고려
		if(!chatChannelVO.isArtist() && !chatChannelVO.isHasMembership()) {
			log.warn("user {} does not have a valid membership subscription for artist group {} or is not access channel {}."
					, username, chatChannelVO.getArtGroupNo(), chatChannelVO.getChatChannelNo());
			log.warn("권한 없음! user: {}, isArtist: {}, isHasMembership: {}", username, chatChannelVO.isArtist(), chatChannelVO.isHasMembership());
			
			// 알림을 통해 들어온 경우 채팅방 목록으로 리다이렉트
			model.addAttribute("message", "해당 아티스트 그룹의 멤버십 구독자만 이용할 수 있습니다.");
			return "redirect:/chat/dm/channel";
		}
		
		// 3. 채팅방 입장 시, 해당 사용자의 마지막 읽은 메세지 번호 업데이트
		Integer lastMessageNo = chatMessageService.selectLastMessageNo(chatChannelNo);
		
		if(lastMessageNo != null) {
			chatChannelService.updateLastReadChatNo(chatChannelNo, username, lastMessageNo);
		} else {
			chatChannelService.updateLastReadChatNo(chatChannelNo, username, 0);
		}
		
		// 4. 권한 확인 후 초기 메세지 로드
		List<ChatMessageVO> initialMessages = chatChannelVO.getInitialMessages();
		
		// ObjectMapper 사용하여 Json 문자열로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		String initialMessageJson = "[]";
		try {
			if(initialMessages != null) {
				initialMessageJson = objectMapper.writeValueAsString(initialMessages);
			}
		} catch(JsonProcessingException e) {
			log.error("초기 메세지 JSON 변환 실패: {}", e.getMessage(), e);
		}
		
		model.addAttribute("chatChannelNo", chatChannelVO.getChatChannelNo());
		model.addAttribute("artistUsername", chatChannelVO.getArtistUsername());
		model.addAttribute("artistComuNicknm", chatChannelVO.getArtistComuNicknm());
		model.addAttribute("isArtist", chatChannelVO.isArtist());
		model.addAttribute("isHasMembership", chatChannelVO.isHasMembership());
		model.addAttribute("myComuNicknm", chatChannelVO.getMyComuNicknm());
		model.addAttribute("initialMessageJson", initialMessageJson);
		model.addAttribute("messageOffset", initialmessageLimit);
		
		log.info("Loaded detail for channel {}. Current User: {}, IsArtist: {}, HasMembership: {}, Initial Messages: {}",
				chatChannelVO.getChatChannelNo(), username, chatChannelVO.isArtist(), chatChannelVO.isHasMembership(), 
				chatChannelVO.getInitialMessages() != null ? chatChannelVO.getInitialMessages().size() : 0);
		
		return "chat/dm/channeldetail";	// 뷰 이름 반환
	}
	
	// 추가 메세지 더보기 이용
	@GetMapping("/channel/{chatChannelNo}/more-messages")
	@ResponseBody	// HTTP 응답 본문 변환
	public ResponseEntity<List<ChatMessageVO>> getMoreMessages(
			@PathVariable int chatChannelNo,
			@RequestParam(defaultValue = "0") int offset,
			@RequestParam(defaultValue = "50") int limit
			) {
		List<ChatMessageVO> messages = chatMessageService.getChatMessagesByChannelPaged(chatChannelNo, offset, limit);
		
		System.out.println("조회된 메시지 수: " + messages.size());
        System.out.println("클라이언트 요청 offset: " + offset + ", limit: " + limit);
        
		return ResponseEntity.ok(messages);
	}
	
	
	// 특정 채팅방과 해당 아티스트 조회
	@GetMapping("/channel/{chatChannelNo}")
	@ResponseBody
	public ChatChannelVO channelInfo(@PathVariable int chatChannelNo) {
		return chatChannelService.findChatChannelWithArtistInfo(chatChannelNo);
	}
	
	// 이미지 파일 업로드
	@PostMapping("/uploadImage")
	@ResponseBody
	@Transactional
	public ResponseEntity<Map<String, Object>> uploadImage(
			@RequestParam MultipartFile file,
			@RequestParam Integer chatChannelNo,
			Principal principal
			) {
		
		if(file.isEmpty()) {
			return new ResponseEntity<>(Map.of("message", "첨부된 파일이 없습니다."), HttpStatus.BAD_REQUEST);
		}
		
		String username = principal.getName();
		
		try {
			// 1. 파일 업로드 및 DB 저장
			Integer fileGroupNo = fileService.uploadAndProcessFiles(new MultipartFile[] {file}, "FITC005", username);
			
			if(fileGroupNo == null || fileGroupNo <= 0) {
				return new ResponseEntity<>(Map.of("message", "파일 그룹 생성 실패"), HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			List<AttachmentFileDetailVO> fileDetails = fileService.getFileDetailsByGroupNo(fileGroupNo);
			String fileUrl = null;
			Integer attachDetailNo = null;
			
			if(!fileDetails.isEmpty()) {
				AttachmentFileDetailVO uploadedFile = fileDetails.get(0);
				fileUrl = uploadedFile.getWebPath();	// 파일의 웹 경로 가져오기
				attachDetailNo = uploadedFile.getAttachDetailNo();
			}
			
			// 2. ChatMessageVO 생성 (파일 메세지)
			ChatMessageVO chatMessage = new ChatMessageVO();
			chatMessage.setUsername(username);
			chatMessage.setChatChannelNo(chatChannelNo);
			chatMessage.setType(ChatMessageVO.MessageType.FILE);
			chatMessage.setChatMsgTypeCode("CMTC002");
			chatMessage.setChatContent(file.getOriginalFilename());
			chatMessage.setAttachDetailNo(attachDetailNo);
			chatMessage.setFileUrl(fileUrl);
			chatMessage.setChatSendDate(new Date());
			
			// 3. STOMP 메세지 전송
			chatMessageService.saveAndProcessChatMessage(chatMessage, principal);
			
			Map<String, Object> response = new HashMap<>();
			response.put("fileGroupNo", fileGroupNo);
			response.put("fileUrl", fileUrl);
			response.put("attachDetailNo", attachDetailNo);
			response.put("message", "파일 업로드 및 메세지 전송 성공");
			
			return new ResponseEntity<>(response, HttpStatus.OK);
			
		} catch (Exception e) {
			log.error("채팅 이미지 업로드 중 오류 발생", e);
			return new ResponseEntity<>(Map.of("message", "파일 업로드 실패 : " + e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	@GetMapping("/total-unread-count")
	public ResponseEntity<Integer> getTotalUnreadCount(Principal principal) {
		if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
		// 현재 로그인한 사용자 아이디, 아티스트 여부 조회
        String username = principal.getName();
        Authentication currentUserAuth = SecurityContextHolder.getContext().getAuthentication();
        boolean isArtist = currentUserAuth.getAuthorities().stream()
				.anyMatch(a -> a.getAuthority().equals("ROLE_ARTIST"));
        
        int totalUnreadCount = chatChannelService.getTotalUnreadMessageCount(username, isArtist);
        return ResponseEntity.ok(totalUnreadCount);
	}
	
}
