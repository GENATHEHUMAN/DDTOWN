package kr.or.ddit.ddtown.service.admin.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.admin.report.IReportMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.report.ReportVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReportSerivceImpl implements IReportService {

	@Autowired
	private IReportMapper reportMapper;

	@Autowired
	private IFileService fileService;

	//신고 목록페이지
	@Override
	public List<ReportVO> reportList(PaginationInfoVO<ReportVO> pagingVO) {
		return reportMapper.reportList(pagingVO);
	}
	//총 신고 목록 수
	@Override
	public int selectReportCount(PaginationInfoVO<ReportVO> pagingVO) {
		return reportMapper.selectReportCount(pagingVO);
	}

	//신고상세페이지
	@Override
	public ReportVO reportDetail(int reportNo) {
		//상세 기본정보 조회
		ReportVO reportDetail = reportMapper.reportDetail1(reportNo);

		 if (reportDetail != null) {
			 ReportVO paramVO = new ReportVO();
			 paramVO.setReportTargetTypeCode(reportDetail.getReportTargetTypeCode());

			 String targetTypeCode = reportDetail.getReportTargetTypeCode();
	            if ("RTTC001".equals(targetTypeCode)) {			// 게시글 신고인 경우
	                paramVO.setTargetComuPostNo(reportDetail.getTargetComuPostNo());
	            } else if ("RTTC002".equals(targetTypeCode)) {		// 댓글 신고인 경우
	                paramVO.setTargetComuReplyNo(reportDetail.getTargetComuReplyNo());
	            } else if ("RTTC003".equals(targetTypeCode)) {
	                paramVO.setTargetChatNo(reportDetail.getTargetChatNo());
	            }
	            List<ReportVO> individualReports  = reportMapper.reportDetail2(paramVO);

	            reportDetail.setReportedCount(individualReports.size());

	            reportDetail.setIndividualReportList(individualReports);
	            if ("RTTC001".equals(targetTypeCode)) {
	                List<AttachmentFileDetailVO> fileList = reportMapper.reportDetail3(paramVO);
	                try {
						List<AttachmentFileDetailVO> files = fileService.getFileDetailsByGroupNo(fileList.get(0).getFileGroupNo());
						reportDetail.setFileList(files);
					} catch (Exception e) {
						e.printStackTrace();
					}
	            }
		 }
		return reportDetail;
	}

	//신고처리
	@Transactional
	@Override
	public ServiceResult reportUpdate(ReportVO reportVO) {
		ServiceResult result = null;
		int report = reportMapper.reportUpdate(reportVO);
		log.info("reportUpdate->report1 : " + report);

		if(report > 0) {
			report += this.reportMapper.reportUpdate2(reportVO);
			log.info("reportUpdate->report2 : " + report);

			if(reportVO.getReportTargetTypeCode().equals("RTTC001")&&reportVO.getReportResultCode().equals("RRTC002")) {
				report += this.reportMapper.updatePostDelYn(reportVO.getTargetComuPostNo());
				log.info("reportUpdate->report2-1 : " + report);
			}

			if(reportVO.getReportTargetTypeCode().equals("RTTC002")&&reportVO.getReportResultCode().equals("RRTC002")) {
				report += this.reportMapper.updateReplyDelYn(reportVO.getTargetComuPostNo());
				log.info("reportUpdate->report2-2 : " + report);
			}

			if(reportVO.getReportTargetTypeCode().equals("RTTC003")&&reportVO.getReportResultCode().equals("RRTC002")) {
				report += this.reportMapper.deleteChat(reportVO.getTargetComuPostNo());
				log.info("reportUpdate->report2-3 : " + report);
			}

			report += this.reportMapper.reportUpdate3(reportVO);
//
//
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}
	/*
	 * //신고된 게시글의 총신고 수, 신고자들 조회
	 *
	 * @Override public Map<String, Object> getTargetReportSummary(String
	 * reportTargetTypeCode, Integer targetNo) { if (targetNo == null ||
	 * reportTargetTypeCode == null) { return null; } Map<String, Object> paramMap =
	 * new HashMap<>(); paramMap.put("reportTargetTypeCode", reportTargetTypeCode);
	 * //신고 유형코드 paramMap.put("targetNo", targetNo); //게시글 or 댓글 or 메세지 번호 return
	 * reportMapper.selectTargetReportSummary(paramMap); }
	 */
	//신고 미처리 수
	@Override
	public int reportCnt() {
		return reportMapper.reportCnt();
	}
	//신고 사유 유형별 수
	@Override
	public Map<String, Integer> reportReasonCnt() {
		Map<String, Integer> reasonCnts = new HashMap<>();
		// 신고 사유가 없을 때 기본 0으로 표기
		reasonCnts.put("RRC001", 0);
		reasonCnts.put("RRC002", 0);
		reasonCnts.put("RRC003", 0);
		reasonCnts.put("RRC004", 0);

		List<Map<String, Object>> reportReasonCnt = reportMapper.reportReasonCnt();
		log.info("매퍼 결과 (reportReasonCnt): {}", reportReasonCnt);
		for (Map<String, Object> entry  : reportReasonCnt) {
			log.info("처리 중인 entry: {}", entry);
            String reasonCode = (String) entry.get("REASONCODE"); // DB에서 넘어온 사유 코드
            Integer count = ((Number) entry.get("COUNT")).intValue();	//카운트 값을 Integer로 변환
            reasonCnts.put(reasonCode, count);

        }
        return reasonCnts;
	}
	
	@Override
	public int totalReportCount(Map<String, Object> totalCountParams) {
		return reportMapper.totalReportCount(totalCountParams);
	}


	/**
	 * 미처리 신고 가져오기
	 */
	@Override
	public int getReportCnt() {
		return reportMapper.getReportCnt();
	}
	
	@Override
	public List<ReportVO> userReports(String memId, PaginationInfoVO<ReportVO> pagingVO) {
		return reportMapper.userReports(memId, pagingVO);
	}
	
	@Override
	public int countUserReports(String memId, PaginationInfoVO<ReportVO> pagingVO) {
		return reportMapper.countUserReports(memId, pagingVO);
	}
}
