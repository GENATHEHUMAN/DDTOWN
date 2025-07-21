package kr.or.ddit.ddtown.mapper.inquiry;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.inquiry.InquiryCodeVO;
import kr.or.ddit.vo.inquiry.InquiryVO;
import kr.or.ddit.vo.user.MemberVO;

@Mapper
public interface InquiryMapper {

	public List<InquiryVO> getList(PaginationInfoVO<InquiryVO> pagingVO);

	public List<InquiryCodeVO> getCodeList();

	public List<InquiryCodeVO> getStatCode();

	public int insertData(InquiryVO inquiryVO);

	public InquiryVO getDetail(int inqNo);

	public InquiryCodeVO getTypeCode(String typeCode);

	public int updateData(InquiryVO vo);

	public int deleteData(int inqNo);

	public int inqTotal(PaginationInfoVO<InquiryVO> pagingVO);

	public MemberVO getMember(String memUsername);

}
