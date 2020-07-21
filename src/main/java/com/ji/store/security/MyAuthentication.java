package com.ji.store.security;

import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import com.ji.store.dto.UserDto;

public class MyAuthentication extends UsernamePasswordAuthenticationToken 
{
	UserDto user;
	
	public MyAuthentication( String userId, String pwd, List<GrantedAuthority> grantedAuthorityList, UserDto user )
	{
		super( userId, pwd, grantedAuthorityList );
		this.user = user;
	}

}
