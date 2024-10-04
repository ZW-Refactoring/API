package com.zero.waste;

import com.rometools.rome.io.FeedException;
import com.zero.board.BoardService;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.IOException;
@EnableScheduling
@SpringBootApplication
@ComponentScan(basePackages = {"com"})
@MapperScan(basePackages = {"com.zero.waste.mapper"})
public class FinalProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinalProjectApplication.class, args);
	}

}
