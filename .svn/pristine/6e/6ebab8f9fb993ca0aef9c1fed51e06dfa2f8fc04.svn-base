package kr.or.ddit.ddtown.service.audition;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.audition.AuditionUserVO;
import kr.or.ddit.vo.corporate.audition.AuditionVO;

public interface AuditionService {
	//목록페이지
	public List<AuditionVO> auditionList(PaginationInfoVO<AuditionVO> pagingVO);
	//오디션 목록 수
	public int selectAuditionCount(PaginationInfoVO<AuditionVO> pagingVO);
	//상세보기
	public AuditionVO detailAudition(int audiNo);
	//지원하기
	public ServiceResult signup(AuditionUserVO auditionUserVO) throws Exception;
	
	//이메일 중복
//	public ServiceResult emailCheck(AuditionUserVO userVO);
}
