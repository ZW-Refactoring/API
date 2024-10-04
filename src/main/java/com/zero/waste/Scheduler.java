package com.zero.waste;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.zero.activity.ActivityStateVO;
import com.zero.admin.AdminService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class Scheduler {
	
	private final AdminService adService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void initActivityState(){
		
			int n = adService.initActivityState();
			//예외처리 할 것
	}
	
	@Scheduled(cron = "10 * * * * * ")
	public void autoCtfcActivity() {
		List<ActivityStateVO> ctfcList = adService.getCtfcList();
		
		for(ActivityStateVO asVo:ctfcList) {
			int i = adService.approvalActivity(asVo);	
		}
	}
}
