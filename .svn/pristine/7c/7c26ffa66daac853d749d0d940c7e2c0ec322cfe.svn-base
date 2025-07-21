package kr.or.ddit.ddtown.service.coporate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.corporate.NoticeMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

@Service
public class CoNoticeServiceImpl implements ICoNoticeService {
	
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
	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectTotalRecord(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectNoticeList(pagingVO);
	}

}
