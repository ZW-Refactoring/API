package com.zero.waste.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.zero.tree.UserRankVO;



@Mapper
public interface TreeMapper {
	int getPointByUserId(String userid);

	int getRankByUserId(String userid);

	List<UserRankVO> getRanksAll();
}
