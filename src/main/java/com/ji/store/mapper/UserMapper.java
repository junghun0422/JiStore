package com.ji.store.mapper;

import org.springframework.stereotype.Repository;

import com.ji.store.dto.UserDto;

@Repository( "userMapper" )
public interface UserMapper 
{
	UserDto selectUserById( String user_id );
	
	int insertUser( UserDto userDto );
}
