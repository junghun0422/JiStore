package com.ji.store.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class AuthSuccessHandler implements AuthenticationSuccessHandler 
{

	@Override
	public void onAuthenticationSuccess( HttpServletRequest request, HttpServletResponse response, Authentication authentication ) throws IOException, ServletException 
	{
		System.out.println("onAuthenticationSuccess :: " + authentication.getName());
	
		request.getSession().setMaxInactiveInterval(60*60); //	1시간
		response.sendRedirect("/goToMainPage");		// 로그인 성공 후 리턴할 API
	}
}
