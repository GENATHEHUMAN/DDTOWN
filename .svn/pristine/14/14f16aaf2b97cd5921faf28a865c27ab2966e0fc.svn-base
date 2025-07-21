/*
 * package kr.or.ddit.ddtown.controller.concert.notice;
 * 
 * import java.util.List;
 * 
 * import org.apache.commons.lang3.StringUtils; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.security.core.Authentication; import
 * org.springframework.security.core.context.SecurityContextHolder; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PathVariable; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.servlet.mvc.support.RedirectAttributes;
 * 
 * import kr.or.ddit.ServiceResult; import
 * kr.or.ddit.ddtown.service.community.notice.ICommunityNoticeService; import
 * kr.or.ddit.vo.PaginationInfoVO; import kr.or.ddit.vo.concert.ConcertNoticeVO;
 * import kr.or.ddit.vo.security.CustomUser; import lombok.extern.slf4j.Slf4j;
 * 
 * @Slf4j
 * 
 * @Controller
 * 
 * @RequestMapping("/community/notice") public class ConcertNoticeController {
 * 
 * @Autowired private ICommunityNoticeService noticeService;
 * 
 *//**
	 * 현재 로그인한 사용자 (empUsername) 가져오는 메소드
	 */
/*
 * private String getCurrentEmpUsername() { Authentication authentication =
 * SecurityContextHolder.getContext().getAuthentication(); if(authentication !=
 * null && authentication.getPrincipal() instanceof CustomUser) { CustomUser
 * customUser = (CustomUser) authentication.getPrincipal();
 * if(customUser.getEmployeeVO() != null) { return
 * customUser.getEmployeeVO().getEmpUsername(); } } return null; }
 * 
 *//**
	 * @param ConcertNoticeVO
	 * @param model
	 * @return 콘서트 공지사항 목록 페이지
	 */
/*
 * @GetMapping("/list") public String noticeList(ConcertNoticeVO noticeVO,Model
 * model) { log.info("noticeList() 실행...!");
 * 
 * PaginationInfoVO<ConcertNoticeVO> pagingVO = new PaginationInfoVO<>(); int
 * currentPage = noticeVO.getPage(); String searchType =
 * noticeVO.getSearchType(); String searchWord = noticeVO.getSearchWord();
 * 
 * if(StringUtils.isNotBlank(searchWord)) { pagingVO.setSearchType(searchType);
 * pagingVO.setSearchWord(searchWord);
 * 
 * // 검색 후 목록 갈때 검색내용 적용 model.addAttribute("searchType",
 * noticeVO.getSearchType()); model.addAttribute("searchWord",
 * noticeVO.getSearchWord()); }
 * 
 * try { // 현재 페이지 전달 후, start/endRow, start/endPage 설정
 * pagingVO.setCurrentPage(currentPage); int totalRecord =
 * noticeService.selectNoticeCount(pagingVO);
 * pagingVO.setTotalRecord(totalRecord); List<ConcertNoticeVO> noticeList =
 * noticeService.selectNoticeList(pagingVO); pagingVO.setDataList(noticeList); }
 * catch (Exception e) { e.printStackTrace(); model.addAttribute("errorMessage",
 * "콘서트 공지사항 목록을 불러오는 중 오류가 발생했습니다!!"); }
 * 
 * model.addAttribute("pagingVO", pagingVO); return "concert/notice/list"; }
 * 
 *//**
	 * @param concertNotiNo
	 * @param model
	 * @param ra
	 * @return 콘서트 공지사항 상세보기 페이지
	 */
/*
 * @GetMapping("/detail/{concertNotiNo}") public String
 * noticeDetail(@PathVariable int concertNotiNo, Model model, RedirectAttributes
 * ra) { log.info("noticeDetail() 실행...!");
 * 
 * try { ConcertNoticeVO noticeVO = noticeService.selectNotice(concertNotiNo);
 * if(noticeVO == null) { ra.addFlashAttribute("errorMessage",
 * "해당되는 콘서트 공지사항 정보 없ㄹ음"); return "redirect:/concert/notice/list"; }
 * model.addAttribute("noticeVO", noticeVO);
 * 
 * } catch (Exception e) { e.printStackTrace();
 * ra.addFlashAttribute("errorMessage", "콘서트 공지사항 정보 불러오는중 오류 발생"); return
 * "redirect:/concert/notice/list"; } return "concert/notice/detail"; }
 * 
 * 
 *//**
	 * @param model
	 * @param ra
	 * @return 콘서트 공지사항 등록 폼
	 */
/*
 * @GetMapping("/form") public String noticeRegisterForm(Model model,
 * RedirectAttributes ra) { log.info("noticeRegisterForm() 실행...!");
 * 
 * String currentEmpUsername = getCurrentEmpUsername(); if (currentEmpUsername
 * == null) { ra.addFlashAttribute("errorMessage", "로그인이 필요합니다."); return
 * "redirect:/login"; }
 * 
 * model.addAttribute("noticeVO", new ConcertNoticeVO()); return
 * "concert/notice/form"; }
 * 
 * 
 *//**
	 * @param concertVO
	 * @param ra
	 * @param model
	 * @return 콘서트 공지사항 등록 처리
	 */
/*
 * @PostMapping("/insert") public String noticeInsert(
 * 
 * @ModelAttribute ConcertNoticeVO noticeVO, RedirectAttributes ra, Model model
 * ) { log.info("noticeInsert() 실행...!"); String goPage = "";
 * 
 * // 유효성검사 if(StringUtils.isBlank(noticeVO.getConcertNotiTitle())) {
 * model.addAttribute("errorMessage", "공지사항 제목을 입력해주세요!!");
 * model.addAttribute("noticeVO", noticeVO); return "concert/notice/form"; }
 * 
 * String currentEmpUsername = getCurrentEmpUsername(); if (currentEmpUsername
 * == null) { ra.addFlashAttribute("errorMessage",
 * "로그인 정보가 유효하지 않습니다. 다시 로그인해주세요."); return "redirect:/login"; }
 * noticeVO.setEmpUsername(currentEmpUsername);
 * 
 * try { ServiceResult result = noticeService.insertNotice(noticeVO);
 * if(result.equals(ServiceResult.OK) && noticeVO.getConcertNotiNo() > 0) {
 * ra.addFlashAttribute("successMessage", "콘서트 공지사항 등록 성공!!"); goPage =
 * "redirect:/concert/notice/detail/" + noticeVO.getConcertNotiNo(); } else {
 * model.addAttribute("errorMessage", "콘서트 공지사항 등록 실패!!");
 * model.addAttribute("noticeVO", noticeVO); goPage = "concert/notice/form"; } }
 * catch (Exception e) { e.printStackTrace(); model.addAttribute("errorMessage",
 * "시스템오류, 콘서트 공지사항 등록 실패!!"); model.addAttribute("noticeVO", noticeVO); goPage
 * = "concert/notice/form"; }
 * 
 * return goPage; }
 * 
 * 
 *//**
	 * @param concertNotiNo
	 * @param model
	 * @param ra
	 * @return 콘서트 공지사항 수정 폼
	 */
/*
 * @GetMapping("/mod/{concertNotiNo}") public String noticeModForm(@PathVariable
 * int concertNotiNo, Model model, RedirectAttributes ra) {
 * log.info("noticeModForm() 실행...!");
 * 
 * String currentEmpUsername = getCurrentEmpUsername(); if (currentEmpUsername
 * == null) { ra.addFlashAttribute("errorMessage", "로그인이 필요합니다."); return
 * "redirect:/login"; }
 * 
 * try { ConcertNoticeVO noticeVO = noticeService.selectNotice(concertNotiNo);
 * if(noticeVO == null) { ra.addFlashAttribute("errorMessage",
 * "수정할 콘서트 공지사항 찾을수 없음"); return "redirect:/concert/notice/list"; }
 * 
 * if (!noticeVO.getEmpUsername().equals(currentEmpUsername)) {
 * ra.addFlashAttribute("errorMessage", "이 공지사항을 수정할 권한이 없습니다."); return
 * "redirect:/concert/notice/list"; }
 * 
 * model.addAttribute("noticeVO", noticeVO);
 * 
 * } catch (Exception e) { e.printStackTrace();
 * ra.addFlashAttribute("errorMessage", "콘서트 공지사항 불러오는중 오류발생"); return
 * "redirect:/concert/notice/list"; }
 * 
 * return "concert/notice/mod"; }
 * 
 *//**
	 * @param concertNotiNo
	 * @param concertVO
	 * @param ra
	 * @param model
	 * @return 콘서트 공지사항 수정 처리
	 */
/*
 * @PostMapping("/mod/{concertNotiNo}") public String NoticeMod(
 * 
 * @PathVariable int concertNotiNo,
 * 
 * @ModelAttribute ConcertNoticeVO noticeVO, RedirectAttributes ra, Model model
 * ) { log.info("NoticeMod() 실행...!"); String goPage = "";
 * 
 * noticeVO.setConcertNotiNo(concertNotiNo);
 * 
 * String currentEmpUsername = getCurrentEmpUsername(); if (currentEmpUsername
 * == null) { ra.addFlashAttribute("errorMessage",
 * "로그인 정보가 유효하지 않습니다. 다시 로그인해주세요."); return "redirect:/login"; }
 * 
 * try { ConcertNoticeVO originalNotice =
 * noticeService.selectNotice(concertNotiNo); if (originalNotice == null) {
 * ra.addFlashAttribute("errorMessage", "수정할 공지사항을 찾을 수 없습니다."); return
 * "redirect:/concert/notice/list"; } if
 * (!originalNotice.getEmpUsername().equals(currentEmpUsername)) {
 * ra.addFlashAttribute("errorMessage", "이 공지사항을 수정할 권한이 없습니다."); return
 * "redirect:/concert/notice/list"; } } catch (Exception e) {
 * log.error("게시물 조회 오류 (번호: {}):", concertNotiNo, e);
 * ra.addFlashAttribute("errorMessage", "게시물 정보를 확인하는 중 오류가 발생했습니다."); return
 * "redirect:/concert/notice/list"; }
 * 
 * noticeVO.setEmpUsername(currentEmpUsername);
 * 
 * if(StringUtils.isBlank(noticeVO.getConcertNotiTitle())) {
 * model.addAttribute("errorMessage", "공지사항 제목을 입력해주세요!!");
 * model.addAttribute("noticeVO", noticeVO); return "concert/notice/mod"; }
 * 
 * try { ServiceResult result = noticeService.updateNotice(noticeVO);
 * if(result.equals(ServiceResult.OK)) { ra.addFlashAttribute("successMessage",
 * "콘서트 공지사항 수정 성공!!"); goPage = "redirect:/concert/notice/detail/" +
 * concertNotiNo; } else { ra.addFlashAttribute("errorMessage",
 * "콘서트 공지사항 수정 실패!!"); model.addAttribute("noticeVO", noticeVO); goPage =
 * "concert/notice/mod"; }
 * 
 * } catch (Exception e) { e.printStackTrace();
 * ra.addFlashAttribute("errorMessage", "시스템오류, 콘서트 공지사항 수정 실패!!");
 * model.addAttribute("noticeVO", noticeVO); goPage = "concert/notice/mod"; }
 * return goPage; }
 * 
 *//**
	 * @param concertNotiNo
	 * @param ra
	 * @return 콘서트 공지사항 삭제 처리 -> 콘서트 공지사항 목록 페이지
	 *//*
		 * @PostMapping("/delete/{concertNotiNo}") public String
		 * NoticeDelete(@PathVariable int concertNotiNo, RedirectAttributes ra) {
		 * log.info("NoticeDelete() 실행...!");
		 * 
		 * String currentEmpUsername = getCurrentEmpUsername(); if (currentEmpUsername
		 * == null) { ra.addFlashAttribute("errorMessage", "로그인이 필요합니다."); return
		 * "redirect:/login"; }
		 * 
		 * try { ConcertNoticeVO noticeToDelete =
		 * noticeService.selectNotice(concertNotiNo); if (noticeToDelete == null) {
		 * ra.addFlashAttribute("errorMessage", "삭제할 공지사항을 찾을 수 없습니다."); return
		 * "redirect:/concert/notice/list"; }
		 * 
		 * } catch (Exception e) { log.error("게시물 조회 오류 (번호: {}):", concertNotiNo, e);
		 * ra.addFlashAttribute("errorMessage", "게시물 정보를 확인하는 중 오류가 발생했습니다."); return
		 * "redirect:/concert/notice/list"; }
		 * 
		 * try { ServiceResult result = noticeService.deleteNotice(concertNotiNo);
		 * if(result.equals(ServiceResult.OK)) { ra.addFlashAttribute("successMessage",
		 * "콘서트 공지사항 삭제 성공!!"); } else { ra.addFlashAttribute("errorMessage",
		 * "콘서트 공지사항 삭제 실패!!"); }
		 * 
		 * } catch (Exception e) { e.printStackTrace();
		 * ra.addFlashAttribute("errorMessage", "시스템오류, 콘서트 공지사항 삭제 실패!!"); } return
		 * "redirect:/concert/notice/list"; } }
		 */