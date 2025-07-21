package kr.or.ddit.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.security.CustomLoginFailureHandler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RecaptchaAuthenticationFilter extends OncePerRequestFilter {
	
	private String recaptchaSiteKey;
	private String recaptchaVerifyUrl;
	
	private AuthenticationFailureHandler failureHandler;
	
	public RecaptchaAuthenticationFilter(AuthenticationFailureHandler failureHandler, String recaptchaSiteKey, String recaptchaVerifyUrl) {
		this.failureHandler = failureHandler;
		this.recaptchaSiteKey = recaptchaSiteKey;
		this.recaptchaVerifyUrl = recaptchaVerifyUrl;
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		if(request.getRequestURI().equals(request.getContextPath() + "/login") && request.getMethod().equalsIgnoreCase("POST")) {
			log.info("RecaptchaAuthenticationFilter-> doFilterInternal 실행!");
			HttpSession session = request.getSession(false);
			boolean recaptchaFlag = false;
			
			if(session != null) {
				Object countObj = session.getAttribute(CustomLoginFailureHandler.LOGIN_FAILURE_COUNT_SESSION_ATTR);
				if(countObj instanceof Integer) {
					int count = (Integer) countObj;
					if(count >= CustomLoginFailureHandler.MAX_RECAPTCHA_COUNT) {
						recaptchaFlag = true;
						log.info("reCAPTCHA verification is required due to {} login failures.", count);
					}
				}
			}
			if(recaptchaFlag) {
				String recaptchaResponse = request.getParameter("g-recaptcha-response");
				
				if(StringUtils.isBlank(recaptchaResponse) || !verifyRecaptcha(recaptchaResponse, request.getRemoteAddr())) {
					try {
						SecurityContextHolder.getContext().setAuthentication(null);
						failureHandler.onAuthenticationFailure(request, response, new InsufficientAuthenticationException("Invalid reCAPTCHA"));					
					}catch(ServletException e) {
						log.error("RecaptchaAuthenticationFilter : {}", e);
						throw e;
					}catch(IOException e) {
						log.error("RecaptchaAuthenticationFilter : {}" , e);
						throw e;
					}
					return;
				}
			}
		}
		filterChain.doFilter(request, response);
		
	}

	private boolean verifyRecaptcha(String recaptchaToken, String remoteIp) {
		if(StringUtils.isEmpty(recaptchaVerifyUrl)) {
			log.error("reCAPTCHA verify URL (for assessment API) is not configured!");
			return false;
		}
		if(StringUtils.isEmpty(recaptchaSiteKey )) {
			log.error("reCAPTCHA recaptchaSiteKe is not configured!");
			return false;
		}
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> eventMap = new HashMap<>();
		eventMap.put("token", recaptchaToken);
		eventMap.put("siteKey", recaptchaSiteKey);
		if(StringUtils.isNotBlank(remoteIp)) {
			eventMap.put("userIpAddress", remoteIp);
		}
		
		Map<String, Object> requestBodyMap = new HashMap<>();
		requestBodyMap.put("event", eventMap);
		
		HttpEntity<Map<String, Object>> entity = new HttpEntity<Map<String,Object>>(requestBodyMap,headers);
		try {
			ResponseEntity<Map> responseEntity = restTemplate.postForEntity(recaptchaVerifyUrl, entity, Map.class);
			
			if(responseEntity != null && responseEntity.getBody() != null) {
				Map<String, Object> responseBody = responseEntity.getBody();
				
				Object tokenPropertiesObj = responseBody.get("tokenProperties");
				if(tokenPropertiesObj instanceof Map) {
					Map<String, Object> tokenProperties = (Map<String, Object>) tokenPropertiesObj;
					Boolean isValid = (Boolean) tokenProperties.get("valid");
					String action = (String) tokenProperties.get("action");
			
					if(!"LOGIN".equals(action)) {
						log.error("reCAPTCHA action mismatch. Expected : 'LOGIN' , Actual : {} ", action);						
						return false;
					}
					
					if(Boolean.TRUE.equals(isValid)) {
						Object riskAnalysisObj = responseBody.get("riskAnalysis");
						if(riskAnalysisObj instanceof Map) {
							Map<String, Object> riskAnalysis = (Map<String, Object>) riskAnalysisObj;
							Double score = (Double) riskAnalysis.get("score");
							log.info("reCAPTCHA score : {}",score);
							return score != null && score >= 0.5;
						}
						return true;
					}else {
						log.warn("reCAPTCHA 'tokenProperties.valid' field is not a Boolean or is missing.");
						return false;
					}
				}else {
					log.warn("reCAPTCHA 'tokenProperties' field is not a Map or is missing.");
	                return false;
				}
			}
			return false;
			
		}catch(RestClientException e) {
			log.error("reCAPTCHA assessment creation failed: {}", e.getMessage(),e);
			return false;
		}catch(ClassCastException e) {
			log.error("Error casting parts of reCAPTCHA response: {}", e.getMessage(), e);
			return false;
		}
	}

}
