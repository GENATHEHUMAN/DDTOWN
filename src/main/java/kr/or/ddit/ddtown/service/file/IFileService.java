package kr.or.ddit.ddtown.service.file;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;

public interface IFileService {
	
	
	/**
     * 다수 파일 업로드, 파일 그룹 번호 반환
     * 파일 그룹 생성, 파일 상세 정보 DB 저장
     * @param MultipartFile
     * @param fileTypeCode 파일 타입 구분 코드 (예: "CONCERT_SCHEDULE", "NOTICE")
     * @return 생성된 파일 그룹 번호 (성공 시), 실패 시 null 또는 예외 발생
     * @throws Exception
     */
    public Integer uploadAndProcessFiles(MultipartFile[] files, String fileTypeCode, String uploaderId) throws Exception;
    
    
    /**
     * 작성자 없는 게시물에 사용하세여
     * uploaderId 없는 메소드
     * @param files
     * @param fileTypeCode
     * @return
     * @throws Exception
     */
    public Integer uploadAndProcessFiles(MultipartFile[] files, String fileTypeCode) throws Exception;

    /**
     * 파일 그룹 번호로 첨부파일 목록을 가져오기
     * @param fileGroupNo
     * @return
     * @throws Exception
     */
    public List<AttachmentFileDetailVO> getFileDetailsByGroupNo(int fileGroupNo) throws Exception;

    /**
     * 파일 그룹 번호로 대표 이미지 파일 정보 가져옴
     * @param fileGroupNo
     * @return
     * @throws Exception
     */
    public AttachmentFileDetailVO getRepresentativeFileByGroupNo(int fileGroupNo) throws Exception;

    /**
     * 파일 그룹에 속한 모든 파일 및 그룹 정보 삭제
     * @param fileGroupNo
     * @throws Exception
     */
    public void deleteFilesByGroupNo(int fileGroupNo) throws Exception;
    
    
    /**
     * 파일 개별 삭제 처리
     * @param attachDetailNos
     * @param fileGroupNo
     * @throws Exception
     */
    public void deleteSpecificFiles(List<Integer> attachDetailNos) throws Exception;
    
    public int countFilesInGroup(int currentFileGroupNo);

	public AttachmentFileDetailVO getFileInfo(int fileDetailNo);
	
	/**
     * 특정 파일 그룹에 새로운 파일들을 추가합니다.
     * 파일 상세 정보만 추가하며, 파일 그룹 자체는 변경하지 않습니다.
     *
     * @param files 업로드할 MultipartFile 배열
     * @param fileTypeCode 파일 타입 구분 코드 (예: "FITC012")
     * @param uploaderId 업로더 ID (작성자 정보)
     * @param existingFileGroupNo 파일을 추가할 기존 파일 그룹 번호
     * @return 성공 시 기존 파일 그룹 번호, 추가할 파일이 없거나 실패 시 null (또는 예외 처리)
     * @throws Exception 파일 처리 중 발생할 수 있는 예외
     */
     public Integer addFilesToExistingGroup(MultipartFile[] files, String fileTypeCode, String uploaderId, int existingFileGroupNo) throws Exception;
}
