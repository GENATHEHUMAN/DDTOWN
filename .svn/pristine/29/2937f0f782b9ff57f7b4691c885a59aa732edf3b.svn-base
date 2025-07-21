package kr.or.ddit.security;

import java.io.IOException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	public static final String LOGIN_FAILURE_COUNT_SESSION_ATTR = "loginFailure";
	public static final int MAX_RECAPTCHA_COUNT = 5;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String refererUrl = request.getHeader("Referer");
		log.info("refererUrl : {}", refererUrl);
		HttpSession session = request.getSession(false);
		int failureCount = 0;
		// 실패한 카운터 수 정보 세션에 저장
		if(session != null) {
			Object count = session.getAttribute(LOGIN_FAILURE_COUNT_SESSION_ATTR);
			if(count instanceof Integer) {
				failureCount = (Integer) count;
			}
			failureCount++;
			session.setAttribute(LOGIN_FAILURE_COUNT_SESSION_ATTR, failureCount);
			log.info("Login failure for session {}. Count: {}", session.getId(), failureCount);
			
			if(failureCount >= MAX_RECAPTCHA_COUNT) {
				session.setAttribute("showRecaptcha", true);
				log.info("reCAPTCHA should be shown for session {}", session.getId());
			}
			session.setAttribute("error", "아이디 혹은 비밀번호를 잘못 입력하셨습니다!");
		}
		String path = "/login";
		if(StringUtils.isNotBlank(refererUrl) && refererUrl.endsWith("/admin/login")) {
			path = "/admin/login";
		}
		log.info("로그인 검증 실패 로직 실행!!!!");
		log.info("예외 : {}", exception.getMessage());
		response.sendRedirect(path);
	}
}
