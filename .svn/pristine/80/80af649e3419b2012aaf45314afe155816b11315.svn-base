package kr.or.ddit.security;

import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomOAuth2LoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("로그인 검증 실패 로직 실행!!!!");
		log.info("예외 : {}", exception.getMessage());
		String url = "/login";
		if(exception instanceof OAuth2AuthenticationException) {
			OAuth2AuthenticationException oAuth2Exception = (OAuth2AuthenticationException) exception;
			OAuth2Error err = oAuth2Exception.getError();
			String errCode = err.getErrorCode();
			String errDescription = err.getDescription();
			
			log.error("OAuth2 인증 오류 -> 에러코드 : {}, 내용 : {}",errCode,errDescription);
			
			if("access_denied".equals(errCode)) {
				url = "/login?err=social_access_denied";
			}
			if("invalid_request".equals(errCode)) {
				url = "/login?err=social_invalid_request";
			}
			
		}
		response.sendRedirect(url);
	}
}
