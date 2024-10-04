package com.zero.waste.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.zero.activity.ActivityStateVO;
import com.zero.activity.ActivityVO;
import com.zero.activity.UserActDTO;
import com.zero.activity.UserReportVO;
import com.zero.user.dto.UserBookmarkVO;
import com.zero.websocket.MessageVO;
import com.zero.websocket.OutputMessageVO;

@Mapper
public interface ActivityMapper {

	List<ActivityVO> getActivityAll();
	List<String> getCategoryAll();
	List<ActivityVO>getActivityCtgr(String ctgr);
	List<ActivityStateVO>getUserActivity(String userid);
	int startActivity(int actId, String userid);
	int ctfcActivity(ActivityStateVO asVo);
	int addBookmark(String userid, int actId);
	int removeBookmark(String userid, int actId);
	int getActivityPoint(int actId);
	void updatePoint(int point, String userid);
	List<ActivityStateVO> getStsAll(int actId);
	UserReportVO findRep(int stsId);
	//	void updateRep(int stsId);
	void insertRep(UserReportVO repVo);
	UserReportVO findByuseridAndstsId(String userid, int stsId);
	int checkActState(int actId, String userid);
	int cancleActivity(int actId, String userid);
	List<UserActDTO> getUserActState(String userid);
	boolean isBookmarked(String userid, int actId);
	List<UserReportVO> getAllReports();
	int saveReportResult(int repId, int repResult);
	ActivityStateVO getStsByStateId(int stateId);
	
	//추가
	OutputMessageVO getUserActivityWS2(MessageVO msgvo);
	List<String> getStateAll();
	List<ActivityStateVO> getActivityState(Map<String, String> params);
	List<UserBookmarkVO> getUserBookmarkList(String userid);
	HashMap<String, Object> getStateCount(int actno);


}

