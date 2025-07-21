package kr.or.ddit.ddtown.service.emp.audition;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.emp.audition.IEmpAuditionMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.audition.AuditionUserVO;
import kr.or.ddit.vo.corporate.audition.AuditionVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmpAuditionServiceImpl implements IEmpAuditionService {
	
	@Autowired
	private IEmpAuditionMapper empAuditionMapper;
	
	@Autowired
    private IFileService fileService;
	
	private static final String FILETYPECODE = "FITC003";
	
	//오디션 목록
	@Override
	public List<AuditionVO> auditionList(PaginationInfoVO<AuditionVO> pagingVO) {
		return empAuditionMapper.auditionList(pagingVO);
	}
	//오디션일정 상세보기
	@Override
	public AuditionVO detailAudition(int audiNo) {
		return empAuditionMapper.detailAudition(audiNo);
	}
	//오디션 등록하기
	@Override
	public ServiceResult insertAudition(AuditionVO auditionVO) throws Exception {
		// 파일 업로드 처리 및 파일 그룹 번호 생성
        if (auditionVO.getAudiMemFiles() != null && auditionVO.getAudiMemFiles().length > 0 && !auditionVO.getAudiMemFiles()[0].isEmpty()) {
            // 파일 타입 코드 사용
            Integer fileGroupNo = fileService.uploadAndProcessFiles(auditionVO.getAudiMemFiles(), FILETYPECODE);
            auditionVO.setFileGroupNo(fileGroupNo);
        }else {
        	auditionVO.setFileGroupNo(null);
        }
        
        int status = empAuditionMapper.insertAudition(auditionVO);
        if(status > 0) {
        	 return ServiceResult.OK;	//성공
        }
        	return ServiceResult.FAILED;//실패
		
	}
	//오디션 수정하기
	@Transactional
	@Override
	public ServiceResult updateAudition(AuditionVO auditionVO) throws Exception {
		log.info("updateAudition->auditionVO : " + auditionVO);
		// 파일 그룹(1), 파일 상세(N)
		// 수정을 진행하기 위해서는?
		// 파일쪽이 먼저 수정되고 이때, 파일 그룹번호의 생성 유무를 따져야한다.
		
		// 기존 파일 갯수와 삭제 파일 갯수 비교하기 위해 조회
		AuditionVO audiVO = empAuditionMapper.detailAudition(auditionVO.getAudiNo());
		
		Integer fileGroupNo = audiVO.getFileGroupNo();
//		boolean flag = false;
//		if(true) {
//			// 새롭게 추가된 파일 업로드
//			fileGroupNo = fileService.uploadAndProcessFiles(auditionVO.getAudiMemFiles(), FILETYPECODE);
//			flag = true;
//		}
		//I. 새롭게 추가된 파일이 존재하는지?
		/*
		updateAudition->filename : 스크린샷 2025-05-26 160507.png
		updateAudition->filename : 스크린샷 2025-05-27 103428.png
		 */
//		List<AttachmentFileDetailVO> fileList = auditionVO.getFileList();	// 새롭게 추가될 파일 목록		
		MultipartFile[] fileList = auditionVO.getAudiMemFiles();	// 새롭게 추가될 파일 목록
	
		// 새롭게 추가될 파일 목록이 존재한다면
		if(fileList != null && fileList[0].getOriginalFilename().length() > 0) {
			// 새롭게 추가된 파일 업로드(fileGroupNo가 새로 생김)
			fileGroupNo = fileService.uploadAndProcessFiles(auditionVO.getAudiMemFiles(), FILETYPECODE);// 새로운 번호 부여
//			flag = true;
		}
		//II. 삭제할 파일 내역이 존재하는지?
		List<Integer> delFileList = auditionVO.getDelFileNoList();	// 삭제 해야 할 파일 목록
		
		// 삭제할 내역이 존재한다면 전체삭제 또는 일부 삭제로 진행
		if(!delFileList.isEmpty()) {
//			if(audiVO.getFileList().size() == delFileList.size()) {	// 파일 전체 수정(삭제)
//				fileService.deleteSpecificFiles(delFileList);
//				fileService.deleteFilesByGroupNo(audiVO.getFileGroupNo());
//				if(!flag)
//					fileGroupNo = null;
//				// 파일 타입 코드 사용
//			}else {	// 파일 일부 수정
				fileService.deleteSpecificFiles(delFileList);	//개별파일 삭제
//			}
		}
		
		
		if(fileList != null && fileList[0].getOriginalFilename().length() > 0) {//수정모드에서 파일이 추가될 시에만 실행
			//III-1.기존 파일그룹번호
			Integer  oldFileGroupNo = auditionVO.getFileGroupNo();
			log.info("updateAudition->oldFileGroupNo : " + oldFileGroupNo);
			
			//III-2.새로운 파일그룹번호
			auditionVO.setFileGroupNo(fileGroupNo);
			log.info("updateAudition->newFileGroupNo : " + auditionVO.getFileGroupNo());
			
			//III-3. 기존 파일그룹번호를 가진 ATTACHMENT_FILE_DETAIL 테이블의 FILE_GROUP_NO를 새로운 번호로 업데이트
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("oldFileGroupNo", oldFileGroupNo);
			map.put("newFileGroupNo", fileGroupNo);

			int oldResult = this.empAuditionMapper.updateAttachmentFileDetailFileGroupNo(map);
			log.info("updateAudition->oldResult : " + oldResult);
		}
		
		// VI. 일반데이터를 수정
		int status = empAuditionMapper.updateAudition(auditionVO);
		if(status > 0) {	// 일반데이터 수정 완료
			return ServiceResult.OK;
		}else {									// 일반데이터 수정 실패
			return ServiceResult.FAILED;
		}
	}
	//오디션 일정 삭제
	@Override
	public ServiceResult deleteAudition(int audiNo) {
		ServiceResult result = null;
		// 파일 데이터를 삭제하기 위한 준비
		AuditionVO auditionVO = empAuditionMapper.detailAudition(audiNo);
		
//		empAuditionMapper.selectFileDetailsByGroupNo(fileGroupNo);
		Integer fileGroupNoToDelete = null;
		
		if(auditionVO != null) {
			fileGroupNoToDelete = auditionVO.getFileGroupNo();
		}
		int deleteApplications = empAuditionMapper.deleteApplicantsByAuditionNo(audiNo);
		int row = empAuditionMapper.deleteAudition(audiNo);
		
		if(row>0) {
			if(fileGroupNoToDelete != null && fileGroupNoToDelete > 0) {
        		try {
					fileService.deleteFilesByGroupNo(fileGroupNoToDelete);
				} catch (Exception e) {
				}
        	}
            return ServiceResult.OK;
        } else {
        	return ServiceResult.FAILED;        	
        }
    }
	
	//전체 게시글 수
	@Override
	public int selectAuditionCount(PaginationInfoVO<AuditionVO> pagingVO) {
		return empAuditionMapper.selectAuditionCount(pagingVO);
	}
	//파일 다운로드
	@Override
	public AttachmentFileDetailVO auditionDownload(int attachDetailNo) {
		AttachmentFileDetailVO attachmentFileDetailVO = empAuditionMapper.auditionDownload(attachDetailNo);
		if(attachmentFileDetailVO == null) {
			throw new RuntimeException();
		}
		return attachmentFileDetailVO;
	}
	
	
	//오디션 지원자 목록
	 @Override public List<AuditionUserVO> auditionUserList() {
		 List<AuditionUserVO> auditionUserList = empAuditionMapper.auditionUserList();
		 return auditionUserList; 
	 }
	//오디션지원자 목록의 드롭 리스트
	@Override
	public List<AuditionVO> auditionDropdownList(String auditionStatusCode) {
		
		return empAuditionMapper.auditionDropdownList(auditionStatusCode);
	}
	//오디션지원목록 검색목록
	/*
	 * @Override public List<AuditionUserVO> auditionUserLists(int audiNo) {
	 * 
	 * List<AuditionUserVO> auditionUserLists =
	 * empAuditionMapper.auditionUserLists(audiNo); return auditionUserLists; }
	 */
	//지원자 상세정보
	@Override
	public AuditionUserVO auditionUserDetail(int appNo) {

		return empAuditionMapper.auditionUserDetail(appNo);
	}
	//지원 상태 변환
	@Override
	public AuditionUserVO stauesUpdate(AuditionUserVO auditionUserVO) {
		int status = empAuditionMapper.stauesUpdate(auditionUserVO);
        if(status > 0) {
        	 return auditionUserVO;	//성공
        }
        return null;//실패
//		return empAuditionMapper.stauesUpdate(auditionUserVO);

	}
	//지원자 목 수
	@Override
	public int auditionUserCount(PaginationInfoVO<AuditionUserVO> pagingVO) {
		return empAuditionMapper.auditionUserCount(pagingVO);
	}
	@Override
	//지원자 목록
	public List<AuditionUserVO> auditionUserList(PaginationInfoVO<AuditionUserVO> pagingVO) {
		return empAuditionMapper.auditionUserList(pagingVO);
	}
	//일정 관리의 목록페이지 오디션 진행 현황 수
	@Override
	public Map<String, Integer> auditionStatCnts() {
		
		Map<String, Integer> StatCnts = new HashMap<>();
		StatCnts.put("ADSC001", 0);
		StatCnts.put("ADSC002", 0);
		StatCnts.put("ADSC003", 0);
		
		List<Map<String, Object>> auditionStatCnts = empAuditionMapper.auditionStatCnts();
		 log.info("매퍼 결과 (auditionStatCnts): {}", auditionStatCnts);
		
		for (Map<String, Object> entry  : auditionStatCnts) {
			log.info("처리 중인 entry: {}", entry);
            String StatCode = (String) entry.get("STATCODE"); // DB에서 넘어온 사유 코드
            Integer count = ((Number) entry.get("COUNT")).intValue();
            StatCnts.put(StatCode, count);
            
        }
        return StatCnts;
	}
	
//	//전체/진행/마감된 오디션 드롭 리스트
//	@Override
//	public List<AuditionVO> getAuditionList(String mode) {
//		return this.empAuditionMapper.getAuditionList(mode);
//	}
	
	//심사결과 유형별 수
	@Override
	public Map<String, Integer> appStatCodeCnt(PaginationInfoVO<AuditionUserVO> pagingVO) {
		Map<String, Integer> reasonCnts = new HashMap<>(); 
		
		reasonCnts.put("APSC001", 0);
		reasonCnts.put("APSC002", 0);
		reasonCnts.put("APSC003", 0);
		
		//log.info("searchType : " + searchType);//all, 251(오디션 No)
		
		List<Map<String, Object>> appStatCodeCnt = new ArrayList<Map<String, Object>>();
		
		//if(searchType != null && !searchType.isEmpty() && !searchType.equals("all")) {//전체
			appStatCodeCnt = empAuditionMapper.appStatCodeCnt(pagingVO);
		//}
		log.info("매퍼 결과 (appStatCodeCnt): {}", appStatCodeCnt);
		
		for (Map<String, Object> entry  : appStatCodeCnt) {
			log.info("처리 중인 entry: {}", entry);
            String reasonCode = (String) entry.get("APPSTATCODE"); // DB에서 넘어온 사유 코드
            Integer count = ((Number) entry.get("COUNT")).intValue();
            reasonCnts.put(reasonCode, count);
        }
		
		log.info("reasonCnts(처리 후) : {}", reasonCnts);
		
		return reasonCnts;
	}
	
	//총 지원 수를 위한 파라미터 맵 생성(searchWord 제외(검색영향X))
	@Override
	public int totalApplicantCount(Map<String, Object> totalCountParams) {
		return empAuditionMapper.totalApplicantCount(totalCountParams);
	}
	// 1. "총 오디션" 수를 위한 파라미터 맵 생성(검색영향X)
	@Override
	public int totalReportCount(Map<String, Object> totalCountParams) {
		return empAuditionMapper.totalReportCount(totalCountParams);
	}
	//오디션 일정 자동 변경
	@Override
	public void uploadAuditionScheduler() {
		try {
			LocalDate today = LocalDate.now();	//현재 날짜			
			
			// 1-1. AUDITION 테이블 업데이트(오디션 진행중으로 변경)
			int statSchedulerCount = empAuditionMapper.statSchedulerCount(today);			
			log.info("오디션 시작일정 변경 성공! AUDITION {}건 처리됨.", statSchedulerCount);
			// 1-2. AUDITION 테이블 업데이트(오디션 마감으로 변경)
			int endSchedulerCount = empAuditionMapper.endSchedulerCount(today);			
			log.info("오디션 종료일정 변경 성공! AUDITION {}건 처리됨.", endSchedulerCount);
			
			if(endSchedulerCount == 0 && statSchedulerCount == 0) {
				log.info("오디션 일정 변경 대상이 없습니다. (날짜: {})", today);
			}
			
		}catch(Exception e) {
			log.error("오디션 일정 변경 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("오디션 일정 변경 실패", e);
		}
		
	}
}
