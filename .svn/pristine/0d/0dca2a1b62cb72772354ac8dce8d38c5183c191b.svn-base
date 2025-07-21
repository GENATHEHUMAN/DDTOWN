package kr.or.ddit.ddtown.service.admin.notice;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ddtown.mapper.admin.notice.AdminNoticeMapper;
import kr.or.ddit.ddtown.mapper.file.IAttachmentFileMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.file.AttachmentFileGroupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {
	
	@Autowired
	private AdminNoticeMapper mapper;					// 공지 매퍼
	
	@Autowired
	private IFileService fileService;
	
	@Autowired
	private IAttachmentFileMapper groupMapper;			// 파일 그룹 매퍼
	
	@Value("${kr.or.ddit.upload.path}")
	private String windowUploadBasePath;
	
	@Value("${kr.or.ddit.upload.path.mac}")
	private String macUploadBasePath;
	
	private SimpleDateFormat KST_DATE_FORMAT = new SimpleDateFormat("yyyy/MM/dd");
	
	@Override
	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectTotalRecord(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectNoticeList(pagingVO);
	}

	@Override
	public NoticeVO getDetail(int id) {
		return mapper.getDetail(id);
	}

	@Transactional
	@Override
	public void createNotice(NoticeVO noticeVO) {
		
		// 1. 현재 OS에 맞는 기본 업로드 경로 선택
        String os = System.getProperty("os.name").toLowerCase();
        String currentUploadBasePath;
        
        if(os.contains("mac") || os.contains("darwin")) {
        	currentUploadBasePath = macUploadBasePath;
        } else if(os.contains("win")) {
        	currentUploadBasePath = windowUploadBasePath;
        } else {
        	log.warn("알 수 없는 OS 환경입니다. window 경로를 사용합니다.");
        	currentUploadBasePath = windowUploadBasePath;
        }
		
        String datePath = KST_DATE_FORMAT.format(new Date());	// 폴더 날짜값으로 저장
        File finalUploadDirectory = new File(currentUploadBasePath + "/" + datePath);	// 기본경로 + 폴더

        MultipartFile[] boFiles = noticeVO.getBoFile();
		Integer generatedFileGroupNo = null;
		
		if(!finalUploadDirectory.exists()) {
			boolean created = finalUploadDirectory.mkdirs();
			if(!created) {
				log.error("파일 디렉토리 생성 실패: {}", currentUploadBasePath);
				throw new RuntimeException("파일 저장 경로를 생성할 수 없습니다.");
			}
		}
		
		if(boFiles != null && boFiles.length > 0 && !boFiles[0].isEmpty()) {
			AttachmentFileGroupVO groupVO = new AttachmentFileGroupVO();
			groupVO.setFileTypeCode("FITC001");
			groupVO.setFileTypeNm("기업공지 파일");
			groupMapper.insertFileGroup(groupVO);	// 파일 그룹 생성 및 ID 반환
			generatedFileGroupNo = groupVO.getFileGroupNo();
			
			// 실제 파일 저장 및 상세 정보 DB 저장
			saveUploadFiles(boFiles, generatedFileGroupNo, finalUploadDirectory, datePath);
		} else {
			log.info("첨부 파일이 없습니다.");
		}
		noticeVO.setFileGroupNo(generatedFileGroupNo);	// 파일 그룹 ID 설정
		mapper.insertNotice(noticeVO);
	}
	
	@Transactional
	@Override
	public int modifyNotice(NoticeVO noticeVO, List<Integer> deleteFileNos) throws Exception {
		
		// 1. 기존 공지사항 정보 조회
		NoticeVO oldNotice = mapper.getDetail(noticeVO.getEntNotiNo());
		Integer oldFileGroupNo = null;
		
		// 첨부 파일이 없을 경우
		if(oldNotice != null && oldNotice.getFileGroupNo() != null) {
			oldFileGroupNo = oldNotice.getFileGroupNo();
		}
		
		Integer finalFileGroupNo = oldFileGroupNo;

		// 2. 삭제 요청된 파일 상세 번호 처리 (물리적 삭제)
		if(deleteFileNos != null && !deleteFileNos.isEmpty()) {
			log.info("삭제 요청된 파일 상세 번호 목록: {}", deleteFileNos);
			fileService.deleteSpecificFiles(deleteFileNos);
		}
		
		// 3. 기존 파일 그룹 처리 로직
		if(oldFileGroupNo != null) {
			int remainFile = fileService.countFilesInGroup(oldFileGroupNo);
			
			if(remainFile == 0) {	// 기존 파일 그룹에 더 이상 파일이 없는 경우
				mapper.updateNoticeFileGroupToNull(noticeVO.getEntNotiNo());
				fileService.deleteFilesByGroupNo(oldFileGroupNo);			
				finalFileGroupNo = null;
			} else {
				// 파일 남아있으면 기존 그룹 번호 유지
				finalFileGroupNo = oldFileGroupNo;
			}
		} else {
			// 기존 파일 그룹이 없었음
			finalFileGroupNo = null;
		}
		
		// 4. 새로운 파일이 첨부되었는지 확인하고 처리
		MultipartFile[] newBoFiles = noticeVO.getBoFile();
		boolean hasNewFiles = (newBoFiles != null && newBoFiles.length > 0 && !newBoFiles[0].isEmpty());
		
		if(hasNewFiles) {
			
			String os = System.getProperty("os.name").toLowerCase();
	        String currentUploadBasePath;
	        
	        if(os.contains("mac") || os.contains("darwin")) {
	        	currentUploadBasePath = macUploadBasePath;
	        } else if(os.contains("win")) {
	        	currentUploadBasePath = windowUploadBasePath;
	        } else {
	        	log.warn("알 수 없는 OS 환경입니다. window 경로를 사용합니다.");
	        	currentUploadBasePath = windowUploadBasePath;
	        }
			
	        String datePath = KST_DATE_FORMAT.format(new Date());	// 폴더 날짜값으로 저장
	        File finalUploadDirectory = new File(currentUploadBasePath + "/" + datePath);	// 기본경로 + 폴더
			
            AttachmentFileGroupVO newGroupVO = new AttachmentFileGroupVO();
            newGroupVO.setFileTypeCode("FITC001");
            newGroupVO.setFileTypeNm("기업공지 파일");
            groupMapper.insertFileGroup(newGroupVO);
            finalFileGroupNo = newGroupVO.getFileGroupNo();
            saveUploadFiles(newBoFiles, finalFileGroupNo, finalUploadDirectory, datePath);
		}
		
		// 5. 공지사항 정보 업데이트
		noticeVO.setFileGroupNo(finalFileGroupNo);
		int res = mapper.modifyNotice(noticeVO);
		
		if(res > 0) {
			log.info("공지 수정 성공 (ID: {})", noticeVO.getEntNotiNo());
		} else {
			log.warn("공지 수정 실패 (ID: {}", noticeVO.getEntNotiNo());
			throw new Exception("공지사항 수정 실패");
		}
		return res;
	}
	
	@Transactional
	@Override
	public boolean deleteNotice(int id) throws Exception {
		NoticeVO noticeVO = mapper.getDetail(id);
		
		boolean noticeDeleted = mapper.deleteNotice(id);
		
		if(noticeVO != null && noticeVO.getFileGroupNo() != null) {
			Integer fileGroupNo = noticeVO.getFileGroupNo();
			fileService.deleteFilesByGroupNo(fileGroupNo);
			groupMapper.deleteFileGroup(fileGroupNo);
		} else {
			log.info("\"공지사항 (ID: {})에 연결된 파일 그룹이 없거나 유효하지 않습니다. 파일 삭제 건너뜁니다.", id);
		}
		return noticeDeleted;
	}
	
	private void saveUploadFiles(MultipartFile[] boFiles, int generatedFileGroupNo,
								File finalUploadDirectory, String datePath
								) {
		for(MultipartFile file : boFiles) {
			if(!file.isEmpty()) {
				String originalFileName = file.getOriginalFilename();
				String fileExtension = "";
				if(originalFileName != null && originalFileName.contains(".")) {
					fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				}
				String cleanExtension = fileExtension.startsWith(".") ? fileExtension.substring(1) : fileExtension;
				String saveFileName = UUID.randomUUID().toString() + fileExtension;
				long fileSize = file.getSize();
				String fileContentType = file.getContentType();
				
				File saveFile = new File(finalUploadDirectory, saveFileName);
				
				try {
					file.transferTo(saveFile);
					
					AttachmentFileDetailVO detailVO = new AttachmentFileDetailVO();
					detailVO.setFileGroupNo(generatedFileGroupNo);
					detailVO.setFileOriginalNm(originalFileName);
					detailVO.setFileSaveNm(saveFileName);
					detailVO.setFileSavepath(datePath);
					detailVO.setFileFancysize(fancysize(fileSize));
					detailVO.setFileMimeType(fileContentType);
					detailVO.setFileExt(cleanExtension);
					groupMapper.insertFileDetail(detailVO);
					log.info("파일 상세 정보 DB 저장 성공: {}", originalFileName);
					
				} catch (IOException e) {
					log.error("파일 저장 중 오류 발생 : {}", e.getMessage(), e);
					throw new RuntimeException("파일 저장 중 오류 발생 : {}", e);
				}
			}
		}
	}

	private String fancysize(long fileSize) {
		
		DecimalFormat df = new DecimalFormat("0.00");
		if(fileSize < 1024) {
			return fileSize + " Bytes";
		} else if(fileSize < (1024 * 1024)) {
			return df.format((double) fileSize / 1024) + " KB";
		} else {
			return df.format((double) fileSize / (1024 * 1024)) + " MB";
		}
	}

	@Override
	public List<NoticeVO> selectRecentList() {
		return mapper.selectRecentList();
	}

	// 통계용 시작
	@Override
	public int getTotalNoticeCnt() {
		return mapper.getTotalNoticeCnt();
	}

	@Override
	public int getGongjiPrefixCnt() {
		return mapper.getGongjiPrefixCnt();
	}

	@Override
	public int getAnnaePrefixCnt() {
		return mapper.getAnnaePrefixCnt();
	}
	
}
