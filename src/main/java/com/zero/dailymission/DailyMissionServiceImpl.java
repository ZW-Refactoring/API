package com.zero.dailymission;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zero.activity.ActivityVO;
import com.zero.waste.mapper.DailyMissionMapper;

@Service
public class DailyMissionServiceImpl implements DailyMissionService {

    @Autowired
    private DailyMissionMapper dailyMissionMapper;

    @Override
    @Transactional
    public List<ActivityVO> getDailyMissions(long seed) {
        return dailyMissionMapper.getDailyMissions(seed);
    }

    @Override
    @Transactional
    public int insertUserDailyMission(String username, int actId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userid", username);
        map.put("actId", actId);
        return dailyMissionMapper.insertUserDailyMission(map);
    }

    @Override
    @Transactional
    public List<UserDailyMissionVO> getUserDailyMission(UserDailyMissionVO tmp) {
        return dailyMissionMapper.getUserDailyMission(tmp);
    }

    @Override
    @Transactional
    public ActivityVO getDailyMissionsExists(int actNo) {
        return dailyMissionMapper.getDailyMissionsExists(actNo);
    }

    @Override
    @Transactional
    public ActivityVO getTodayMissionByUserId(String userName, String sdate) {
        return dailyMissionMapper.getTodayMissionByUserId(userName, sdate);
    }
}
