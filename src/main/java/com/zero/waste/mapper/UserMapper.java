package com.zero.waste.mapper;


import org.apache.ibatis.annotations.Mapper;

import com.zero.user.dto.User;
import org.apache.ibatis.annotations.Param;

//create table User (id integer not null auto_increment, createDate datetime(6), email varchar(255), password varchar(255), provider varchar(255), providerId varchar(255), role varchar(255), username varchar(255), primary key (id)) engine=InnoDB
@Mapper
public interface UserMapper {
	void insertUser(User user);

	User findByUsername(String userId);

	void updateUser(User user);

	void delete(User user);

}
