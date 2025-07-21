package kr.or.ddit.ddtown.service.faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.faq.IFaqMapper;
import kr.or.ddit.vo.faq.FaqCodeVO;
import kr.or.ddit.vo.faq.FaqVO;

@Service
public class FaqServiceImpl implements IFaqService {

	@Autowired
	private IFaqMapper faqMapper;

	@Override
	public Map<Object, Object> getList(String decodedValue) {
		
		boolean flag = false;
		
		Map<Object, Object> map = new HashMap<>();
		
		List<FaqVO> list = faqMapper.getList(decodedValue);
		
		map.put("list", list);
		
		for(FaqVO fv : list) {
			if(!flag) {
				int faqNo = fv.getFaqNo();
				List<FaqCodeVO> codeList = faqMapper.getCodeList(faqNo);
				if(codeList != null) {
					map.put("codeList", codeList);
					flag = true;
				}
			}else {
				continue;
			}
		}
		
		return map;
	}
	
}
