package kr.or.ddit.ddtown.service.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.corporate.NoticeMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsNoitceMapper;
import kr.or.ddit.vo.goods.goodsNoticeVO;

@Service
public class GoodsNoticeServiceImpl implements IGoodsNoticeService {
	
	
	@Autowired
	private IGoodsNoitceMapper mapper;
	
	@Override
	public List<goodsNoticeVO> noticeList() {
		
		return mapper.noticeList();
	}

	@Override
	public List<goodsNoticeVO> search(goodsNoticeVO notice) {

		return mapper.search(notice);
	}

	@Override
	public goodsNoticeVO getMainNotice() {
		
		goodsNoticeVO mainNotice = mapper.selectMainNotice();
		
		return mainNotice;
	}


	
}
