package kr.or.ddit.ddtown.service.coporate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.corporate.NoticeMapper;
import kr.or.ddit.vo.corporate.notice.NoticeSearchVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeMapper mapper;

	@Override
	public List<NoticeVO> getList() {
		
		List<NoticeVO> list = null;
		
		list = mapper.getList();
		
		return list;
	}

	@Override
	public NoticeVO getDetail(int id) {
		return mapper.getDetail(id);
	}

	@Override
	public List<NoticeVO> searchKeyword(NoticeSearchVO searchVO) {
		return mapper.searchKeyword(searchVO);
	}

}
