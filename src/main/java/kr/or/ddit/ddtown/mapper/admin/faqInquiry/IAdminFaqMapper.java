package kr.or.ddit.ddtown.mapper.admin.faqInquiry;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.faq.FaqCodeVO;
import kr.or.ddit.vo.faq.FaqVO;

@Mapper
public interface IAdminFaqMapper {

	public List<FaqVO> faqAdminMain(@Param("pagingVO") PaginationInfoVO<FaqVO> pagingVO,@Param("searchCode") String searchCode);

	public FaqVO getFaqDetail(int faqNo);

	public List<FaqCodeVO> faqCodeList();

	public int updateData(FaqVO faqVO);

	public int faqInsert(FaqVO faqVO);

	public int deleteData(int faqNo);

	// 전체 FAQ 수
	public int allFaqCnt();

	// 카테고리 별 수
	public List<CommonCodeDetailVO> cntList();

}
