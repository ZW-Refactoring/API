package com.zero.admin;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zero.activity.ActivityStateVO;
import com.zero.waste.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

	private final AdminMapper adMapper;

	@Override
	public List<ReportVO> getReportData() {
		return adMapper.getReportData();
	}

	@Override
	public ReportVO getReportById(int repId) {
		return adMapper.getReportById(repId);
	}

	@Override
	public void updateresult(int repId, int repResult) {
		adMapper.updateresult(repId, repResult);
	}

	@Override
	public void updatestate(int stateId, int state) {
		adMapper.updatestate(stateId, state);
	}

	@Override
	public ReportVO updateReport(int repId) {
		return adMapper.updateReport(repId);
	}

	@Transactional
	@Override
	public void updateResultAndState(int repId, int repResult, int stateId, int state) {
		adMapper.updateResultAndState(repId, repResult, stateId, state);
	}

	@Override
	public int initActivityState() {
		return adMapper.initActivityState();
	}

	@Override
	public List<ActivityStateVO> getCtfcList() {
		return adMapper.getCtfcList();
	}

	@Override
	public int approvalActivity(ActivityStateVO asVo) {

		int actId = asVo.getActId();
		int stateId = asVo.getStateId();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startDate = sdf.format(asVo.getStartDate());
		String userid = asVo.getUserid();
		int point;

		int isDailyMission = adMapper.checkMission(actId, startDate, userid);

		int n = adMapper.updateActivityState(stateId);

		if (isDailyMission != 1) {
			point = adMapper.getActivityPoint(actId);
			int u = adMapper.updatePoint(point, userid);
			return u;
		}

		point = adMapper.getActivityPoint(actId)*2;
		int u = adMapper.updatePoint(point, userid);

		return u;
	}

}
