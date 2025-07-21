package kr.or.ddit.vo.corporate.audition;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.Data;

@Data
public class AuditionUserVO {
	
	private int appNo;				//지원서 번호
	private int audiNo;				//오디션 번호
	private String appStatCode;		//지원서 처리 상태 코드
	
	private String applicantNo;		//지원자 번호
	private String applicantNm;		//지원자 이름
	private String applicantBirth;	//지원자 생년월일
	private String applicantGender;	//지원자 성별
	private String applicantPhone;	//지원자 연락처
	private String applicantEmail;	//지원자 이메일
	private String appCoverLetter;	//자기소개서
	private String appRegDate;		//지원서 등록일시
	private String applicantAgree;	//개인정보 동의
	
	private String audiTitle;	//오디션 종류
	private String audiTypeCode;	//모집분류
	
	private MultipartFile[] audiMemFiles;	// 업로드 파일들
	private List<AttachmentFileDetailVO> fileList; //파일명
	private Integer fileGroupNo;	//파일 그룹 번호
	
	private AuditionVO audition; // 지원한 오디션 정보 (AuditionVO)
	//private List<AttachmentFileDetailVO> submittedFiles; // 제출한 파일 정보 목록 (AttachmentFileDetailVO 리스트)

}
