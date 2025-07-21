package kr.or.ddit.ddtown.service.admin.report;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.report.ReportVO;

public interface IReportService {
	//신고 목록페이지
	public List<ReportVO> reportList(PaginationInfoVO<ReportVO> pagingVO);
	//신고 목록 수
	public int selectReportCount(PaginationInfoVO<ReportVO> pagingVO);
	
	//신고 상세페이지
	public ReportVO reportDetail(int reportNo);
	//신고 처리
	public ServiceResult reportUpdate(ReportVO reportVO);
	
	//뱃지: 신고 미처리 수
	public int reportCnt();
	//뱃지: 신고 사유 유형별 수
	public Map<String, Integer> reportReasonCnt();
	//뱃지: "총 신고" 수를 위한 파라미터 맵 생성(검색영향X)
	public int totalReportCount(Map<String, Object> totalCountParams);

	/**
	 * 신고 수 가져오기
	 * @return
	 */
	public int getReportCnt();
	
	//블랙리스트 상세페이지에 신고 목록 불러오기
	public List<ReportVO> userReports(String memId, PaginationInfoVO<ReportVO> pagingVO);
	//블랙리스트 상세페이지의 신고 수
	public int countUserReports(String memId, PaginationInfoVO<ReportVO> pagingVO);

}
