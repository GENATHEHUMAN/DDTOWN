package kr.or.ddit.vo.corporate.audition;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.Data;

@Data
public class AuditionVO {

	private int audiNo;				//오디션 공고 번호
	private String empUsername; 	//오디션 담당자
	private String audiTypeCode; 	//모집 분야 코드
	private String audiStatCode; 	//진행 상태 코드
	private Integer fileGroupNo;		//첨부 파일   Integer: 첨부파일 없을 시 detail에 표시 안되게 하려고 씀
	private String audiTitle;		//오디션 제목
	private String audiContent;		//오디션 내용
	private String audiStartDate;	//지원 접수 시작일
	private String audiEndDate;		//지원 접수 마감일
	private String audiRegDate;		//공고 등록일시
	private String audiModDate;		//공고 수정일시
	
	private int attachDetailNo;     // 파일 상세 번호 
	private MultipartFile[] audiMemFiles;	// 업로드 파일들
	private List<AttachmentFileDetailVO> fileList;	//파일명
	private List<Integer> delFileNoList =  new ArrayList<>();  // 삭제 요청된 기존 파일들의 ATTACH_DETAIL_NO 리스트
	
	public void setBoFile(MultipartFile[] audiMemFiles) {
		this.audiMemFiles = audiMemFiles;
		
		if(audiMemFiles != null) {
			List<AttachmentFileDetailVO> audiFileList = new ArrayList<>();
			for(MultipartFile item : audiMemFiles) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				
				AttachmentFileDetailVO noticeFileVO = new AttachmentFileDetailVO(item);
				audiFileList.add(noticeFileVO);
			}
			this.fileList = audiFileList;
		}
	}

	@Override
	public String toString() {
		return "AuditionVO [audiNo=" + audiNo + ", " + (empUsername != null ? "empUsername=" + empUsername + ", " : "")
				+ (audiTypeCode != null ? "audiTypeCode=" + audiTypeCode + ", " : "")
				+ (audiStatCode != null ? "audiStatCode=" + audiStatCode + ", " : "")
				+ (fileGroupNo != null ? "fileGroupNo=" + fileGroupNo + ", " : "")
				+ (audiTitle != null ? "audiTitle=" + audiTitle + ", " : "")
				+ (audiContent != null ? "audiContent=" + audiContent + ", " : "")
				+ (audiStartDate != null ? "audiStartDate=" + audiStartDate + ", " : "")
				+ (audiEndDate != null ? "audiEndDate=" + audiEndDate + ", " : "")
				+ (audiRegDate != null ? "audiRegDate=" + audiRegDate + ", " : "")
				+ (audiModDate != null ? "audiModDate=" + audiModDate + ", " : "")
				+ (audiMemFiles != null ? "audiMemFiles=" + Arrays.toString(audiMemFiles) + ", " : "")
				+ (fileList != null ? "fileList=" + fileList + ", " : "")
				+ (delFileNoList != null ? "delFileNoList=" + delFileNoList : "") + "]";
	}
	
	
	
	
	
	
}
