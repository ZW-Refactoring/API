package com.zero.admin;

import java.util.Date;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	private final AdminService adService;

	@GetMapping("")
	public String getAdmin() {
		return "/admin/admin";
	}
	
	@GetMapping("/reportform")
	public String getReportData(Model m) {
		List<ReportVO> reports = adService.getReportData();
		m.addAttribute("reports", reports);
		return "admin/reportform";
	}

	@GetMapping("/reportdetail")
	public String getReportById(@RequestParam("repId") int repId, Model m) {
		ReportVO report = adService.getReportById(repId);
		m.addAttribute("report", report);
		return "admin/reportdetail";
	}

	@PostMapping("/reportdetail/saveReportResult")
	public String saveReportResultRep(@RequestParam("repId") int repId, @RequestParam("repResult") int repResult,
	        @RequestParam("state") int state, @RequestParam int stateId, Model m) {

	        // 업데이트 수행
        adService.updateResultAndState(repId, repResult, stateId, state);


	        // 변경된 신고 정보를 다시 가져옴
	        ReportVO report = adService.getReportById(repId);

	        System.out.println(report);
	        
	        if (report != null) {
	            m.addAttribute("report", report);
	        } else {
	            m.addAttribute("error", "Report not found.");
	        }

	        return "redirect:/reportdetail?repId=" + repId;

	 
	}
}