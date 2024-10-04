package com.zero.activity;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zero.common.util.CommonUtil;
import com.zero.user.auth.PrincipalDetails;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ActivityController {

	private final CommonUtil util;
	private final ActivityService aService;
	private final ResourceLoader resourceLoader;

	
	@GetMapping("/actList")
	public String activityList(Model m) {

		List<String> ctgrList = aService.getCategoryAll();
		List<ActivityVO> actList = aService.getActivityAll();

		String username = util.getCurrentUsername();
		if (username != null) {
			List<UserActDTO> userActList = aService.getUserActState(username);
			m.addAttribute("userActList", userActList);
		}
		
		m.addAttribute("ctgrList", ctgrList);
		m.addAttribute("actList", actList);

		return "activity/activityList";
	}

	@PostMapping(value = "/selectctgr", produces = { "application/json; charset=utf-8" })
	@ResponseBody
	public List<ActivityVO> selectCategory(@RequestParam("ctgr") String ctgr) {
		List<ActivityVO> actList;

		if (ctgr.equals("all")) {
			actList = aService.getActivityAll();
		}

		else {
			actList = aService.getActivityCtgr(ctgr);
		}
		return actList;
	}


	@GetMapping(value = "/actDetail/{actNo}")
	public String actDetail(@PathVariable String actNo, Model m, Authentication authentication) {
		List<String> ctgrList = aService.getCategoryAll();
		List<ActivityVO> actList = aService.getActivityAll();
		
		if (authentication != null) {
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
			String username = userDetails.getUsername();
			List<UserActDTO> userActList = aService.getUserActState(username);
			m.addAttribute("userActList", userActList);
		}
		m.addAttribute("ctgrList", ctgrList);
		m.addAttribute("actList", actList);
		m.addAttribute("actNo", actNo);
		
		return "activity/activityList";
	}

	@GetMapping("/activity/actStart")
	public String actStart(Model m, @RequestParam("actno") int actno, HttpSession session, Authentication authentication) {
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		String msg = "";
		String loc = "/actDetail/"+actno;
		int state = aService.checkActState(actno, username);
		if (state != 0) {
			msg = "이미 수행중인 활동입니다.";
			util.addMsgLoc(m, msg, loc);
		} else {
			int n = aService.startActivity(actno, username);
			List<UserActDTO> userActList = aService.getUserActState(username);
			session.setAttribute("userActList", userActList);
			msg = "활동을 시작합니다.";
			util.addMsgLoc(m, msg, loc);
			}
		return "message";
	}

	@GetMapping("/activity/actCtfcForm")
	public String actCtfcForm(@RequestParam("actno") int actno) {
		return "/activity/actCtfcForm";
	}

	@PostMapping("/activity/actCtfc")
	@ResponseBody
	public String actCtfc(@RequestParam("actNo") int actno, @RequestParam("imgFile") MultipartFile mfilename,
			HttpSession ses) {
		
		String upDir = ses.getServletContext().getRealPath("/resources/upload");
		String fname = mfilename.getOriginalFilename();
		File file = new File(upDir, fname);

		String username = util.getCurrentUsername();
		ActivityStateVO asVo = new ActivityStateVO();
		asVo.setActId(actno);
		asVo.setUserid(username);
		asVo.setCtfcFilename(fname);
		try {
			mfilename.transferTo(file);// 업로드 처리
			int n = aService.ctfcActivity(asVo);
			return "인증 신청 완료";
		} catch (Exception e) {
			return "업로드 실패";
		}
	}

	@GetMapping("/activity/addBookmark")
	@ResponseBody
	public String addBookmark(@RequestParam("actNo") int actNo, Authentication authentication, HttpSession session) {
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		int n = aService.addBookmark(username, actNo);
		if (n > 0) {
			List<UserActDTO> userActList = aService.getUserActState(username);
			session.setAttribute("userActList", userActList);
			return "즐겨찾기에 추가 완료했습니다.";
		} else {
			return "즐겨찾기 추가에 실패했습니다.";
		}
	}

	@GetMapping("/activity/removeBookmark")
	@ResponseBody
	public String removeBookmark(@RequestParam("actNo") int actNo, Authentication authentication, HttpSession session) {
		PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
		String username = userDetails.getUsername();
		int n = aService.removeBookmark(username, actNo);
		if (n > 0) {
			List<UserActDTO> userActList = aService.getUserActState(username);
			session.setAttribute("userActList", userActList);
			return "즐겨찾기가 삭제되었습니다.";
		} else {
			return "즐겨찾기 삭제를 실패했습니다.";
		}
	}

	@GetMapping("/actSts/{actNo}")
	@ResponseBody
	public HashMap<String,Object> actSts(@PathVariable("actNo") int actno) {
		
		HashMap<String,Object> stateCount = aService.getStateCount(actno);
		List<ActivityStateVO> stsList = aService.getStsAll(actno);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("ing",stateCount.get("ing"));
		map.put("end",stateCount.get("end"));
		map.put("stsList", stsList);
		
		return map;
	}

	@GetMapping("/activity/actReportForm")
	public String actReportForm(Model m, @RequestParam("stsId") int stsId) {
		ActivityStateVO data = aService.getStsByStateId(stsId);
		
		if(data.getUserid().equals(util.getCurrentUsername())) {
			String msg="본인의 글은 신고할 수 없습니다.";
			m.addAttribute("mode","popup");
			return util.addMsgBack(m, msg);
		}
		
		m.addAttribute("data", data);
		return "/activity/actReportForm";
	}
	
	@PostMapping("/activity/actReport")
	@ResponseBody
	public String reportStatus(@RequestParam int stsId, @RequestParam String reason) {
		UserReportVO repVo = new UserReportVO();
		repVo.setStsId(stsId);
		repVo.setReason(reason);
		
		String username = util.getCurrentUsername();
		
		boolean isAlreadyReported = aService.isAlreadyReported(stsId,username);
		if (isAlreadyReported) {
			// 이미 신고한 경우 오류 응답 반환
			return "이미 신고한 글입니다.";
		}

		repVo.setReporter(username);
		aService.insertRep(repVo);
		return "신고가 접수되었습니다.";
	}



}

