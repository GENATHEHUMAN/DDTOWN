package kr.or.ddit.ddtown.service.inquiry;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.inquiry.InquiryCodeVO;
import kr.or.ddit.vo.inquiry.InquiryVO;

public interface InquiryService {

	public Map<Object, Object> getList(PaginationInfoVO<InquiryVO> pagingVO);

	public List<InquiryCodeVO> getCodeList();

	public ServiceResult insertData(InquiryVO inquiryVO);

	public InquiryVO getDetail(int inqNo);

	public ServiceResult updateData(InquiryVO vo);

	public ServiceResult deleteData(int inqNo);

}
