package kr.or.ddit.ddtown.controller.community;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.community.notice.ICommunityNoticeService;
import kr.or.ddit.ddtown.service.emp.artist.IArtistGroupService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.community.CommunityNoticeVO;
import kr.or.ddit.vo.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/community/notice")
public class EmpCommunityNoticeController {
	
	@Autowired
	private ICommunityNoticeService noticeService;
	
	@Autowired
	private IArtistGroupService artistGroupService;
	
	/*
	 * @Autowired private IAlertService alertService;
	 */
	
	/**
	 * 현재 로그인한 사용자 (empUsername) 가져오는 메소드
	 */
	private String getCurrentEmpUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication != null && authentication.getPrincipal() instanceof CustomUser) {
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
			if(customUser.getEmployeeVO() != null) {
				return customUser.getEmployeeVO().getEmpUsername();
			}
		}
		return null;
	}

	/**
	 * @param CommunityNoticeVO
	 * @param model
	 * @return 커뮤니티 공지사항 목록 페이지
	 */
	@GetMapping("/list")
	public String noticeList(
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO,
            Model model) {
		log.info("noticeList() 실행...!");
		
		String empUsername = getCurrentEmpUsername();
		model.addAttribute("loggedInEmpUsername", empUsername);		// 현재 로그인한 직원 정보 전달

		// artGroupNo 조회
		Integer myArtGroupNo = null;
		if (empUsername != null) {
			myArtGroupNo = artistGroupService.getArtGroupNoByEmpUsername(empUsername);
		}

		if (pagingVO.getArtGroupNo() == null || pagingVO.getArtGroupNo() <= 0) {
			pagingVO.setArtGroupNo(myArtGroupNo);
		}

		log.info("pagingVO.getArtGroupNo() : {}", pagingVO.getArtGroupNo());
		log.info("myArtGroupNo : {}", myArtGroupNo);
		
		List<ArtistGroupVO> artistGroups = artistGroupService.selectAllArtistGroups();
		model.addAttribute("artistGroups", artistGroups);
		
		// currentPage가 넘어오지 않았을 경우 기본값 1을 설정
        if (pagingVO.getCurrentPage() == 0) {
            pagingVO.setCurrentPage(1);
        }
		
		try {
			// 현재 페이지 전달 후, start/endRow, start/endPage 설정
			int totalRecord = noticeService.selectNoticeCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<CommunityNoticeVO> noticeList = noticeService.selectNoticeList(pagingVO);
			pagingVO.setDataList(noticeList);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "커뮤니티 공지사항 목록을 불러오는 중 오류가 발생했습니다!!");
		}
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("selectedArtGroupNo", pagingVO.getArtGroupNo());		// 현재 선택된 아티스트 그룹 전달
		return "emp/notice/noticeList";
	}
	
	/**
	 * @param comuNotiNo
	 * @param model
	 * @param ra
	 * @return 커뮤니티 공지사항 상세보기 페이지
	 */
	@GetMapping("/detail/{comuNotiNo}")
	public String noticeDetail(
			@PathVariable int comuNotiNo, Model model, RedirectAttributes ra,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO) {
		log.info("noticeDetail() 실행...!");
		
		model.addAttribute("loggedInEmpUsername", getCurrentEmpUsername());		// 현재 로그인한 직원 정보 전달
		
		try {
			CommunityNoticeVO noticeVO = noticeService.selectNotice(comuNotiNo);		// 공지번호로 조회 후 객체생성
			if(noticeVO == null) {
				ra.addFlashAttribute("errorMessage", "해당되는 커뮤니티 공지사항 정보 없음");
				return "redirect:/emp/community/notice/list";
			}
			model.addAttribute("noticeVO", noticeVO);

		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "커뮤니티 공지사항 정보 불러오는중 오류 발생");
			addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
			return "redirect:/community/notice/list";
		}
		return "emp/notice/noticeDetail";
	}
	
	
	

	/**
	 * @param model
	 * @param ra
	 * @return 커뮤니티 공지사항 등록 폼
	 */
	@GetMapping("/form")
	public String noticeRegisterForm(Model model,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO) {
		log.info("noticeRegisterForm() 실행...!");
		
		model.addAttribute("loggedInEmpUsername", getCurrentEmpUsername());		// 현재 로그인한 직원 정보 전달
		
		List<ArtistGroupVO> artistGroups = artistGroupService.selectAllArtistGroups();
		model.addAttribute("artistGroups", artistGroups);
		
		CommunityNoticeVO noticeVO = new CommunityNoticeVO();
		
		model.addAttribute("noticeVO", noticeVO);
		return "emp/notice/noticeRegister";
	}
	
	
	/**
	 * @param CommunityNoticeVO
	 * @param ra
	 * @param model
	 * @return 커뮤니티 공지사항 등록 처리
	 */
	@PostMapping("/insert")
	public String noticeInsert(
			@ModelAttribute CommunityNoticeVO noticeVO,
			Model model,
			RedirectAttributes ra,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO
			) {
		log.info("noticeInsert() 실행...!");
		String goPage = "";
		
		String currentEmpUsername = getCurrentEmpUsername();
		log.info("currentEmpUsername : {}", currentEmpUsername);
		
		// empUsername이 null인 경우 처리
	    if (currentEmpUsername == null) {
	        model.addAttribute("errorMessage", "로그인 정보가 유효하지 않습니다. 다시 로그인해주세요.");
	        model.addAttribute("noticeVO", noticeVO);
	        return "emp/notice/noticeRegister"; // 등록 폼으로 다시 이동
	    }
		
		noticeVO.setEmpUsername(currentEmpUsername);
		
		if (noticeVO.getArtGroupNo() <= 0) {
            model.addAttribute("errorMessage", "아티스트 그룹을 선택해주세요!!");
            model.addAttribute("noticeVO", noticeVO);
            
            List<ArtistGroupVO> artistGroups = artistGroupService.selectAllArtistGroups();
            model.addAttribute("artistGroups", artistGroups);
            return "emp/notice/noticeRegister";
        }
		// 유효성검사 (제목)
		if(StringUtils.isBlank(noticeVO.getComuNotiTitle())) {
			model.addAttribute("errorMessage", "공지사항 제목을 입력해주세요!!");
			model.addAttribute("noticeVO", noticeVO);
			return "emp/notice/noticeRegister";
		}
		
		
		
		try {
			ServiceResult result = noticeService.insertNotice(noticeVO);
			if(result.equals(ServiceResult.OK) && noticeVO.getComuNotiNo() > 0) {
				ra.addFlashAttribute("successMessage", "커뮤니티 공지사항 등록 성공!!");
				addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
			    goPage = "redirect:/emp/community/notice/detail/" + noticeVO.getComuNotiNo();
			} else {
				model.addAttribute("errorMessage", "커뮤니티 공지사항 등록 실패!!");
				model.addAttribute("noticeVO", noticeVO);
				goPage = "emp/notice/noticeRegister";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "시스템오류, 커뮤니티 공지사항 등록 실패!!");
			model.addAttribute("noticeVO", noticeVO);
			goPage = "emp/notice/noticeRegister";
		}
		
		return goPage;
	}
	
	
	/**
	 * @param comuNotiNo
	 * @param model
	 * @param ra
	 * @return 커뮤니티 공지사항 수정 폼
	 */
	@GetMapping("/mod/{comuNotiNo}")
	public String noticeModForm(
			@PathVariable int comuNotiNo, Model model, RedirectAttributes ra,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO) {
		log.info("noticeModForm() 실행...!");
		
		model.addAttribute("loggedInEmpUsername", getCurrentEmpUsername());		// 현재 로그인한 직원 정보 전달
		
		try {
			CommunityNoticeVO noticeVO = noticeService.selectNotice(comuNotiNo);
			if(noticeVO == null) {
				ra.addFlashAttribute("errorMessage", "수정할 커뮤니티 공지사항 찾을수 없음");
				return "redirect:/emp/community/notice/list";
			}
			
			List<ArtistGroupVO> artistGroups = artistGroupService.selectAllArtistGroups();
			model.addAttribute("artistGroups", artistGroups);
			
			model.addAttribute("noticeVO", noticeVO);
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "커뮤니티 공지사항 불러오는중 오류발생");
			return "redirect:/emp/community/notice/list";
		}
		
		return "emp/notice/noticeUpdate";
	}
	
	/**
	 * @param comuNotiNo
	 * @param CommunityNoticeVO
	 * @param ra
	 * @param model
	 * @return 커뮤니티 공지사항 수정 처리
	 */
	@PostMapping("/mod/{comuNotiNo}")
	public String noticeMod(
			@PathVariable int comuNotiNo,
			@ModelAttribute CommunityNoticeVO noticeVO,
			RedirectAttributes ra,
			Model model,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO
			) {
//		log.info("NoticeMod() 실행...!");
		log.info("NoticeMod 메서드 진입! comuNotiNo: {}, noticeVO: {}", comuNotiNo, noticeVO);
		String goPage = "";
		
		noticeVO.setComuNotiNo(comuNotiNo);
		
		String currentEmpUsername = getCurrentEmpUsername();
        if (currentEmpUsername == null) {
            ra.addFlashAttribute("errorMessage", "로그인 정보가 유효하지 않습니다. 다시 로그인해주세요.");
            return "redirect:/login"; 
        }

        try {
        	CommunityNoticeVO originalNotice = noticeService.selectNotice(comuNotiNo);		// 게시물 확인
            if (originalNotice == null) {
                ra.addFlashAttribute("errorMessage", "수정할 공지사항을 찾을 수 없습니다.");
                return "redirect:/emp/community/notice/list";
            }
            
            // 작성자 본인 또는 관리자인 경우에만 수정 가능
            if (!originalNotice.getEmpUsername().equals(currentEmpUsername) &&
                !SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"))) {
                ra.addFlashAttribute("errorMessage", "이 공지사항을 수정할 권한이 없습니다.");
                addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
                return "redirect:/emp/community/notice/list";
            }
        } catch (Exception e) { 
             log.error("게시물 조회 오류 (번호: {}):", comuNotiNo, e);
             ra.addFlashAttribute("errorMessage", "게시물 정보를 확인하는 중 오류가 발생했습니다.");
             return "redirect:/emp/community/notice/list";
        }
        
        noticeVO.setEmpUsername(currentEmpUsername);
        
		// 유효성검사 (제목)
		if(StringUtils.isBlank(noticeVO.getComuNotiTitle())) {
			model.addAttribute("errorMessage", "공지사항 제목을 입력해주세요!!");
			model.addAttribute("noticeVO", noticeVO);
			return "emp/notice/noticeUpdate";
		}
		
		if (noticeVO.getArtGroupNo() <= 0) {
            model.addAttribute("errorMessage", "아티스트 그룹을 선택해주세요!!");
            model.addAttribute("noticeVO", noticeVO);
            
            List<ArtistGroupVO> artistGroups = artistGroupService.selectAllArtistGroups();
            model.addAttribute("artistGroups", artistGroups);
            return "emp/notice/noticeUpdate";
        }
		
		try {
			ServiceResult result = noticeService.updateNotice(noticeVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("successMessage", "커뮤니티 공지사항 수정 성공!!");
				addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
				goPage = "redirect:/emp/community/notice/detail/" + comuNotiNo;
			} else {
				ra.addFlashAttribute("errorMessage", "커뮤니티 공지사항 수정 실패!!");
				model.addAttribute("noticeVO", noticeVO);
				goPage = "emp/notice/noticeUpdate";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("errorMessage", "시스템오류, 커뮤니티 공지사항 수정 실패!!");
			model.addAttribute("noticeVO", noticeVO);
			goPage = "emp/notice/noticeUpdate";
		}
		return goPage;
	}
	
	/**
	 * @param comuNotiNo
	 * @param ra
	 * @return 커뮤니티 공지사항 삭제 처리 -> 커뮤니티 공지사항 목록 페이지
	 */
	@PostMapping("/delete/{comuNotiNo}")
	public String NoticeDelete(
			@PathVariable int comuNotiNo, RedirectAttributes ra,
			@ModelAttribute("pagingVO") PaginationInfoVO<CommunityNoticeVO> pagingVO) {
		log.info("NoticeDelete() 실행...!");
		
		String currentEmpUsername = getCurrentEmpUsername();
        if (currentEmpUsername == null) {
            ra.addFlashAttribute("errorMessage", "로그인 정보가 유효하지 않습니다.");
            return "redirect:/login";
        }
        
        try {
        	CommunityNoticeVO noticeToDelete = noticeService.selectNotice(comuNotiNo);
            if (noticeToDelete == null) {
                ra.addFlashAttribute("errorMessage", "삭제할 공지사항을 찾을 수 없습니다.");
                addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
                return "redirect:/emp/community/notice/list";
            }
            
            boolean isAuthor = false;
            if(currentEmpUsername != null && noticeToDelete.getEmpUsername() != null) {
                isAuthor = noticeToDelete.getEmpUsername().equals(currentEmpUsername);
            }
            
            // 작성자 본인 또는 관리자인 경우에만 삭제 가능
            if(!isAuthor && !SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream().anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"))) {
                ra.addFlashAttribute("errorMessage", "이 공지사항을 삭제할 권한이 없습니다.");
                addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
                return "redirect:/emp/community/notice/list";
            }
            
            ServiceResult result = noticeService.deleteNotice(comuNotiNo);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("successMessage", "커뮤니티 공지사항 삭제 성공!!");
			} else {
				ra.addFlashAttribute("errorMessage", "커뮤니티 공지사항 삭제 실패!!");
			}
			
        } catch (Exception e) {
             log.error("게시물 조회 오류 (번호: {}):", comuNotiNo, e);
             ra.addFlashAttribute("errorMessage", "시스템 오류로 커뮤니티 공지사항 삭제 실패..");
        }
		addSearchParamsToRedirectAttributes(ra, pagingVO.getSearchType(), pagingVO.getSearchWord(), pagingVO.getCurrentPage(), pagingVO.getArtGroupNo());
		return "redirect:/emp/community/notice/list";
	}
	
	private void addSearchParamsToRedirectAttributes(RedirectAttributes ra, String searchType, String searchWord,
			int currentPage, Integer artGroupNo) {
		if (StringUtils.isNotBlank(searchType)) {
            ra.addAttribute("searchType", searchType);
        }
        if (StringUtils.isNotBlank(searchWord)) {
            ra.addAttribute("searchWord", searchWord);
        }
        if (currentPage > 1) { // 1페이지는 기본값이므로 굳이 안넘겨도 됨
            ra.addAttribute("currentPage", currentPage);
        }
        if(artGroupNo != null) {
        	ra.addFlashAttribute("artGroupNo", artGroupNo);
        }
	}
}
