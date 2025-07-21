package kr.or.ddit.ddtown.mapper.faq;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.faq.FaqCodeVO;
import kr.or.ddit.vo.faq.FaqVO;

@Mapper
public interface IFaqMapper {

	public List<FaqVO> getList(PaginationInfoVO<FaqVO> pagingVO);

	public List<FaqCodeVO> getCodeList();

}
