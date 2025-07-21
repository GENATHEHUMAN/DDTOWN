package kr.or.ddit.ddtown.service.admin.goods.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile; // MultipartFile 임포트

import kr.or.ddit.ddtown.mapper.admin.goods.notice.IAdminGoodsNoticeMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.ddtown.service.file.IFileService; // 파일 서비스 임포트 (패키지 경로 확인)
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.goods.goodsNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminGoodsNoticeServiceImpl implements IAdminGoodsNoticeService {

    @Autowired
    private IAdminGoodsNoticeMapper adminGoodsNoticeMapper;
    
    @Autowired
    private IGoodsMapper goodsMapper;
    
    @Autowired
    private IFileService fileService;
    
    private static final String FILETYPECODE = "FITC012";

    @Override
    public int getTotalGoodsNoticeCount(PaginationInfoVO<goodsNoticeVO> pagingVO) {
        log.info("getTotalGoodsNoticeCount() 호출: searchType={}, searchWord={}",
                 pagingVO.getSearchType(), pagingVO.getSearchWord());
        try {
            int totalCount = adminGoodsNoticeMapper.selectTotalGoodsNoticeCount(pagingVO);
            log.info("getTotalGoodsNoticeCount() 결과: 총 공지사항 수 = {}", totalCount);
            return totalCount;
        } catch (Exception e) {
            log.error("getTotalGoodsNoticeCount() 오류 발생: {}", e.getMessage(), e);
            return 0;
        }
    }

    @Override
    public List<goodsNoticeVO> getAllGoodsNotices(PaginationInfoVO<goodsNoticeVO> pagingVO) {
        log.info("getAllGoodsNotices() 호출: currentPage={}, startRow={}, endRow={}, searchType={}, searchWord={}",
                 pagingVO.getCurrentPage(), pagingVO.getStartRow(), pagingVO.getEndRow(),
                 pagingVO.getSearchType(), pagingVO.getSearchWord());
        try {
            List<goodsNoticeVO> noticeList = adminGoodsNoticeMapper.selectAllGoodsNotices(pagingVO);
            log.info("getAllGoodsNotices() 결과: 조회된 공지사항 개수 = {}", noticeList != null ? noticeList.size() : 0);
            return noticeList;
        } catch (Exception e) {
            log.error("getAllGoodsNotices() 오류 발생: {}", e.getMessage(), e);
            return null;
        }
    }

    @Override
    public goodsNoticeVO getGoodsNotice(int goodsNotiNo) {
        log.info("getGoodsNotice() 호출: goodsNotiNo={}", goodsNotiNo);
        try {
            goodsNoticeVO notice = adminGoodsNoticeMapper.selectGoodsNotice(goodsNotiNo);
            if (notice != null) {
                log.info("getGoodsNotice() 결과: 공지사항({}), 제목: '{}'", notice.getGoodsNotiNo(), notice.getGoodsNotiTitle());
            } else {
                log.warn("getGoodsNotice() 결과: goodsNotiNo={} 에 해당하는 공지사항을 찾을 수 없습니다.", goodsNotiNo);
            }
            return notice;
        } catch (Exception e) {
            log.error("getGoodsNotice() 오류 발생: goodsNotiNo={}: {}", goodsNotiNo, e.getMessage(), e);
            return null;
        }
    }

    // --- 새로운 공지사항 등록 로직 (파일 업로드 로직 포함) ---
    @Override
    @Transactional // 트랜잭션 적용
    public int createGoodsNotice(goodsNoticeVO noticeVO, MultipartFile[] uploadFile) { // 파라미터 변경
        log.warn("<<<<< SERVICE createGoodsNotice 진입! Thread: {}, Title: {} >>>>>",
                 Thread.currentThread().getName(), noticeVO.getGoodsNotiTitle());
        log.info("createGoodsNotice() 실행 시작..!");

        try {
            // 1. 파일 업로드 처리 및 파일 그룹 번호 생성
            log.info("파일 처리 시작. uploadFile is null: {}", (uploadFile == null));

            Integer fileGroupResult = null;
            // FileServiceImpl의 uploadAndProcessFiles 메서드는 MultipartFile[]를 받습니다.
            // 첫 번째 파일이 비어있는지 확인하여 실제 파일이 있는지 검증합니다.
            if (uploadFile != null && uploadFile.length > 0 && !uploadFile[0].isEmpty()) {
                fileGroupResult = fileService.uploadAndProcessFiles(uploadFile, FILETYPECODE, noticeVO.getEmpUsername());
                log.info("fileService.uploadAndProcessFiles 반환 값 (fileGroupResult): {}", fileGroupResult);
            } else {
                log.info("업로드할 파일이 없거나 비어있어 fileGroupNo를 null로 설정합니다.");
            }
            // VO에 파일 그룹 번호 설정
            noticeVO.setFileGroupNo(fileGroupResult);
            log.info("설정된 fileGroupNo: {}", noticeVO.getFileGroupNo());

            // 2. 공지사항 정보 DB에 삽입
            // goodsNotiNo는 insertGoodsNotice 호출 시점에 DB 시퀀스로 생성되거나, <selectKey>로 설정되어야 합니다.
            int noticeInsertRowCount = adminGoodsNoticeMapper.insertGoodsNotice(noticeVO);

            if (noticeInsertRowCount <= 0) {
                log.warn("공지사항 기본 정보 DB 등록 실패: {}", noticeVO.getGoodsNotiTitle());
                throw new RuntimeException("공지사항 기본 정보 DB 등록 실패"); // 실패 시 롤백 유도
            }
            log.info("공지사항 기본 정보 DB 등록 성공: goodsNotiNo={}, goodsNotiTitle={}", noticeVO.getGoodsNotiNo(), noticeVO.getGoodsNotiTitle());

            return noticeInsertRowCount; // 성공 시 영향 받은 행 수 반환 (일반적으로 1)

        } catch (Exception e) {
            log.error("공지사항 등록 중 오류 발생: {}", e.getMessage(), e);
            // RuntimeException을 던져서 @Transactional이 롤백을 수행하도록 합니다.
            throw new RuntimeException("공지사항 등록 중 오류 발생", e);
        }
    }

    @Override
    @Transactional // 트랜잭션 적용
    public int updateGoodsNotice(goodsNoticeVO noticeVO, MultipartFile[] uploadFile) {
        log.warn("<<<<< SERVICE updateGoodsNotice 진입! Thread: {}, Title: {} >>>>>",
                 Thread.currentThread().getName(), noticeVO.getGoodsNotiTitle());

        try {
            // 0. 수정 대상 공지사항 존재 여부 확인 및 기존 파일 그룹 번호 가져오기
            goodsNoticeVO existingNotice = adminGoodsNoticeMapper.selectGoodsNotice(noticeVO.getGoodsNotiNo());
            if (existingNotice == null) {
                log.error("수정할 공지사항을 찾을 수 없습니다. goodsNotiNo: {}", noticeVO.getGoodsNotiNo());
                throw new RuntimeException("수정할 공지사항 정보가 없습니다.");
            }

            Integer currentFileGroupNo = existingNotice.getFileGroupNo(); // 기존 공지사항에 연결된 파일 그룹 번호
            
            // 최종적으로 공지사항에 설정될 파일 그룹 번호 (기본값은 기존 그룹 번호)
            Integer finalFileGroupNoForNotice = currentFileGroupNo; 

            boolean hasNewFilesToUpload = (uploadFile != null && uploadFile.length > 0 && !uploadFile[0].isEmpty());
            log.info("수정 요청 시 새 파일 첨부 여부: {}", hasNewFilesToUpload);
            log.info("기존 공지사항의 currentFileGroupNo: {}", currentFileGroupNo);
            log.info("폼에서 넘어온 삭제할 파일 상세 번호: {}", noticeVO.getDeleteAttachDetailNos());


            // 1. 기존 특정 파일 삭제 요청 처리 (JSP에서 선택된 파일 삭제)
            // noticeVO.getDeleteAttachDetailNos()가 이미 List<Integer>이므로 별도 변환 없이 바로 사용합니다.
            if (noticeVO.getDeleteAttachDetailNos() != null && !noticeVO.getDeleteAttachDetailNos().isEmpty()) {
                log.info("삭제할 첨부파일 ID 목록: {}", noticeVO.getDeleteAttachDetailNos());
                fileService.deleteSpecificFiles(noticeVO.getDeleteAttachDetailNos());
            }

            // 2. 새 파일 추가 업로드 처리
            if (hasNewFilesToUpload) {
                log.info("새 파일 업로드 처리 시작. 업로드할 파일 수: {}", uploadFile.length);
                
                if (currentFileGroupNo == null || currentFileGroupNo == 0) {
                    // 기존에 파일 그룹이 없었다면 (새롭게 파일을 첨부하는 경우)
                    // FileService의 uploadAndProcessFiles는 새 그룹을 생성하고 파일을 업로드합니다.
                    Integer newFileGroupNo = fileService.uploadAndProcessFiles(uploadFile, FILETYPECODE, noticeVO.getEmpUsername());
                    if (newFileGroupNo != null && newFileGroupNo > 0) {
                        finalFileGroupNoForNotice = newFileGroupNo;
                        log.info("기존 파일 그룹이 없어 새 파일 그룹 {} 생성 및 연결", finalFileGroupNoForNotice);
                    } else {
                        log.warn("새 파일 업로드 처리 실패 (새 그룹 번호 획득 실패). 공지사항 파일 그룹은 null 유지.");
                        finalFileGroupNoForNotice = null; // 실패 시 파일 그룹 null
                    }
                } else {
                    // 기존 파일 그룹이 있었다면, 해당 그룹에 새 파일들을 추가합니다.
                    // FileService의 addFilesToExistingGroup은 기존 그룹에 파일을 추가합니다.
                    Integer appendedFileGroupNo = fileService.addFilesToExistingGroup(uploadFile, FILETYPECODE, noticeVO.getEmpUsername(), currentFileGroupNo);
                    if(appendedFileGroupNo != null && appendedFileGroupNo > 0) {
                        finalFileGroupNoForNotice = appendedFileGroupNo; // 기존 그룹 번호가 그대로 반환됨
                        log.info("기존 파일 그룹 {}에 새 파일 추가 완료 및 연결 유지", finalFileGroupNoForNotice);
                    } else {
                        log.warn("새 파일 업로드 처리 실패 (기존 그룹에 추가 실패). finalFileGroupNoForNotice는 기존 값 유지.");
                    }
                }
            }
            
            // 3. 최종 파일 그룹 상태 확인 및 정리
            // 기존 파일 삭제 및/또는 새 파일 추가 후, 최종적으로 공지사항에 연결될 파일 그룹의 상태를 확인합니다.
            if (finalFileGroupNoForNotice != null) {
                int remainingFiles = fileService.countFilesInGroup(finalFileGroupNoForNotice);
                log.info("최종 파일 그룹({})에 남아있는 파일 개수: {}", finalFileGroupNoForNotice, remainingFiles);

                if (remainingFiles == 0) {
                    // 파일 그룹에 더 이상 파일이 없다면 (모두 삭제되었거나, 새 파일도 없음)
                    // 파일 그룹 레코드 자체를 삭제하고, 공지사항의 fileGroupNo를 null로 설정
                    fileService.deleteFilesByGroupNo(finalFileGroupNoForNotice); 
                    finalFileGroupNoForNotice = null; // 공지사항의 FILE_GROUP_NO를 NULL로 설정
                    log.info("파일 그룹({})의 모든 파일이 삭제되어 그룹 레코드 삭제 및 공지사항의 fileGroupNo를 null로 설정", finalFileGroupNoForNotice);
                }
            } else {
                // finalFileGroupNoForNotice가 이미 null인 경우 (원래 파일 없었거나, 삭제만 했고 새 파일도 없어서)
                log.info("최종 finalFileGroupNoForNotice는 null 유지 (파일 없음)");
            }
            
            // 4. noticeVO에 최종 결정된 fileGroupNo 설정
            noticeVO.setFileGroupNo(finalFileGroupNoForNotice);
            log.info("noticeVO에 최종 설정된 fileGroupNo: {}", noticeVO.getFileGroupNo());

            // 5. 공지사항 기본 정보 최종 업데이트 (DB 반영)
            int finalUpdateNoticeCount = adminGoodsNoticeMapper.updateGoodsNotice(noticeVO);
            if (finalUpdateNoticeCount <= 0) {
                log.warn("공지사항 기본 정보 DB 최종 업데이트 실패: {}", noticeVO.getGoodsNotiTitle());
                throw new RuntimeException("공지사항 기본 정보 DB 최종 업데이트 실패");
            }
            log.info("공지사항 기본 정보 DB 최종 업데이트 성공: goodsNotiNo={}, goodsNotiTitle={}", noticeVO.getGoodsNotiNo(), noticeVO.getGoodsNotiTitle());

            return finalUpdateNoticeCount;

        } catch (Exception e) {
            log.error("공지사항 수정 중 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("공지사항 수정 중 오류 발생", e);
        }
    }
    
    // --- 공지사항 삭제 로직 (파일 삭제 포함) ---
    @Override
    @Transactional // 공지사항 삭제와 파일 삭제를 하나의 트랜잭션으로 묶습니다.
    public boolean deleteGoodsNotice(int goodsNotiNo) {
        log.warn("<<<<<Service deleteGoodsNotice 진입!!!! goodsNotiNo: {} >>>>>", goodsNotiNo);
        try {
            // 1. 공지사항에 연결된 파일 그룹 번호 조회
            goodsNoticeVO notice = adminGoodsNoticeMapper.selectGoodsNotice(goodsNotiNo); // 공지사항 상세 정보 조회
            Integer fileGroupNo = null;
            if (notice != null) {
                fileGroupNo = notice.getFileGroupNo();
            }

            // 2. 공지사항 정보 DB에서 삭제
            int deleteResult = adminGoodsNoticeMapper.deleteGoodsNotice(goodsNotiNo);

            if (deleteResult > 0) {
                log.info("공지사항(goodsNotiNo:{}) 삭제 성공!", goodsNotiNo);

                // 3. 연결된 파일 삭제 (파일 그룹 번호가 있는 경우에만)
                if (fileGroupNo != null && fileGroupNo > 0) {
                    fileService.deleteFilesByGroupNo(fileGroupNo); // 파일 그룹 및 실제 파일 삭제
                    log.info("공지사항(goodsNotiNo:{}) 관련 파일 그룹({}) 및 상세 파일 삭제 완료.", goodsNotiNo, fileGroupNo);
                } else {
                    log.info("공지사항(goodsNotiNo:{})에 연결된 파일 없음 또는 fileGroupNo가 null.", goodsNotiNo);
                }
                return true;
            } else {
                log.warn("공지사항(goodsNotiNo:{}) 삭제 실패! (영향 받은 행 없음)", goodsNotiNo);
                return false;
            }
        } catch (Exception e) {
            log.error("deleteGoodsNotice() 오류 발생: goodsNotiNo={}: {}", goodsNotiNo, e.getMessage(), e);
            throw new RuntimeException("공지사항 삭제 중 오류 발생: " + e.getMessage(), e); // 예외를 다시 던져서 트랜잭션 롤백 유도
        }
    }
    
}