package kr.or.ddit.vo.user;

import java.util.List;

import lombok.Data;

@Data
public class PeopleVO {
	private String username; // 실제 oAuth2 에서 가지고온 아이디
	private String password;
	private String peoEnabled;
	private String userTypeCode;
	private String peoFirstNm;
	private String peoLastNm;
	private String peoEmail;
	private String peoGender;
	private String peoPhone;
	private String peoName; // peoLastNm + peoFirstNm
	private List<PeopleAuthVO> authList;
	private String originUsername; // db에 가지고오는 username

}
