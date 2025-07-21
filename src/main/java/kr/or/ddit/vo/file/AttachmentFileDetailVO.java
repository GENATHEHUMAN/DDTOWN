package kr.or.ddit.vo.file;

import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttachmentFileDetailVO {

	private MultipartFile item;
	private int attachDetailNo;     // 파일 상세 번호
    private int fileGroupNo;        // 파일 그룹 번호
    private String fileOriginalNm;  // 원본 파일명
    private String fileSaveNm;      // 저장 파일명 (UUID)
    private String fileSavepath;    // 파일 저장 경로
    private String fileExt;         // 파일 확장자
    private String fileMimeType;    // MIME 타입
    private String fileFancysize;   // 파일 크기 (예: "10KB")
    private long fileSize;          // 실제 파일 크기 (byte) - DB 스키마에 맞게 타입 조절
    private Date fileSaveDate;      // 저장일
    private String uploaderId;		// 업로더

    private String webPath;

	public AttachmentFileDetailVO(MultipartFile item) {
		this.item = item;
		this.fileOriginalNm = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMimeType = item.getContentType();
		this.fileExt = fileSaveNm.substring(fileSaveNm.lastIndexOf(".") + 1);
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}

	public String getWebPath() {
		return "/upload" + "/" + this.fileSavepath + "/" + this.fileSaveNm;
	}
}
