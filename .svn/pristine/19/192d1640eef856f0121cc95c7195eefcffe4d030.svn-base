package kr.or.ddit.config.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker	// websocket 활성화 ( STOMP 사용)
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// 메세지를 발행하는 목적지 설정
		config.enableSimpleBroker("/sub", "/queue");		// 구독
		config.setApplicationDestinationPrefixes("/pub");	// 발행

		// 사용자 별 알림 전송을 위한 설정
		config.setUserDestinationPrefix("/user");
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// STOMP 웹소켓 엔드포인트 등록
		registry.addEndpoint("/ws-stomp").setAllowedOrigins("http://localhost:6688").withSockJS();	// 접속 주소
	}



}
