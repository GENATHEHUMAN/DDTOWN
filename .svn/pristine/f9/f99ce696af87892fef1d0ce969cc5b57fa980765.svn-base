package kr.or.ddit.ddtown.service.emp.postManagement;

import java.util.List;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;
import kr.or.ddit.vo.community.CommunityPostVO;
import kr.or.ddit.vo.community.CommunityReplyVO;

public interface IPostManagementService {

	public List<CommunityPostVO> getPost(PaginationInfoVO<CommunityPostVO> pagingVO);

	public int totalRecord(String empUsername);

	public List<ArtistVO> empArtistList(String empUsername);

	public CommunityPostVO selectPost(int comuPostNo);

	public List<CommunityReplyVO> postReplyList(PaginationInfoVO<CommunityReplyVO> pagingVO);

	public int replyTotalRecord(PaginationInfoVO<CommunityReplyVO> pagingVO);


}
