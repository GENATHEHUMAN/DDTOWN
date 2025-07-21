package kr.or.ddit.vo.follow;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class FollowVO {
	
	private String memUsername;			// 팔로우 하는 사용자 ID
	private int artGroupNo;				// 팔로우 대상 아티스트 그룹
	private Timestamp followDate;		// 팔로우 시작 일시
	
	private String artGroupNm;			// 팔로우 하는 아티스트 그룹 이름
	private String artGroupProfileImg;	// 팔로우 하는 아티스트 프로필 이미지
	private int isMembership;		// 멤버십 가입 여부
}
