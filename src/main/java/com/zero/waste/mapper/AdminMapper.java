package com.zero.waste.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.zero.activity.ActivityStateVO;
import com.zero.admin.ReportVO;

@Mapper
public interface AdminMapper {

	int initActivityState();
	List<ActivityStateVO> getCtfcList();
	int checkMission(int actId, String startDate, String userid);
	int updateActivityState(int stateId);
	int getActivityPoint(int actId);


	List<ReportVO> getReportData();
	ReportVO getReportById(int repId);
	void updatestate(int stateId, int state);
	void updateresult(int repId, int repResult);
	ReportVO updateReport(int repId);
	void updateResultAndState(int repId, int repResult, int stateId, int state);
	int updatePoint(int point, String userid);
}