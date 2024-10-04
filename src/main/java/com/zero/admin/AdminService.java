package com.zero.admin;

import java.util.List;

import com.zero.activity.ActivityStateVO;

public interface AdminService {
	
	//매일 자정 상태가 진행중(state=1)인 활동을 수행시간 만료 처리합니다.
	int initActivityState();
	
	//인증처리 대상(48시간 경과 & 신고내역 x)인 활동목록들을 가져옵니다. 
	List<ActivityStateVO> getCtfcList();
	
	//승인처리와 포인트 지급
	int approvalActivity(ActivityStateVO asVo);
	
	List<ReportVO> getReportData();
	ReportVO getReportById(int repId);
	void updateresult(int repId, int repResult);
	void updatestate(int stateId, int state);
	ReportVO updateReport(int repId);
	void updateResultAndState(int repId, int repResult, int stateId, int state);
}
