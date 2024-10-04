package com.zero.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker //webSocket관련 설정이 작동된다
//implements WebSocketMessageBrokerConfigurer 해야 함
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		
		//브라우저: ws://localhost:9090/컨텍스트/chat ==>sockjs에서 접속할때 사용(sockjs연결주소)
		//여러 명 채팅
		registry.addEndpoint("/validTime")
		.withSockJS();//버전 낮은 브라우저에서도 적용
		
		//queue 사용시접속 클라이언트를 식별할 HandshakeHandler설정
	}//-----------------------------------------

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		//해당 주소를 구독하는 서버가 클라이언트에게 메시지를 전달한다
		registry.enableSimpleBroker("/topic","/queue");
		
		//클라이언트가 서버로 보낸 메시지를 받는 prefix(접두어)
		registry.setApplicationDestinationPrefixes("/app");
		// /app/validTime
	}
}