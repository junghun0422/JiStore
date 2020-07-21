package com.ji.store.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.ji.store.dto.UserDto;

@Component( "authProvider" )
public class AuthProvider implements AuthenticationProvider
{
	@Autowired
	AuthorizationService authorizationService;
	
	@Override
	public Authentication authenticate( Authentication authentication ) throws AuthenticationException 
	{
		String user_id = authentication.getName();
		String password = authentication.getCredentials().toString();
		return authenticate( user_id, password );
	}
	
	public Authentication authenticate( String user_id, String password ) throws AuthenticationException
	{
		UserDto user = authorizationService.login( user_id, password );
		
		if(user == null) { throw new BadCredentialsException( "Not Found UserInfo" ); }
		
		List<GrantedAuthority> grantedAuthorityList = new ArrayList<GrantedAuthority>();
		
		String role = "";
		switch( user.getAuth_level() )
		{
			case 0 :
				role = "ROLE_ADMIN";
				break;
			case 1 :
				role = "ROLE_SELLER";
				break;
			case 2 :
				role = "ROLE_CUSTOMER";
				break;
		}
		
		grantedAuthorityList.add( new SimpleGrantedAuthority( role ) );
		return new MyAuthentication( user_id, password, grantedAuthorityList, user );
	}
	

	@Override
	public boolean supports(Class<?> authentication) 
	{
		return authentication.equals( UsernamePasswordAuthenticationToken.class );
	}
}
