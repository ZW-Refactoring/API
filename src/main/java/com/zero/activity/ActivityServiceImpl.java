package com.zero.activity;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.zero.user.dto.UserBookmarkVO;
import com.zero.waste.mapper.ActivityMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ActivityServiceImpl implements ActivityService {
    
	

	private final SqlSession sqlSession;
    private final ActivityMapper aMapper;
    
    @Override
    public List<ActivityVO> getActivityAll() {
        return aMapper.getActivityAll();
    }

    @Override
    public List<String> getCategoryAll() {
        return aMapper.getCategoryAll();
    }
    
    @Override
    public List<ActivityVO> getActivityCtgr(String ctgr) {
        return aMapper.getActivityCtgr(ctgr);
    }
    
    @Override
    public int startActivity(int actno, String userid) {
        return aMapper.startActivity(actno, userid);
    }

    @Override

    public int ctfcActivity(ActivityStateVO asVo) {
        return aMapper.ctfcActivity(asVo);
    }

	@Override
	public List<ActivityStateVO> getUserActivity(String userid) {
		return aMapper.getUserActivity(userid);
	}

	@Override
	public int checkActState(int actno, String username) {
		return aMapper.checkActState(actno, username);
	}

	@Override
	public int cancleActivity(int actno, String username) {
		return aMapper.cancleActivity(actno, username);
	};
    
    @Override
    public int addBookmark(String userid, int actNo) {
       return aMapper.addBookmark(userid, actNo);
    }
    
    @Override
    public int removeBookmark(String userid, int actNo) {
    	return aMapper.removeBookmark(userid, actNo);
    }

	@Override
	public int getActivityPoint(int actno) {
		return aMapper.getActivityPoint(actno);
	}

	@Override
	public void updatePoint(int point, String username) {
		aMapper.updatePoint(point, username);
	}

	@Override
	public List<ActivityStateVO> getStsAll(int actno) {
		return aMapper.getStsAll(actno);
	}

	@Override
	public ActivityStateVO getStsByStateId(int stateId){
		return aMapper.getStsByStateId(stateId);
	}
	
	// 신고

	@Override
	public UserReportVO findRep(int stsNo) {
		return aMapper.findRep(stsNo);
	}

//	@Override
//	public void updateRep(int stsNo, String username) {
//		// 중복 신고 방지
//		if (!isAlreadyReported(stsNo, username)) {
//		aMapper.updateRep(stsNo);
//		}
//	}

	@Override
	public void insertRep(UserReportVO repVo) {
		aMapper.insertRep(repVo);
	}

	@Override
	public boolean isAlreadyReported(int stsId, String userid) {
		// 해당 사용자가 이미 해당 항목을 신고했는지 확인
		UserReportVO report = aMapper.findByuseridAndstsId(userid, stsId);
		return report != null;
	}

	@Override
	public List<ActivityVO> getRandomActivities(int count) {
		List<ActivityVO> allActivities = aMapper.getActivityAll();
		Collections.shuffle(allActivities);
		return allActivities.subList(0, Math.min(count, allActivities.size()));
	}

	@Override
	public List<ActivityVO> getActivitiesByActNoList(String actNoList) {
		return sqlSession.selectList("com.zero.waste.mapper.ActivityMapper.getActivitiesByActNoList", actNoList);
	}

	@Override
	public List<UserActDTO> getUserActState(String username) {
		return aMapper.getUserActState(username);
	}

	@Override
	public List<UserReportVO> getAllReports() {
	    return aMapper.getAllReports();
	}

	@Override
	public int saveReportResult(int repNo, int repResult) {
		return aMapper.saveReportResult(repNo, repResult);
	}

	@Override
	public List<String> getStateAll() {
		return aMapper.getStateAll();
	}

	@Override
	public List<ActivityStateVO> getActivityState(String username, String ctgr) {
		Map<String, String> params = new HashMap<>();
        params.put("ctgr", ctgr);
        params.put("userid", username);
		return aMapper.getActivityState(params);
	}

	@Override
	public List<UserBookmarkVO> getUserBookmarkList(String username) {
		return aMapper.getUserBookmarkList(username);
	}

	@Override
	public HashMap<String, Object> getStateCount(int actno) {
		return aMapper.getStateCount(actno);
	}

}

