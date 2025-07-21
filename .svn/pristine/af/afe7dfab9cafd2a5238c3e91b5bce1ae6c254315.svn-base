package kr.or.ddit.ddtown.service;

import java.util.Map;

import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class EmailService {

	private final JavaMailSender javaMailSender;
	private final SpringTemplateEngine thymleafTemplate;
	
	@Async
	public void sendEmailWithThymleafTemplete(String to, String subject, String template, Map<String, Object> modelData) {
		
		try {
			Context context = new Context();
			context.setVariables(modelData);
			
			String htmlContent = thymleafTemplate.process(template, context);
			
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(htmlContent, true);
			
			javaMailSender.send(mimeMessage);
			log.info("{} 에게 thyleaf 템플릿 메일 발송 성공!",to);
		} catch (MailException e) {
			log.error(to + "에게 메일 발송 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			log.error("메일 컨텐츠 생성 중 기타 오류 발생: " + e.getMessage());
			e.printStackTrace();
		}
	}

}
