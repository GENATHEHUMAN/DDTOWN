package kr.or.ddit.ddtown.service.faq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.faq.IFaqMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.faq.FaqCodeVO;
import kr.or.ddit.vo.faq.FaqVO;

@Service
public class FaqServiceImpl implements IFaqService {

	@Autowired
	private IFaqMapper faqMapper;

	@Override
	public Map<Object, Object> getList(PaginationInfoVO<FaqVO> pagingVO) {
		
		boolean flag = false;
		
		Map<Object, Object> map = new HashMap<>();
		
		List<FaqVO> list = faqMapper.getList(pagingVO);
		
		if(list.size() > 0) {
			pagingVO.setTotalRecord(list.get(0).getTotalRecord());
		}
		
		List<FaqCodeVO> codeList = faqMapper.getCodeList();
		
		map.put("list", list);
		map.put("pagingVO", pagingVO);
		map.put("codeList", codeList);
		
		return map;
	}
	
}
