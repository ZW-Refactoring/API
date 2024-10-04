package com.zero.board;

import com.rometools.rome.io.FeedException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class BoardScheduler {

    private final BoardService boardService;

    //@Scheduled(cron = "0 0 0 1 * ?") // 매달 1일
    //@Scheduled(cron = "0 0/1 * * * *") // 1시간마다 실행
    //@Scheduled(fixedRate = 3600000) // 1시간마다 실행
    @Scheduled(cron = "0 0 10 * * *")
//    @Scheduled(fixedRate = 6000) //   1분마다
    public void fetchBoard() {
        try {
            log.info("뉴스기사 가져옴!!!!!");
            boardService.fetchAndSaveRssFeed();
        } catch (IOException | FeedException e) {
            e.printStackTrace();
        }
    }

}
