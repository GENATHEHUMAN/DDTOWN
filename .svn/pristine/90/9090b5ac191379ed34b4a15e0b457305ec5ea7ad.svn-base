package kr.or.ddit.ddtown.mapper.community;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.artist.AlbumVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.artist.ArtistVO;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.community.CommunityLikeVO;
import kr.or.ddit.vo.community.CommunityPostVO;
import kr.or.ddit.vo.community.CommunityProfileVO;
import kr.or.ddit.vo.community.CommunityReplyVO;
import kr.or.ddit.vo.community.CommunityReportVO;
import kr.or.ddit.vo.community.CommunityVO;
import kr.or.ddit.vo.community.WorldcupVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.file.AttachmentFileGroupVO;
import kr.or.ddit.vo.goods.goodsVO;
import kr.or.ddit.vo.live.LiveVO;
import kr.or.ddit.vo.report.ReportVO;

@Mapper
public interface ICommunityMainPageMapper {

	public List<ArtistGroupVO> getGroupLists();

	public ArtistGroupVO getGroupInfo(int artGroupNo);

	public List<AlbumVO> getGroupAlbum(int artGroupNo);

	public ArtistGroupVO getCommunityInfo(int artGroupNo);

	public List<CommunityPostVO> getPostList(CommunityVO communityVO);

	public List<CommunityPostVO> getFanPostList(CommunityVO communityVO);

	public int getArtistPostTotal(CommunityVO communityVO);

	public int getFanPostTotal(CommunityVO communityVO);

	public CommunityProfileVO currentUserComufollowing(CommunityPostVO postVO);

	public int postInsert(CommunityPostVO postVO);

	public CommunityProfileVO getComuProfile(Map<String, Object> currentUser);

	public CommunityPostVO getPost(CommunityPostVO communityVO);

	/**
	 * 프로필VO 검색 후 해당 유저 작성글 가져오기
	 * @param currentUserComu
	 * @return
	 */
	public List<CommunityPostVO> selectPostList(CommunityProfileVO currentUserComu);

	/**
	 * 프로필 VO 검색 후 해당 유저 댓글 가져오기
	 * @param currentUserComu
	 * @return
	 */
	public List<CommunityReplyVO> selectReplyList(CommunityProfileVO currentUserComu);

	/**
	 * comuProfileNo, artGroupNo로 프로필VO 찾은 후 해당 프로필이 작성한 글 목록 및 댓글 목록 가져오기
	 * @param profileVO
	 * @param myComuProfileNo
	 * @return
	 */
	public CommunityProfileVO selectProfile(CommunityProfileVO profileVO);

	public int fileReUpload(AttachmentFileDetailVO files);

	public int updatePost(CommunityPostVO postVO);

	public int postDeleteUpdate(CommunityPostVO postVO);

	public int replyInsert(CommunityReplyVO replyVO);

	/**
	 * 포스트 번호로 해당 포스트 및 댓글 정보 가져오기
	 * @param cPostVO
	 * @return
	 */
	public CommunityPostVO selectPostOne(CommunityPostVO cPostVO);

	public int replyUpdate(CommunityReplyVO replyVO);

	public int replyDelete(int replyNo);

	public int likeInsert(CommunityLikeVO likeVO);

	public int likeDelete(CommunityLikeVO likeVO);

	public CommunityLikeVO getLikeInfo(CommunityLikeVO likeVO);

	public List<CommonCodeDetailVO> getCodeDetail(String reasonCodeGroupNo);

	public int report(CommunityReportVO comuReportVO);

	public CommunityReportVO getReprot(CommunityReportVO comuReportVO);

	public int reportDetailInsert(ReportVO reportVo);

	public Integer getFileGroupNo();

	public void insertFileGroup(AttachmentFileGroupVO groupVO);

	/**
	 * 유저네임과 그룹번호로 번호가져오기
	 * @param myProfileVO
	 * @return
	 */
	public int getMyComuProfileNo(CommunityProfileVO myProfileVO);

	public int getReplyCount(CommunityReplyVO replyVO);

	/**
	 * 업데이트할 포스트 정보 가져오기
	 * @param comuPostNo
	 * @return
	 */
	public CommunityPostVO getUpdatePost(int comuPostNo);

	/**
	 * 특정 아티스트 그룹의 현재 라이브 방송 정보를 가져옵니다.
	 * @param artGroupNo 조회할 아티스트 그룹 번호
	 * @return 방송 중이면 LiveVO 객체, 방송 중이 아니면 null
	 */
	public LiveVO getLiveBroadcastInfo(int artGroupNo);

	/**
	 * 좋아요 누른 사람의 프로필정보 조회
	 * @param comuProfileNo
	 * @return comuProfile
	 */
	public CommunityProfileVO getProfileByComuProfileNo(int comuProfileNo);

	/**
	 * 게시글 작성자의 memUsername 조회용
	 * @param comuProfileNo
	 * @return memUsername
	 */
	public String getMemberUsernameByComuProfileNo(int comuProfileNo);

	public String comuMemberShipYn(Map<String, Object> currentUser);

	// 메인페이지 해당 아티스트 멤버십 굿즈번호 가져오기
	public Integer getMembershipGoodsNo(int artGroupNo);

	/**
	 * memUsername과 artGroupNo로 해당 커뮤니티 멤버쉽가입여부 확인
	 * @param myProfileVO
	 * @return
	 */
	public int getMyMemberShipYn(CommunityProfileVO myProfileVO);

	public List<LiveVO> getLiveHistory(int artGroupNo);

	// 상품 이미지 가져오기
	public List<goodsVO> thumbnailInfo(int artGroupNo);

	// 아티스트 제외, 커뮤 탈퇴 제외 활성화된 팬만 가져오는 메서드
	public int getFansWithoutDel(int artGroupNo);

	// 전체 아티스트 가져오기
	public List<ArtistVO> artistList();

	// 월드컵 승리
	public int worldcupWinner(WorldcupVO worldcupVO);

	// 역대 순위 가져오기
	public List<WorldcupVO> winnerList();
}
