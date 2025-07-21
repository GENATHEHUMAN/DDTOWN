package kr.or.ddit.ddtown.mapper.corporate;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.corporate.notice.NoticeSearchVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;

@Mapper
public interface NoticeMapper {

	public List<NoticeVO> getList();

	public NoticeVO getDetail(int id);

	public List<NoticeVO> searchKeyword(NoticeSearchVO searchVO);

}
