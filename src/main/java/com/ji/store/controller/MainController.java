package com.ji.store.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ji.store.dto.UserDto;
import com.ji.store.mapper.UserMapper;
import com.ji.store.utils.Constant;
import com.ji.store.utils.CyResult;
import com.ji.store.utils.EncryptUtils;

@Controller
public class MainController 
{
	private static Logger log = LoggerFactory.getLogger( MainController.class );
	
	@Resource( name = "userMapper" )
	private UserMapper userMapper;
	
	@RequestMapping( value = { "/login", "/", "//" } )
	public String login( Model model, HttpServletRequest request, HttpServletResponse response, String loginFail ) throws IOException
	{
		if( "[ROLE_ANONYMOUS]".equals( SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString() ) )
		{	
			if( "true".equals( loginFail ) ) model.addAttribute( "message", "로그인 실패" );
			return "index";
		}
		else return "redirect:/goToMainPage";
	}
	
	@GetMapping("/goToMainPage" )
	public ModelAndView goToMainPage (Model model, Authentication auth, HttpServletResponse response, HttpServletRequest request )
	{
		String returnUrl = "";
		ModelAndView mv = new ModelAndView();

		switch(auth.getAuthorities().toString())
		{
			case "[ROLE_ADMIN]" :  
				returnUrl = "admin/admin_main";
				break;
			case "[ROLE_SELLER]" : 
				returnUrl = "seller/seller_main";
				break;
			case "[ROLE_CUSTOMER]" : 
//				returnUrl = "customer/customer_main";
				returnUrl = "customer/canvas_chart";
				break;
		}
		
		mv.addObject("userInfo", SecurityContextHolder.getContext().getAuthentication().getName());
		mv.setViewName(returnUrl);
		return mv;
	}
	
	@RequestMapping( value = "/join-member", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToJoinPage() 
	{
		return "member_join";
	}
	
	@PostMapping("/checkUser")
	public CyResult<String> checkUser(String user_id)
	{
		CyResult<String> result = new CyResult<String>();
		
		if(userMapper.selectUserById(user_id) != null) result.setCode(Constant.RESULT_FAIL_CODE_03);
		else result.setCode(Constant.RESULT_SUCCESS_CODE);
		
		return result;
	}
	
	@PostMapping("/join")
	public CyResult<String> joinMember(UserDto userDto)
	{
		CyResult<String> result = new CyResult<String>();
		
		String pwd = EncryptUtils.encryptSHA256(userDto.getPwd(), userDto.getUserId().getBytes()).toUpperCase();
		
		// DATABASE 등록
		
		result.setCode(Constant.RESULT_SUCCESS_CODE);
		return result;
	}
}
