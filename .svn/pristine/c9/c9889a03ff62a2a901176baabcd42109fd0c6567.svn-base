package kr.or.ddit.ddtown.controller.corporate.notice;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ddtown.service.coporate.ICoNoticeService;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.corporate.notice.NoticeVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/corporate/notice")
public class CorporateNoticeController {
	
	@Autowired
	private ICoNoticeService noticeService;
	
	@Autowired
	private IFileService fileService;

	@GetMapping("/list")
	public String noticeList(
			@ModelAttribute NoticeVO noticeVO, Model model) {
		log.info("공지사항 목록 요청");
		
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<>();
		
		int currentPage = noticeVO.getPage();
		String searchType = noticeVO.getSearchType();
		String searchWord = noticeVO.getSearchWord();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			// 검색 후 목록 갈때 검색내용 적용
			model.addAttribute("searchType", noticeVO.getSearchType());
			model.addAttribute("searchWord", noticeVO.getSearchWord());
		}
		
		try {
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = noticeService.selectTotalRecord(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			List<NoticeVO> list = noticeService.selectNoticeList(pagingVO);
			pagingVO.setDataList(list);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "공지사항 목록을 불러오는 중 오류가 발생했습니다!!");
		}
		model.addAttribute("pagingVO", pagingVO);

		return "corporate/notice/noticeList";
	}
	
	@GetMapping("/detail")
	public String getDetail(@RequestParam int id, Model model) {
		log.info("getDetail() 실행..!!");
		
		NoticeVO noticeVO = null;
		noticeVO = noticeService.getDetail(id);

		if (noticeVO != null && noticeVO.getFileGroupNo() != null) {
			if(noticeVO.getFileGroupNo() != 0) {
				List<AttachmentFileDetailVO> fileList;
				try {
					fileList = fileService.getFileDetailsByGroupNo(noticeVO.getFileGroupNo());
					noticeVO.setAttachmentList(fileList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		model.addAttribute("noticeVO", noticeVO);
		
		return "corporate/notice/noticeDetail";
	}
}
