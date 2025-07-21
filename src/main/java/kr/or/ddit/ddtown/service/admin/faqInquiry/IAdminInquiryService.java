package kr.or.ddit.ddtown.service.admin.faqInquiry;

import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.inquiry.InquiryVO;


public interface IAdminInquiryService {

	public Map<Object, Object> getList(PaginationInfoVO<InquiryVO> pagingVO, String searchCode);

	public InquiryVO getData(int inqNo);

	public ServiceResult updateAnswer(InquiryVO inqVO);

	/**
	 * 미처리 문의 건수 가져오기
	 * @return
	 */
	public int getUnansweredInquiryCnt();

}
