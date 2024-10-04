package com.zero.common.util;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class CommonUtil {
	
	public String addMsgLoc(Model m, String msg, String loc) {
		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
	public String addMsgBack(Model m, String msg) {
		m.addAttribute("msg", msg);
		m.addAttribute("loc", "javascript:history.back()");
		
		return "message";
	}
	
	public String addMsgPopup(Model m, String msg) {
		m.addAttribute("msg", msg);
		m.addAttribute("mode", "popup");
		
		return "message";
	}
	
	public String getCurrentUsername() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails)principal).getUsername();
        } else {
            return null;
        }
    }
}
