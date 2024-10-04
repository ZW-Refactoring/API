
package com.zero.activity;

import java.util.HashMap;
import java.util.List;

import com.zero.user.dto.UserBookmarkVO;
import com.zero.websocket.MessageVO;
import com.zero.websocket.OutputMessageVO;

public interface ActivityService {
	
	List<ActivityVO> getActivityAll();
	List<String> getCategoryAll();
	List<ActivityVO> getActivityCtgr(String ctgr);
	
	List<ActivityVO> getRandomActivities(int count);
	List<ActivityVO> getActivitiesByActNoList(String actNoList);
	
	int startActivity(int actno, String userid);
	int ctfcActivity(ActivityStateVO asVo);


	int getActivityPoint(int actno);
	void updatePoint(int point, String username);
	ActivityStateVO getStsByStateId(int stateId);
	List<ActivityStateVO> getStsAll(int actno);
	UserReportVO findRep(int stsNo);
	void insertRep(UserReportVO repVo);
	boolean isAlreadyReported(int stsId, String username);

	int addBookmark(String userid, int actNo);
	int removeBookmark(String userid, int actNo);
	List<ActivityStateVO> getUserActivity(String userid);
	int checkActState(int actno, String username);
	int cancleActivity(int actno, String username);
	List<UserActDTO> getUserActState(String username);
	List<UserReportVO> getAllReports();
	int saveReportResult(int repNo, int repResult);
	
	//추가
	List<String> getStateAll();
	List<ActivityStateVO> getActivityState(String username, String ctgr);
	List<UserBookmarkVO> getUserBookmarkList(String username);
	HashMap<String, Object> getStateCount(int actno);
}

