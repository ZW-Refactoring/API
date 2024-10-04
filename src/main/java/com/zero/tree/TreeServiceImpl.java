package com.zero.tree;



import java.util.List;

import org.springframework.stereotype.Service;


import com.zero.waste.mapper.TreeMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TreeServiceImpl implements TreeService {
	private final TreeMapper treeMapper;


	@Override
	public int getPointByUserId(String userName) {
		return treeMapper.getPointByUserId(userName);
	}


	@Override
	public int getRankByUserId(String userid) {
		return treeMapper.getRankByUserId(userid);
	}


	@Override
	public List<UserRankVO> getRanksAll() {
		return treeMapper.getRanksAll();
	}

}
