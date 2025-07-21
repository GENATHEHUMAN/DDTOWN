package kr.or.ddit.security.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.user.EmployeeVO;
import kr.or.ddit.vo.user.MemberVO;
import kr.or.ddit.vo.user.PeopleAuthVO;

@Mapper
public interface ISecMemberMapper {

	public MemberVO readByUserInfoMember(String username);

	public void insertPeopleByOAuth2(MemberVO memberVO);
	public void insertMemberByOAuth2(MemberVO memberVO);

	public void insertAuthByOAuth2(PeopleAuthVO memberAuthVO);

	public MemberVO selectByMemUsernameOAuth2(MemberVO memberVO);

	public EmployeeVO readByUserInfoEmployee(String username);

	public void updateEnabled(MemberVO existingUser);

	public void updateEtcYn(MemberVO existingUser);

}
