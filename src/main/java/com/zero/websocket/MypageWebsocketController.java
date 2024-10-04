package com.zero.websocket;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MypageWebsocketController {
	
	private final MypageWebsocketService mypageWebsocketService;
	
	@MessageMapping("/validTime/{act_id}")
	@SendTo("/topic/activityItem/{act_id}")
	public OutputMessageVO send(@PathVariable String act_id, MessageVO msgvo) {
		OutputMessageVO out=mypageWebsocketService.updateValidTime(msgvo);
		return out;
	}
	
}
