package kr.or.ddit.vo.goods;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.Data;

@Data
public class goodsNoticeVO implements Serializable {
	private int goodsNotiNo; //공지 번호
	private String empUsername; //공지 작성자
	private Integer fileGroupNo; // int 대신 Integer로 선언하여 null을 허용 (파일 없을 시)
	private String goodsNotiTitle; //공지 제목
	private String goodsNotiContent; //공지 내용
	private Date goodsRegDate; //공지 작성 일시
	private Date goodsModDate; //공지 수정 일시
	
	private String title;
	private MultipartFile[] goodsNotiFiles; // 파일 첨부를 위한 필드
	private List<Integer> deleteAttachDetailNos; // 수정 시 삭제할 기존 파일 상세 번호 목록
	
	private List<AttachmentFileDetailVO> fileDetailList; //첨부 파일 상세 정보를 담을 리스트!
	
    // 아티스트 그룹 이름을 담을 필드 추가
	private Integer artGroupNo; // PK
    private String artGroupNm;
    private String artGroupDelYn;
    
}
