package kr.or.ddit.ddtown.controller.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ddtown.service.community.notice.IConcertNoticeMapService;

@Controller
@RequestMapping("/concertNoticeMap")
public class ConcertNoticeMapController {

    @Autowired
    private IConcertNoticeMapService service;

    // 예시: 일정 상세에서 공지사항 바로가기
    @GetMapping("/noticeDetail")
    public String noticeDetail(@RequestParam int artScheduleNo, Model model) {
        // 연결된 공지사항 1개만 있다고 가정
        var noticeList = service.selectNoticeByArtScheduleNo(artScheduleNo);
        if(noticeList != null && !noticeList.isEmpty()) {
            int comuNotiNo = noticeList.get(0).getComuNotiNo();
            return "redirect:/community/notice/post/" + comuNotiNo;
        }
        //  등
        return "/community/main";
    }
}