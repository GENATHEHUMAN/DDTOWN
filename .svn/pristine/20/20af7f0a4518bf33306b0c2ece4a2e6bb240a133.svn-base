package kr.or.ddit.vo.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.user.EmployeeVO;
import kr.or.ddit.vo.user.MemberVO;
import lombok.Getter;

@Getter
public class CustomUser extends User {

	private MemberVO memberVO;
	private EmployeeVO employeeVO; 
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username,password,authorities);
	}
	
	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMemUsername(),memberVO.getPassword(),
				memberVO.getAuthList().stream().map(auth -> 
					new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.memberVO = memberVO;
	}
	
	public CustomUser(EmployeeVO employeeVO) {
		super(employeeVO.getEmpUsername(),employeeVO.getPassword(),
				employeeVO.getAuthList().stream().map(auth -> 
				new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.employeeVO = employeeVO;
	}
	
	
}
