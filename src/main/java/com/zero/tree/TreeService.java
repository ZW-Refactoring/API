package com.zero.tree;

import java.util.List;



public interface TreeService {
	
	int getPointByUserId(String userName);

	int getRankByUserId(String userid);

	List<UserRankVO> getRanksAll();

}
