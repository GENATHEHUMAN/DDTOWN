package kr.or.ddit.ddtown.service.admin.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.admin.notice.AdminNoticeMapper;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {
	
	@Autowired
	private AdminNoticeMapper mapper;

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

}
