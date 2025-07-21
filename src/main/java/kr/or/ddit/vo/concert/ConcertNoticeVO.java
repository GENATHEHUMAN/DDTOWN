package kr.or.ddit.vo.concert;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.BaseVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
public class ConcertNoticeVO extends BaseVO{

	private int concertNotiNo;							// 공지 번호
	private String empUsername;							// 공지 작성자
	private String concertNotiTitle;					// 공지 제목
	private String concertNotiContent;					// 공지 내용
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date concertRegDate;						// 공지 작성일시
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date concertModDate;						// 공지 수정일시
	
	// 첨부파일
	private MultipartFile[] noticeFiles;				// 업로드 파일들
	private String representativeImageUrl;				// 대표이미지 
	private Integer fileGroupNo;						// 파일 그룹번호
	private List<AttachmentFileDetailVO> attachmentFileList;	// 상세보기 전체파일 목록
	
	private List<Integer> deleteFileNos;				// 삭제할 파일번호
	
	
	public ConcertNoticeVO(int page, String searchType, String searchWord) {
		super(page, searchType, searchWord);
	}
}
