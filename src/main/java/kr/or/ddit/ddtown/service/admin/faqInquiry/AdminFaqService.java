package kr.or.ddit.ddtown.service.admin.faqInquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.admin.faqInquiry.IAdminFaqMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.faq.FaqCodeVO;
import kr.or.ddit.vo.faq.FaqVO;

@Service
public class AdminFaqService implements IAdminFaqService {

	@Autowired
	private IAdminFaqMapper faqMapper;

	@Override
	public Map<Object, Object> faqAdminMain(PaginationInfoVO<FaqVO> pagingVO, String searchCode) {
		
		Map<Object, Object> map = new HashMap<>();
		
		List<FaqVO> faqVO = faqMapper.faqAdminMain(pagingVO, searchCode);
		
		if(faqVO.size() > 0) {
			pagingVO.setTotalRecord(faqVO.get(0).getTotalRecord());
		}
		
		List<FaqCodeVO> codeList = faqMapper.faqCodeList();
		
		List<CommonCodeDetailVO> cntList = faqMapper.cntList();
		
		int allFaqCnt = faqMapper.allFaqCnt();
		
		map.put("faqVO", faqVO);
		map.put("codeList", codeList);
		map.put("pagingVO", pagingVO);
		map.put("allFaqCnt", allFaqCnt);
		map.put("cntList", cntList);
		
		return map;
	}

	@Override
	public FaqVO getFaqDetail(int faqNo) {
		
		
		FaqVO faqVO = faqMapper.getFaqDetail(faqNo);
		
		return faqVO;
	}

	@Override
	public ServiceResult updateData(FaqVO faqVO) {
		
		ServiceResult result = null;
		
		int status = faqMapper.updateData(faqVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult faqInsert(FaqVO faqVO) {
		
		ServiceResult result = null;
		
		int status = faqMapper.faqInsert(faqVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteData(int faqNo) {
		
		ServiceResult result = null;
		
		int status = faqMapper.deleteData(faqNo);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	
}
