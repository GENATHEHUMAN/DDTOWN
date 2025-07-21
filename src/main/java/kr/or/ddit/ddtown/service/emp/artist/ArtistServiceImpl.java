package kr.or.ddit.ddtown.service.emp.artist;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ddtown.mapper.emp.artist.IArtistMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ArtistServiceImpl implements IArtistService{

	@Autowired
	private IArtistMapper artistMapper;

	@Value("${kr.or.ddit.upload.path}")
	private String generalUploadPath;
	
	private final String artistProfileSubFolder = "profile/artist";
	
	@Override
	public List<ArtistVO> getAllArtists() {
		log.info("getAllArtists() 메소드 실행");
		
		List<ArtistVO> allArtist = artistMapper.getAllArtists();
		
		if (allArtist == null || allArtist.isEmpty()) {
            log.info("조회된 아티스트가 없습니다.");
        } else {
            log.info("조회된 아티스트 그룹 수: {}", allArtist.size());
        }

        return allArtist;
	}

	@Override
	public List<ArtistVO> getArtistList(Map<String, String> searchParams) {
		log.info("getArtistList() 메소드 실행");
		
		List<ArtistVO> artistList = artistMapper.getArtistList();
		
		if (artistList == null || artistList.isEmpty()) {
            log.info("조회된 아티스트가 없습니다.");
        } else {
            log.info("조회된 아티스트 수: {}", artistList.size());
        }
        return artistList;
	}
	@Transactional
	@Override
	public int updateArtist(ArtistVO artistToUpdate) {
		log.info("ArtistServiceImpl - updateArtist() 실행 (AdminArtistService 방식). ArtistVO: {}", artistToUpdate);
		
		MultipartFile profileFile = artistToUpdate.getProfileImg();
		
		// 1. 새 프로필 이미지 파일 처리
		if(profileFile != null && !profileFile.isEmpty()) {
			log.info("새로운 프로필 이미지 파일 감지: {}", profileFile.getOriginalFilename());
			
			try {
				String newRelativePath = uploadProfileImageDirectly(profileFile);
				artistToUpdate.setArtProfileImg(newRelativePath); // ArtistVO에 새 상대 경로 설정
	            
			} catch (Exception e) {
				log.error("프로필 이미지 파일 업로드 중 오류 발생", e);
                throw new RuntimeException("프로필 이미지 파일 저장에 실패했습니다.", e); // 예외 발생시켜 롤백 유도
            }
		}else {
			log.info("새로운 프로필 이미지 파일이 첨부되지 않았습니다. 기존 이미지 경로를 유지합니다: {}", artistToUpdate.getArtProfileImg());
        }
		
		// 2. 아티스트 정보 DB 업데이트
        int updateStatus = artistMapper.updateArtist(artistToUpdate);
		
        if (updateStatus > 0) {
            log.info("아티스트 정보 DB 업데이트 성공. 아티스트 번호: {}", artistToUpdate.getArtNo());
        } else {
            log.warn("아티스트 정보 DB 업데이트 실패. 아티스트 번호: {}", artistToUpdate.getArtNo());
            throw new RuntimeException("아티스트 정보 DB 업데이트에 실패했습니다.");
        }
        return updateStatus;
	}
	
	private String uploadProfileImageDirectly(MultipartFile multipartFile) throws IOException{
		
		File targetDirectory = new File(generalUploadPath, artistProfileSubFolder);
        if (!targetDirectory.exists()) {
            targetDirectory.mkdirs(); 
            log.info("디렉토리 생성됨: {}", targetDirectory.getAbsolutePath());
        }
        
        String originalFilename = multipartFile.getOriginalFilename();
        String saveFileName = UUID.randomUUID().toString() + "_" + originalFilename; // UUID로 고유한 파일명 생성

        File saveFile = new File(targetDirectory, saveFileName); // 최종 저장될 파일 객체

        try {
            multipartFile.transferTo(saveFile); // 파일 저장
            log.info("파일 저장 성공: {}", saveFile.getAbsolutePath());
        } catch (IllegalStateException | IOException e) {
            log.error("파일 저장 실패: {}, 원인: {}", saveFile.getAbsolutePath(), e.getMessage());
            throw e; 
        }
        return "/upload/" + artistProfileSubFolder.replace(File.separator, "/") + "/" + saveFileName;
	}

	@Override
	public List<ArtistVO> artistListWithPage(PaginationInfoVO<ArtistVO> pagingVO) {
		log.info("artistListWithPage() 실행");
		return artistMapper.artistListWithPage(pagingVO);
	}

	@Override
	public int selectArtistCount(PaginationInfoVO<ArtistVO> pagingVO) {
		log.info("selectArtistCount() 실행");
		return artistMapper.selectArtistCount(pagingVO);
	}
}
