
package com.zero.dailymission;

import java.util.List;

import com.zero.activity.ActivityVO;

public interface DailyMissionService {
    List<ActivityVO> getDailyMissions(long seed);

	int insertUserDailyMission(String username, int missionNo);

	List<UserDailyMissionVO> getUserDailyMission(UserDailyMissionVO tmp);

	ActivityVO getDailyMissionsExists(int missionNo);
	
	ActivityVO getTodayMissionByUserId(String userName, String sdate);
}