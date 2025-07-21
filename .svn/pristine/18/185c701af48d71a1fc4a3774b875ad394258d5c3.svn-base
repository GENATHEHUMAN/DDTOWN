package kr.or.ddit.ddtown.controller.community;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ddtown.service.community.ICommunityLSNService;
import kr.or.ddit.ddtown.service.community.ICommunityMainPageService;
import kr.or.ddit.ddtown.service.community.notice.ICommunityNoticeService;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.community.CommunityNoticeVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.schedule.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityLSNController {

	@Autowired
	private ICommunityMainPageService artistMainPageService;

	@Autowired
	private ICommunityNoticeService noticeService;

	@Autowired
	private ICommunityLSNService lSNService;

	@Autowired
	private ICommunityMainPageService communityMainService;

	@Value("${kr.or.ddit.upload.path}")
	private String windowUploadBasePath;

	@GetMapping("/fullcalendar/event/{artGroupNo}")
	public ResponseEntity<List<ScheduleVO>> scheduleList(@PathVariable int artGroupNo){

		log.info("커뮤니티에서 스케줄을 요청함...");

		List<ScheduleVO> list = lSNService.scheduleList(artGroupNo);

		log.info("요청한 list : " + list);

		return new ResponseEntity<List<ScheduleVO>>(list,HttpStatus.OK);
	}

	@GetMapping("/notice/{artGroupNo}")
	public ResponseEntity<Map<Object, Object>> noticeCall(
			PaginationInfoVO<CommunityNoticeVO> pagingVO,
			@PathVariable int artGroupNo){

		Map<Object, Object> map = new HashMap<>();

		pagingVO.setArtGroupNo(artGroupNo);

		if(pagingVO.getCurrentPage() == 0) {
			pagingVO.setCurrentPage(1);
		}

		try {

			int totalRecord = noticeService.selectNoticeCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);

			List<CommunityNoticeVO> noticeList = noticeService.clientPointOfViewCommunityNoticeList(pagingVO);

			pagingVO.setDataList(noticeList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("공지사항 목록요청함 : " + pagingVO.getDataList());
		ArtistGroupVO artistGroupVO = communityMainService.getCommunityInfo(artGroupNo);

		List<CommonCodeDetailVO> noticeCodeVO = lSNService.getCodeList();

		map.put("pagingVO", pagingVO);

		map.put("noticeCodeVO", noticeCodeVO);

		map.put("artistGroupVO", artistGroupVO);

		return new ResponseEntity<Map<Object,Object>>(map, HttpStatus.OK);
	}

	@GetMapping("/notice/post/{noticeNo}")
	public String noticeOne(@PathVariable int noticeNo, Model model) {

		try {
			CommunityNoticeVO noticeVO = noticeService.selectNotice(noticeNo);
			model.addAttribute("noticeVO", noticeVO);

			ArtistGroupVO artistGroupVO = communityMainService.getCommunityInfo(noticeVO.getArtGroupNo());
			model.addAttribute("artistGroupVO", artistGroupVO);

			int artGroupNo = artistGroupVO.getArtGroupNo();
			List<CommunityNoticeVO> noticeList = noticeService.allNoticeList(artGroupNo);

			int preNoticeNo = 0;
			int aftNoticeNo = 0;
			for(int i=0; i<noticeList.size(); i++) {
				int listNoticeNo = noticeList.get(i).getComuNotiNo();

				if(noticeNo == listNoticeNo) {
					if(i-1 != -1) {
						aftNoticeNo = noticeList.get(i-1).getComuNotiNo();
					}
					if(i+1 != noticeList.size()) {
						preNoticeNo = noticeList.get(i+1).getComuNotiNo();
					}

					log.info("preNoticeNo,aftNoticeNo " + preNoticeNo + " : "+ aftNoticeNo);
				}
			}

			model.addAttribute("preNoticeNo", preNoticeNo);
			model.addAttribute("aftNoticeNo", aftNoticeNo);
			log.info("artistGroupVO : ", artistGroupVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "community/apt/noticeOne";
	}

	@Autowired
	private IFileService fileService;

	@GetMapping("/notice/file/download/{fileDetailNo}")
	public ResponseEntity<byte[]> download(@PathVariable int fileDetailNo) {
		log.info("공지 download 요청..! fileDetailNO: {}", fileDetailNo);

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		try {
			AttachmentFileDetailVO detailVO = fileService.getFileInfo(fileDetailNo);

			if (detailVO == null) {
				log.warn("파일 정보를 찾을 수 없습니다. fileDetailNo: {}", fileDetailNo);
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}

			String fileName = detailVO.getFileSaveNm();
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();

			in = new FileInputStream(windowUploadBasePath + File.separator +detailVO.getFileSavepath() + File.separator + detailVO.getFileSaveNm());


			if(mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Dispostion", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}

			entity = new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);

		} catch (Exception e) {
			log.error("파일 다운로드 중 알 수 없는 오류 발생 (General Exception): {}", e.getMessage(), e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} finally {
			if(in != null) {
				try {
					in.close();
				} catch (IOException e) {
					log.error("InputStream 닫기 실패: {}", e.getMessage());
				}
			}
		}
		return entity;
	}

	private MediaType getMediaType(String formatName) {
		if(formatName != null && !formatName.isEmpty()) {
			formatName = formatName.toLowerCase();
			switch (formatName) {
				case "jpg":
				case "jpeg": return MediaType.IMAGE_JPEG;
				case "png":  return MediaType.IMAGE_PNG;
				case "gif":  return MediaType.IMAGE_GIF;
				case "pdf":  return MediaType.APPLICATION_PDF;
				case "doc":
				case "docx": return MediaType.valueOf("application/msword"); // MS Word
				case "xls":
				case "xlsx": return MediaType.valueOf("application/vnd.ms-excel"); // MS Excel
				case "ppt":
				case "pptx": return MediaType.valueOf("application/vnd.ms-powerpoint"); // MS PowerPoint
				case "zip":  return MediaType.valueOf("application/zip"); // ZIP 압축 파일
				case "txt":  return MediaType.valueOf("text/plain"); // 텍스트 파일
				// 필요한 경우 더 많은 MIME 타입 추가
			}
		}
		return null;
	}
}
