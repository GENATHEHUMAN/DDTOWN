package kr.or.ddit.ddtown.mapper.corporate;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

@Mapper
public interface NoticeMapper {

	public List<NoticeVO> getList();

	public NoticeVO getDetail(int id);

	public int selectTotalRecord(PaginationInfoVO<NoticeVO> pagingVO);

	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

}
