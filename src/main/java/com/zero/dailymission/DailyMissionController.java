package com.zero.dailymission;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.zero.activity.ActivityVO;

@Controller
public class DailyMissionController {

    private String getCurrentUserid() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails) principal).getUsername();
        } else {
            return null;
        }

    }

    @Autowired
    private DailyMissionService dailyMissionService;

    // Seed 생성 메서드
    public long generateSeed(String username) {
        // 오늘의 날짜를 기반으로 seed 생성
        Date now = new Date();
        long seedValue = now.getTime();

        // username을 추가하여 seed를 더 고유하게 만듦
        seedValue += username.hashCode();

        return seedValue;
    }

    @GetMapping("/dailymission")
    @Transactional
    public String dailyMissionPage(Model model) {
        String userid = getCurrentUserid();
        if (userid == null) {
            return "redirect:/user/login";
        }
        Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(today);

        // 오늘 날짜의 일일미션이 있는지 체크
        UserDailyMissionVO tmp = new UserDailyMissionVO();
        tmp.setMissionDate(date);
        tmp.setUserid(userid);

        try {
            // 로그인한 회원이 오늘 날짜로 이미 일일미션을 담아왔는지 먼저 체크 (userDailyMission 테이블에서 가져오기)
            List<UserDailyMissionVO> userDailyMission = dailyMissionService.getUserDailyMission(tmp);
            if (userDailyMission == null || userDailyMission.size() == 0) { // 담겨 있지 않다면 랜덤하게 활동리스트 가져오기
                // 활동리스트에서 랜덤한 일일미션 가져오기
                long seed = generateSeed(userid);
                System.out.println("seed값: " + seed);
                List<ActivityVO> missions = dailyMissionService.getDailyMissions(seed);
                if (missions != null && missions.size() == 3) { // 미션이 정확히 3개일 경우에만 처리
                    for (ActivityVO vo : missions) {
                        dailyMissionService.insertUserDailyMission(userid, vo.getActId());
                        // 사용자 일일미션에 저장 ==> 일일미션이 담기게 된다. (userDailyMission 테이블에 저장)
                    }
                    model.addAttribute("missions", missions); // jsp에서 랜덤한 미션 출력할 때 사용
                } else {
                    throw new RuntimeException("미션을 정확히 3개 불러오지 못했습니다.");
                }
            } else {
                // 담겨있다면 해당 actId를 가지고 DailyMission 목록을 가져온다. (기존에 담았던 일일미션이 와야 함)
                List<ActivityVO> dayArr = new ArrayList<ActivityVO>();
                for (UserDailyMissionVO vo : userDailyMission) {
                    ActivityVO mission = dailyMissionService.getDailyMissionsExists(vo.getActId());
                    dayArr.add(mission);
                    // 이미 담긴 사용자의 일일 미션을 jsp에서 출력하기 위해서 미션번호로 dailyMission 테이블에서 미션 내용을 가져옴
                }
                model.addAttribute("missions", dayArr);
            }
        } catch (Exception e) {
            // 예외 발생 시 적절한 조치를 취함 (예: 롤백, 에러 메시지 출력 등)
            e.printStackTrace();
            return "redirect:/error"; // 에러 페이지로 리디렉션
        }
        
        model.addAttribute("userid", userid);
        model.addAttribute("todayDate", date);
        
        return "dailymission/dailymission";
    }
}
