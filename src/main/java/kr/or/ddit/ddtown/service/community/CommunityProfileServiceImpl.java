package kr.or.ddit.ddtown.service.community;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.community.CommunityProfileMapper;
import kr.or.ddit.ddtown.mapper.community.ICommunityFollowMapper;
import kr.or.ddit.vo.community.CommunityProfileVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CommunityProfileServiceImpl implements ICommunityProfileService{

	@Value("${kr.or.ddit.upload.path}")
	private String uploadPath;

	@Value("${kr.or.ddit.upload.path.mac}")
	private String macUploadBasePath;

	private final String BASEIMG = "/upload/profile/base/defaultImg.png";

	private final CommunityProfileMapper communityProfileMapper;

	@Autowired
	private ICommunityFollowMapper followMapper;

	@Override
	public String getComuNicknmByUsername(String currentUser, Integer artGroupNo) {
		return communityProfileMapper.getComuNicknmByUsername(currentUser, artGroupNo);
	}

	/**
	 * 이미지 업로드 후 프로필 등록
	 */
	@Transactional
	@Override
	public int insertCommuProfile(CommunityProfileVO profileVO) {
		// 이미지 처리
		MultipartFile img = profileVO.getImgFile();
		if(img != null && StringUtils.isNotBlank(img.getOriginalFilename())) {
			try {
				String savePath = uploadImg(img,profileVO.getArtGroupNo());
				profileVO.setComuProfileImg(savePath);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				return 0;
			}
		}else {
			// 이미지 선택 안할시 기본 이미지 경로 지정
			profileVO.setComuProfileImg(BASEIMG);
		}
		int status = followMapper.insertFollow(profileVO.getMemUsername(),profileVO.getArtGroupNo());
		if(status > 0) {
			status = communityProfileMapper.insertCommuProfile(profileVO);
		}
		return status;
	}

	/**
	 * 프로필번호를 이용하여 닉네임및 프로필사진 변경
	 */
	@Transactional
	@Override
	public ServiceResult updateProfile(CommunityProfileVO profileVO) {
		ServiceResult result = null;
		MultipartFile img = profileVO.getImgFile();
		if(img != null && StringUtils.isNotBlank(img.getOriginalFilename())) {
			try {
				String savePath = uploadImg(img,profileVO.getArtGroupNo());
				profileVO.setComuProfileImg(savePath);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				return ServiceResult.FAILED;
			}
		}else {
			// 이미지 선택 안할시 이미 있는 경로 지정
		}
		int status = communityProfileMapper.updateProfile(profileVO);
		result = status > 0 ? ServiceResult.OK : ServiceResult.FAILED;
		return result;
	}

	/**
	 * 커뮤니티프로필 Del Y 처리
	 */
	@Transactional
	@Override
	public int deleteCommuProfile(CommunityProfileVO profileVO) {
		int status = communityProfileMapper.deleteCommuProfile(profileVO);
		if(status > 0) {
			status = followMapper.deleteFollow(profileVO.getMemUsername(),profileVO.getArtGroupNo());
			if(status == 0) {
				throw new RuntimeException("잘못된 데이터로 인해 삭제 안됨");
			}
		}else {
			throw new RuntimeException("잘못된 데이터로 인해 변경 안됨");
		}
		return status;
	}


	private String uploadImg(MultipartFile img, int artGroupNo) throws IllegalStateException, IOException {

		// 1. 현재 OS에 맞는 기본 업로드 경로 선택
        String os = System.getProperty("os.name").toLowerCase();
        String currentUploadBasePath;

        if(os.contains("mac") || os.contains("darwin")) {
        	currentUploadBasePath = macUploadBasePath;
        } else if(os.contains("win")) {
        	currentUploadBasePath = uploadPath;
        } else {
        	log.warn("알 수 없는 OS 환경입니다. window 경로를 사용합니다.");
        	currentUploadBasePath = uploadPath;
        }


		String savePath = currentUploadBasePath + "/community/" + artGroupNo;
		File file = new File(savePath);
		if(!file.exists()) {
			file.mkdirs();
		}

		if(StringUtils.isNotBlank(img.getOriginalFilename())) {
			String filename = UUID.randomUUID() + "_" + img.getOriginalFilename();
			savePath += "/" + filename;
			img.transferTo(new File(savePath));
		}

		 if(os.contains("mac") || os.contains("darwin")) {
			 	savePath = savePath.replace(macUploadBasePath, "/upload");
	        } else if(os.contains("win")) {
	        	savePath = savePath.replace(uploadPath, "/upload");
	        } else {
	        	savePath = savePath.replace(uploadPath, "/upload");
	        }
		return savePath;

	}

	// 커뮤니티 프로필 이미지 경로 조회
	@Override
	public String getComuProfileImgPath(String currentUser, Integer artGroupNo) {
		return communityProfileMapper.selectProfileImgPathByUsername(currentUser, artGroupNo);
	}

	// 커뮤니티 프로필 조회
	@Override
	public CommunityProfileVO getCommunityProfile(String username, int artGroupNo) {
		return communityProfileMapper.getCommunityProfile(username, artGroupNo);
	}

	// 커뮤니티 프로필 cat코드 업데이트
	@Override
	public void updateCommunityProfile(CommunityProfileVO existingComuProfile) {
		communityProfileMapper.updateCommunityProfile(existingComuProfile);
	}


	/**
	 * 아티스트 프로필 업데이트 할시 커뮤니티 프로필 이미지도 변경
	 */
	@Override
	public void updateArtistProfileImg(String imgUrl, String memUsername) {
		communityProfileMapper.updateArtistProfileImg(imgUrl,memUsername);

	}

	@Override
	public Integer getArtNoByUsername(String username) {
		return communityProfileMapper.selectArtNoByUsername(username);
	}
	
	
}
