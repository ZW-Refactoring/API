package com.zero.waste.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.zero.activity.ActivityVO;
import com.zero.dailymission.UserDailyMissionVO;

@Mapper
public interface DailyMissionMapper {

    List<Integer> getExcludedActivityNos(String userid);

    List<Integer> getRandomActivityNos(@Param("userid") String userid, @Param("excludedActNos") List<Integer> excludedActNos);

    List<ActivityVO> getDailyMissions(long seed);

	int insertUserDailyMission(Map<String, Object> map);

	List<UserDailyMissionVO> getUserDailyMission(UserDailyMissionVO tmp);

	ActivityVO getDailyMissionsExists(int actId);
	
	ActivityVO getTodayMissionByUserId(String userid, String missionDate);
}
