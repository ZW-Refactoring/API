package com.zero.waste;

import com.zero.board.Board;
import com.zero.board.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

import java.util.List;
@Slf4j
@Controller // Controller 등록
@RequiredArgsConstructor //lombok, final 생성자 자동 생성
public class HomeController {

	private final BoardService boardService;
	
	@RequestMapping("/")
	public String test(Model model) {
		List<Board> listLimit = boardService.getListLimit();
		model.addAttribute("list", listLimit);
		return "index";
	}
}
