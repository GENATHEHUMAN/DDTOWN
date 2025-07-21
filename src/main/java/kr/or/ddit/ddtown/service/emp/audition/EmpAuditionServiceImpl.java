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
		AuditionVO audiVO = empAuditionMapper.detailAudition(auditionVO.getAudiNo());
		
		Integer fileGroupNo = audiVO.getFileGroupNo();
		MultipartFile[] fileList = auditionVO.getAudiMemFiles();	// 새롭게 추가될 파일 목록
	
		// 새롭게 추가될 파일 목록이 존재한다면
		if(fileList != null && fileList[0].getOriginalFilename().length() > 0) {
			// 새롭게 추가된 파일 업로드(fileGroupNo가 새로 생김)
			fileGroupNo = fileService.uploadAndProcessFiles(auditionVO.getAudiMemFiles(), FILETYPECODE);// 새로운 번호 부여
		}
		List<Integer> delFileList = auditionVO.getDelFileNoList();	
		if(!delFileList.isEmpty()) {
			fileService.deleteSpecificFiles(delFileList);	//개별파일 삭제
		}
		
		
		if(fileList != null && fileList[0].getOriginalFilename().length() > 0) {//수정모드에서 파일이 추가될 시에만 실행
			Integer  oldFileGroupNo = auditionVO.getFileGroupNo();
			log.info("updateAudition->oldFileGroupNo : " + oldFileGroupNo);
			
			auditionVO.setFileGroupNo(fileGroupNo);
			log.info("updateAudition->newFileGroupNo : " + auditionVO.getFileGroupNo());
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("oldFileGroupNo", oldFileGroupNo);
			map.put("newFileGroupNo", fileGroupNo);

			int oldResult = this.empAuditionMapper.updateAttachmentFileDetailFileGroupNo(map);
			log.info("updateAudition->oldResult : " + oldResult);
		}
		
		int status = empAuditionMapper.updateAudition(auditionVO);
		if(status > 0) {	
			return ServiceResult.OK;
		}else {									// 일반데이터 수정 실패
			return ServiceResult.FAILED;
		}
	}

	
	@Override
	public ServiceResult deleteAudition(int audiNo) {
		ServiceResult result = null;

		AuditionVO auditionVO = empAuditionMapper.detailAudition(audiNo);
		
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
	
	
	//심사결과 유형별 수
	@Override
	public Map<String, Integer> appStatCodeCnt(PaginationInfoVO<AuditionUserVO> pagingVO) {
		Map<String, Integer> reasonCnts = new HashMap<>(); 
		
		reasonCnts.put("APSC001", 0);
		reasonCnts.put("APSC002", 0);
		reasonCnts.put("APSC003", 0);
		
	
		List<Map<String, Object>> appStatCodeCnt = new ArrayList<Map<String, Object>>();
			appStatCodeCnt = empAuditionMapper.appStatCodeCnt(pagingVO);
		log.info("매퍼 결과 (appStatCodeCnt): {}", appStatCodeCnt);
		
		for (Map<String, Object> entry  : appStatCodeCnt) {
			log.info("처리 중인 entry: {}", entry);
            String reasonCode = (String) entry.get("APPSTATCODE"); 
            Integer count = ((Number) entry.get("COUNT")).intValue();
            reasonCnts.put(reasonCode, count);
        }
		
		log.info("reasonCnts(처리 후) : {}", reasonCnts);
		
		return reasonCnts;
	}
	
	
	@Override
	public int totalApplicantCount(Map<String, Object> totalCountParams) {
		return empAuditionMapper.totalApplicantCount(totalCountParams);
	}
	
	@Override
	public int totalReportCount(Map<String, Object> totalCountParams) {
		return empAuditionMapper.totalReportCount(totalCountParams);
	}
	
	@Override
	public void uploadAuditionScheduler() {
		try {
			LocalDate today = LocalDate.now();	//현재 날짜			
			
			int statSchedulerCount = empAuditionMapper.statSchedulerCount(today);			
			log.info("오디션 시작일정 변경 성공! AUDITION {}건 처리됨.", statSchedulerCount);
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
