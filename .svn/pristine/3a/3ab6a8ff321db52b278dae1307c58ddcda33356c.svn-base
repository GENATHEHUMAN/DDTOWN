package kr.or.ddit.vo.edms;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.Data;

@Data
public class EdmsVO {
	private int edmsNo;
	private int formNo;
	private String empUsername;
	private int fileGroupNo;
	private String edmsStatCode;
	private String edmsTitle;
	private String edmsContent;
	private Date edmsReqDate;
	private String edmsUrgenYn;
	private String empName;
	private String edmsManageNo;
	private String formNm;
	private int rnum;
	private List<AttachmentFileDetailVO> fileList;
	private List<Integer> deleteFileList;

	private MultipartFile[] addFileList;

	private List<ApproverVO> addApproverList;	// 결재자 추가
	private List<ReferenceVO> addReferenceList;	// 참조자 추가

	private List<ApproverVO> approverList;	// 결재자 리스트
	private List<ReferenceVO> referenceList;	// 참조자 리스트

	private int approverCnt; // 결재자문서이면 1 아니면 0
}
