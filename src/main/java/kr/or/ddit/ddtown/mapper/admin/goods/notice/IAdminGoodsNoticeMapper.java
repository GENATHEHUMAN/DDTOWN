package kr.or.ddit.ddtown.mapper.admin.goods.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;

@Mapper
public interface IAdminGoodsNoticeMapper {

	public int selectTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO);

	public List<goodsNoticeVO> selectAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO);

	public int incrementGoodsNoticeHit(int goodsNotiNo);

	public goodsNoticeVO selectGoodsNotice(int goodsNotiNo);

	public int deleteGoodsNotice(int goodsNotiNo);

	public int insertGoodsNotice(goodsNoticeVO noticeVO);

	public int updateGoodsNotice(goodsNoticeVO noticeVO);

}
