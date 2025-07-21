package kr.or.ddit.ddtown.mapper.chat.dm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.chat.dm.ChatMessageVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;

@Mapper
public interface ChatMessageMapper {

	// 메세지 저장
	void insertMessage(ChatMessageVO message);

	// 과거 메세지 기록 조회
	List<ChatMessageVO> selectChatMessageByChannelNo(Integer chatChannelNo, int offset, int limit);

	// 파일 첨부 상세 추가
	void insertAttachFileDetail(AttachmentFileDetailVO fileDetailVO);
	
	// 읽지 않은 메세지 조회
	int selectUnreadMessageCount(@Param("chatChannelNo") Integer chatChannelNo,
								@Param("username") String username, boolean isArtist);

	// 마지막 메세지 번호 조회
	Integer selectLastMessageNo(Integer chatChannelNo);
	
	// 가장 최근 메세지 1개 조회
	ChatMessageVO selectLastChatMessage(@Param("chatChannelNo") Integer chatChannelNo,
			String currentUser, boolean isArtist);
	
	// 더보기 : 페이지네이션 조회
	List<ChatMessageVO> selectChatMessagesByChannelPaged(Integer chatChannelNo, int offset, int limit);

}
