package com.zero.websocket;

import org.springframework.stereotype.Service;

import com.zero.waste.mapper.ActivityMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MypageWebsocketService {

    private final ActivityMapper activityMapper;

    public OutputMessageVO updateValidTime(MessageVO msgvo) {
        if (msgvo == null) {
            log.error("MessageVO is null");
            return null;
        }

        if (activityMapper == null) {
            log.error("ActivityMapper is not properly injected");
            return null;
        }

        OutputMessageVO act = activityMapper.getUserActivityWS2(msgvo);
        if (act == null) {
            log.error("ActivityMapper.getUserActivityWS2 returned null");
            return null;
        }

        if (msgvo.getUserid() != null) {
            act.setUserid(msgvo.getUserid());
        }

        return act;
    }
}

