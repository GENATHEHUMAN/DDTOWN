package kr.or.ddit.vo.corporate.notice;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.BaseVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)	// equals/hashCode 생성
@ToString(callSuper = true)
@NoArgsConstructor
public class NoticeVO extends BaseVO{
	
	// 게시글 고유 정보
	private int entNotiNo;
	private String empUsername;
	private Integer fileGroupNo;
	private String entNotiTitle;
	private String entNotiContent;
	private Date entNotiRegDate;
	private Date entNotiModDate;
	
	private int rownum;
	
	private List<AttachmentFileDetailVO> attachmentList;
	
	// 파일 업로드 및 관리용 필드 
	private MultipartFile[] boFile;
	private List<Integer> deleteFileNos;
	
	
	public NoticeVO(int page, String searchType, String searchWord) {
		super(page, searchType, searchWord);
	}
	
}

