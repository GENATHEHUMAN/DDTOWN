package kr.or.ddit.ddtown.service.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.inquiry.InquiryMapper;
import kr.or.ddit.vo.inquiry.InquiryCodeVO;
import kr.or.ddit.vo.inquiry.InquiryVO;
import kr.or.ddit.vo.user.MemberVO;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	private InquiryMapper inquiryMapper;
	
	@Override
	public List<InquiryVO> getList(MemberVO memberVO) {
		
		List<InquiryVO> list = null;
		
		list = inquiryMapper.getList(memberVO.getUsername());
		
		for(InquiryVO vo : list) {
			String typeCode = vo.getInqTypeCode();
			String statCode = vo.getInqStatCode();
			vo.setTypeDetailCode(inquiryMapper.getTypeCode(typeCode));
			vo.setStatDetailCode(inquiryMapper.getTypeCode(statCode));
		}
		
		return list;
	}

	@Override
	public List<InquiryCodeVO> getCodeList() {
		
		List<InquiryCodeVO> list = null;
		
		list = inquiryMapper.getCodeList();
		
		return list;
	}

	@Override
	public ServiceResult insertData(InquiryVO inquiryVO) {
		ServiceResult result = null;
		
		int status = 0;
		
		if(inquiryVO.getInqStatCode() == null || StringUtils.isBlank(inquiryVO.getInqStatCode())) {
			List<InquiryCodeVO> statCode = inquiryMapper.getStatCode();
			String inqStatCode = null;
			for(InquiryCodeVO code : statCode) {
				if(code.getCommCodeDetNo().equals("ISC001")) {
					inqStatCode = code.getCommCodeDetNo();
				}
			}
			
			inquiryVO.setInqStatCode(inqStatCode);
			
			status = inquiryMapper.insertData(inquiryVO);
			
		}
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public InquiryVO getDetail(int inqNo) {
		
		InquiryVO inq = inquiryMapper.getDetail(inqNo);
		
		String typeCode = inq.getInqTypeCode();
		String statCode = inq.getInqStatCode();
		inq.setTypeDetailCode(inquiryMapper.getTypeCode(typeCode));
		inq.setStatDetailCode(inquiryMapper.getTypeCode(statCode));
		
		return inq;
	}

	@Override
	public ServiceResult updateData(InquiryVO vo) {
		
		ServiceResult  result = null;
		
		int status = inquiryMapper.updateData(vo);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteData(int inqNo) {
		ServiceResult result = null;
		
		int status = inquiryMapper.deleteData(inqNo);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}
