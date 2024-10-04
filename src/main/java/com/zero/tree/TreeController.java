package com.zero.tree;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.zero.activity.ActivityVO;
import com.zero.common.util.CommonUtil;
import com.zero.user.auth.PrincipalDetails;
import com.zero.user.dto.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class TreeController<ActivityVO> {
	private final TreeService treeService;
	private final CommonUtil util;

	@GetMapping("/tree")
	public String tree(Model model, Authentication authentication) {
		if (authentication == null) {
			return "/user/loginForm";
		}
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String userid = userDetails.getUsername();

		// userid로 point 가져오기
		int userpoint = treeService.getPointByUserId(userid);
		int score = treeService.getPointByUserId(userid);
		int reward = userpoint / 5500; //배지 수
		userpoint -= (5500 * reward); //배지 획득으로 인한 포인트는 소멸되고 새로 쌓는 포인트
		int[] upPoint = {400, 600, 800, 1000, 1200, 1500};
		//레벨이 오르는 데 필요한 포인트(jsp에서 계산식에 사용됨)
		
		int point = userpoint;
		int level = 0;

		if (userpoint < 400) {
			level = 1;
		} else if (userpoint < 1000) {
			level = 2;
			point -= 400;
		} else if (userpoint < 1800) {
			level = 3;
			point -= 1000;
		} else if (userpoint < 2800) {
			level = 4;
			point -= 1800;
		} else if (userpoint < 4000) {
			level = 5;
			point -= 2800;
		} else if (userpoint < 5500) {
			level = 6;
			point -= 4000;
		} else {
			level = 1; //5500포인트가 되면 레벨이 1로 초기화된다.
			point = 0; //새로 쌓는 포인트는 0포인트로 리셋된다.
		}
		
		//userid로 랭킹 가져오기
		int rank = treeService.getRankByUserId(userid);
		
		model.addAttribute("userid", userid);
		model.addAttribute("upPoint", upPoint);
		model.addAttribute("point", point);
		model.addAttribute("level", level);
		model.addAttribute("reward", reward);
		model.addAttribute("userpoint", userpoint);
		model.addAttribute("score", score);
		model.addAttribute("rank", rank);
		return "tree/tree";
		
	}
	
	@GetMapping("user/myrank")
	public String myrank(Model model) {
		
		String userid = util.getCurrentUsername();
		
		int score = treeService.getPointByUserId(userid);
		int rank = treeService.getRankByUserId(userid);
		
		//전체 유저 랭킹 보여주기
		List<UserRankVO> rankList = treeService.getRanksAll();
		
		model.addAttribute("userid", userid);
		model.addAttribute("score", score);
		model.addAttribute("rank", rank);
		model.addAttribute("rankList", rankList);
		
		return "user/myrank";
	}

}