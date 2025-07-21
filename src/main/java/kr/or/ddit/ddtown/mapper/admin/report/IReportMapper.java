package kr.or.ddit.ddtown.mapper.admin.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.report.ReportVO;

@Mapper
public interface IReportMapper {
	//신고 목록페이지
	public List<ReportVO> reportList(PaginationInfoVO<ReportVO> pagingVO);
	//신고 목록 수
	public int selectReportCount(PaginationInfoVO<ReportVO> pagingVO);
	
	//1-1.신고 상세페이지
	public ReportVO reportDetail1(int reportNo);
	//1-2.신고된 게시글의 총신고 수, 신고자들 조회
	public List<ReportVO> reportDetail2(ReportVO paramVO);
	//1-3. 게시글일경우 파일이미지화면에 가지고 오기
	public List<AttachmentFileDetailVO> reportDetail3(ReportVO paramVO);

	public int reportUpdate(ReportVO reportVO);
	public int reportUpdate2(ReportVO reportVO);
	public int updatePostDelYn(int targetComuPostNo);
	public int updateReplyDelYn(int targetComuPostNo);
	public int deleteChat(int targetComuPostNo);
	public int reportUpdate3(ReportVO reportVO);

	//신고 미처리 수
	public int reportCnt();
	//신고 사유 유형별 수
	public List<Map<String, Object>> reportReasonCnt();
	public int totalReportCount(Map<String, Object> totalCountParams);
	/**
	 * 미처리 신고수 가져오기
	 * @return
	 */
	public int getReportCnt();
	
	//신고 상세 블랙리스트 등록페이지로 가지고 오기
	public ReportVO getUserReportDetail(Integer reportNo);
	
	//블랙리스트 상세페이지에 신고 목록 불러오기
	public List<ReportVO> userReports(String memId, PaginationInfoVO<ReportVO> pagingVO);
	//블랙리스트 상세페이지의 신고 수
	public int countUserReports(String memId, PaginationInfoVO<ReportVO> pagingVO);





}
