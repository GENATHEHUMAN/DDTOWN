package kr.or.ddit.ddtown.service.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import kr.or.ddit.vo.goods.goodsVO;

@Service
public class GoodsServiceImpl implements IGoodsService {
	
	@Autowired
	private IGoodsMapper mapper;
	
	@Override
	public List<goodsVO> goodsList() {	
		return mapper.goodsList();
	}
}
