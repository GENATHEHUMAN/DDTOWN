package kr.or.ddit.ddtown.controller.goods;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.ddtown.service.admin.goods.notice.IAdminGoodsNoticeService;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.ddtown.service.goods.notice.IGoodsNoticeService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/goods/notice")
public class goodsNoticeListController {
	
	@Autowired
	private IGoodsNoticeService noticeService;
	
	@Autowired
	private IAdminGoodsNoticeService adminnoticeService;
	
	@Autowired
	private IFileService fileService;
	
    @Value("${kr.or.ddit.upload.path}")
    private String windowUploadBasePath;

    @Value("${kr.or.ddit.upload.path.mac}")
    private String macUploadBasePath;
	
    @GetMapping("/list")
    public String noticeList(
            @RequestParam(name="currentPage", required=false, defaultValue="1") int currentPage,
            @RequestParam(name="searchType", required=false, defaultValue="title") String searchType, 
            @RequestParam(name="searchWord", required=false) String searchWord,
            @RequestParam(name="searchCategoryCode", required=false) String searchCategoryCode,
            @RequestParam(name="empUsername", required=false) String empUsername,
            Model model) {

        log.info("### 공지사항 목록/검색 페이지 요청");
        log.info("currentPage: {}, searchType: {}, searchWord: {}", currentPage, searchType, searchWord);
        log.info("searchCategoryCode: {}, empUsername: {}", searchCategoryCode, empUsername); // 추가된 파라미터 로깅

        PaginationInfoVO<goodsNoticeVO> pagingVO = new PaginationInfoVO<>();
        
        pagingVO.setScreenSize(10); 
        pagingVO.setBlockSize(5);   

        if (searchWord != null && !searchWord.trim().isEmpty()) {
            pagingVO.setSearchType(searchType);
            pagingVO.setSearchWord(searchWord);
            log.info("검색 조건 적용: searchType={}, searchWord={}", searchType, searchWord);
        }
        
        if (searchCategoryCode != null && !searchCategoryCode.trim().isEmpty()) {
            pagingVO.setSearchCategoryCode(searchCategoryCode);
            log.info("카테고리 검색 조건 적용: searchCategoryCode={}", searchCategoryCode);
        }
        if (empUsername != null && !empUsername.trim().isEmpty()) {
            pagingVO.setEmpUsername(empUsername);
            log.info("직원 사용자명 검색 조건 적용: empUsername={}", empUsername);
        }

        pagingVO.setCurrentPage(currentPage); 
        
        int totalCount = noticeService.getTotalGoodsNoticeCount(pagingVO);
        
        pagingVO.setTotalRecord(totalCount); 
        
        List<goodsNoticeVO> noticeList = noticeService.getAllGoodsNotices(pagingVO);
        pagingVO.setDataList(noticeList); 
        
        model.addAttribute("pagingVO", pagingVO);
        
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchWord", searchWord);
        model.addAttribute("searchCategoryCode", searchCategoryCode);
        model.addAttribute("empUsername", empUsername);

        log.info("### 공지사항 목록 로드 완료. 총 {}개, 현재 페이지: {}, 총 페이지: {}", 
                 totalCount, pagingVO.getCurrentPage(), pagingVO.getTotalPage());
        return "goods/noticeList"; 
    }
	
    @GetMapping("/detail/{goodsNotiNo}") 
    public String noticeDetail(
            @PathVariable("goodsNotiNo") int goodsNotiNo, 
            @RequestParam(name="currentPage", required=false, defaultValue="1") int currentPage,
            @RequestParam(name="searchType", required=false, defaultValue="title") String searchType, 
            @RequestParam(name="searchWord", required=false) String searchWord,
            Model model) {
        
        log.info("### GoodsNoticeController - noticeDetail 호출: goodsNotiNo={}", goodsNotiNo);
        
        goodsNoticeVO notice = adminnoticeService.getGoodsNotice(goodsNotiNo);
        
        if (notice == null) {
            log.warn("goodsNotiNo={} 에 해당하는 공지사항을 찾을 수 없습니다. 목록 페이지로 리다이렉트.", goodsNotiNo);
            model.addAttribute("message", "존재하지 않는 공지사항입니다.");
            return "redirect:/goods/notice/list"; 
        }
        
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchWord", searchWord);
        
        model.addAttribute("notice", notice);
        log.info("상세 페이지 데이터 로드 완료. 제목: {}", notice.getGoodsNotiTitle());
        return "goods/noticeDetail"; 
    }
	
    @GetMapping("/download/{fileDetailNo}") 
    @ResponseBody
    public void fileDownload(
            @PathVariable("fileDetailNo") int fileDetailNo,
            HttpServletResponse response) {

        log.info("### 파일 다운로드 요청: fileDetailNo={}", fileDetailNo);

        try {
            AttachmentFileDetailVO fileVO = fileService.getFileInfo(fileDetailNo);

            if (fileVO == null) {
                log.warn("fileDetailNo={} 에 해당하는 파일을 찾을 수 없습니다.", fileDetailNo);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
                return;
            }
            String os = System.getProperty("os.name").toLowerCase();
            String currentUploadBasePath;

            if (os.contains("mac") || os.contains("darwin")) {
                currentUploadBasePath = macUploadBasePath;
            } else if (os.contains("win")) {
                currentUploadBasePath = windowUploadBasePath;
            } else {
                log.warn("알 수 없는 OS 환경입니다. window 경로를 사용합니다.");
                currentUploadBasePath = windowUploadBasePath;
            }
            File file = new File(currentUploadBasePath + File.separator + fileVO.getFileSavepath() + File.separator + fileVO.getFileSaveNm());

            if (!file.exists()) {
                log.warn("실제 파일이 서버 경로에 존재하지 않습니다: {}", file.getAbsolutePath());
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "실제 파일이 존재하지 않습니다.");
                return;
            }

            String originalFileName = URLEncoder.encode(fileVO.getFileOriginalNm(), "UTF-8").replaceAll("\\+", "%20");
            response.setContentType(fileVO.getFileMimeType() != null ? fileVO.getFileMimeType() : "application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");
            response.setContentLengthLong(file.length());

            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream outputStream = response.getOutputStream()) {
                
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                outputStream.flush();
                log.info("파일 다운로드 성공: {}", file.getName());
            }

        } catch (Exception e) {
            log.error("파일 다운로드 중 오류 발생 (fileDetailNo={}): {}", fileDetailNo, e.getMessage(), e);
            try {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "파일 다운로드 중 오류가 발생했습니다.");
            } catch (Exception se) {
                log.error("에러 응답 전송 중 추가 오류 발생", se);
            }
        }
    }
}
