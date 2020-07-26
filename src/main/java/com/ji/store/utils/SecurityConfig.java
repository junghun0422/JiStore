package com.ji.store.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.ji.store.security.AuthFailHandler;
import com.ji.store.security.AuthProvider;
import com.ji.store.security.AuthSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter 
{
	@Autowired
	AuthProvider authProvider;
	
	@Override
	public void configure( WebSecurity web ) throws Exception 
	{
		// static 디렉토리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
//		, "/reportList", "/reportPage", "/reportPagingPage", "/reportListPaging" 
		web.ignoring().antMatchers( "/css/**", "/images/**", "/lib/**", "/join-member", "/checkUser", "/join" );
	}
	
	@Override
	protected void configure( HttpSecurity http ) throws Exception 
	{
		http
			.authorizeRequests()
				.antMatchers( "/member/**", "/inquiry/**" ).access( "hasAnyRole( 'ROLE_ADMIN', 'ROLE_CUSTOMER' )" )
				.antMatchers( "/admin/**" ).access( "hasRole('ROLE_ADMIN')" )
				.antMatchers( "/customer/**" ).access( "hasRole('ROLE_CUSTOMER')" )
				.antMatchers( "/", "/login", "/login-processing", "/logout", "/login-error" ).permitAll()
				.antMatchers( "/**" ).authenticated();
		
		// 로그인
		http.formLogin()
			.loginPage( "/" )
			.loginProcessingUrl( "/login-processing" )
			.failureUrl( "/login-error" )
			.usernameParameter( "user_id" )
			.passwordParameter( "password" )
			.successHandler( new AuthSuccessHandler() )
			.failureHandler( new AuthFailHandler() );
		
		// 로그아웃
		http.logout()
			.logoutRequestMatcher( new AntPathRequestMatcher("/logout") )
			.logoutSuccessUrl( "/" )
			.invalidateHttpSession( true );
		
		http.authenticationProvider( authProvider );
	}
	
}
