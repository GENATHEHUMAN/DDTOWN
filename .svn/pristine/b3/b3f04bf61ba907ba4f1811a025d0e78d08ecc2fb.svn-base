package kr.or.ddit.ddtown.service.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.inquiry.IAdminInquiryMapper;
import kr.or.ddit.vo.inquiry.InquiryVO;

@Service
public class AdminInquiryService implements IAdminInquiryService{

	@Autowired
	private IAdminInquiryMapper adminInquiryMapper;

	@Override
	public List<InquiryVO> getList() {
		
		List<InquiryVO> list = adminInquiryMapper.getList();
		
		return list;
	}
	
}
