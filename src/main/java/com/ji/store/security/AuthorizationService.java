package com.ji.store.security;

import javax.annotation.Resource;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;

import com.ji.store.dto.UserDto;
import com.ji.store.mapper.UserMapper;
import com.ji.store.utils.EncryptUtils;

@Service
public class AuthorizationService 
{
	@Resource( name = "userMapper" )
	private UserMapper userMapper;
	
	public UserDto login( String userId, String pwd )
	{
		UserDto user = userMapper.selectUserById( userId );
		
		if(user != null)
		{
			String input_pwd = EncryptUtils.encryptSHA256(pwd, userId.getBytes()).toUpperCase();
			
			if(user.getPwd().equals(input_pwd)) 
			{
				return user;
			}
		}
		
		throw new BadCredentialsException( "Not Found UserInfo...." );
	}
}
