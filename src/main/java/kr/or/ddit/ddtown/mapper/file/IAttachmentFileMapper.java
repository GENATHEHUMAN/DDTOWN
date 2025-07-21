package kr.or.ddit.ddtown.mapper.file;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.file.AttachmentFileGroupVO;

@Mapper
public interface IAttachmentFileMapper {
	
	/** 파일그룹 생성 */
	public void insertFileGroup(AttachmentFileGroupVO groupVO);

	/** 개별파일 생성 */
	public void insertFileDetail(AttachmentFileDetailVO fileDetail);
	
	/** 파일그룹번호로 개별파일 조회 */
	public List<AttachmentFileDetailVO> selectFileDetailsByGroupNo(int fileGroupNo);
	
	/** 파일그룹번호로 대표이미지 조회 */
	public AttachmentFileDetailVO selectRepresentativeFileByGroupNo(int fileGroupNo);
	
	/** 파일그룹번호로 파일상세번호 삭제 */
	public void deleteFileDetailsByGroupNo(int fileGroupNo);

	/** 파일그룹 삭제 */
	public void deleteFileGroup(int fileGroupNo);

	/** 개별파일 조회 */
	public AttachmentFileDetailVO selectFileDetail(Integer attachDetailNo);
	
	/** 개별파일 삭제 */
	public void deleteFileDetail(Integer attachDetailNo);

	/** 파일 그룹에 속한 개별 파일 상세 수 조회 */
	public int countFilesInGroup(int currentFileGroupNo);

	/** 다운로드 용 */
	public AttachmentFileDetailVO getFileInfo(int fileDetailNo);



}
