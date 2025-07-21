package kr.or.ddit.ddtown.service.admin.goods.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile; // MultipartFile 임포트

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;

public interface IAdminGoodsNoticeService {

	/**
	 * 전체 공지사항 게시글 수를 조회합니다.
	 * @param pagingVO 페이징 정보를 담고 있는 VO
	 * @return 전체 게시글 수
	 */
	public int getTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO);

	/**
	 * 모든 공지사항 목록을 조회합니다.
	 * @param pagingVO 페이징 정보를 담고 있는 VO
	 * @return 공지사항 목록
	 */
	public List<goodsNoticeVO> getAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO);

	/**
	 * 특정 공지사항의 상세 정보를 조회합니다.
	 * @param goodsNotiNo 조회할 공지사항 번호
	 * @return 공지사항 VO 객체
	 */
	public goodsNoticeVO getGoodsNotice(int goodsNotiNo);

	/**
	 * 특정 공지사항을 삭제합니다. (관련 파일 포함)
	 * @param goodsNotiNo 삭제할 공지사항 번호
	 * @return 삭제 성공 여부 (true: 성공, false: 실패)
	 */
	public boolean deleteGoodsNotice(int goodsNotiNo);

	/**
	 * 새로운 공지사항을 등록합니다. (첨부 파일 포함)
	 * @param noticeVO 등록할 공지사항 정보를 담은 VO
	 * @param uploadFile 첨부할 파일 배열
	 * @return 등록 성공 시 1, 실패 시 0
	 */
	public int createGoodsNotice(goodsNoticeVO noticeVO, MultipartFile[] uploadFile); // 파일 파라미터가 있는 버전만 남김

	/**
	 * 기존 공지사항을 수정합니다. (첨부 파일 업데이트 및 삭제 처리 포함)
	 * @param noticeVO 수정할 공지사항 정보를 담은 VO
	 * @param uploadFile 새로 첨부할 파일 배열
	 * @return 수정 성공 시 1, 실패 시 0
	 */
    public int updateGoodsNotice(goodsNoticeVO noticeVO, MultipartFile[] uploadFile); // 파일 파라미터가 있는 버전만 남김

}