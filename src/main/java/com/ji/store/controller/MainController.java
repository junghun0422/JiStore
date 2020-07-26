package com.ji.store.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ji.store.dto.ReportsDto;
import com.ji.store.dto.UserDto;
import com.ji.store.entity.UserEntity;
import com.ji.store.mapper.ReportsMapper;
import com.ji.store.mapper.UserMapper;
import com.ji.store.repository.UserRepository;
import com.ji.store.utils.Constant;
import com.ji.store.utils.CyResult;
import com.ji.store.utils.EncryptUtils;
import com.ji.store.utils.PageUtil;

@Controller
public class MainController 
{
	private static Logger log = LoggerFactory.getLogger( MainController.class );
	
	@Autowired
	private UserRepository userRepository;
	
	@Resource( name = "userMapper" )
	private UserMapper userMapper;
	
	@Resource( name = "reportsMapper" )
	private ReportsMapper reportsMapper;
	
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
	{System.out.println("FASDFADSFASDFASD>... " + auth.getAuthorities().toString());
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
	public @ResponseBody CyResult<Void> checkUser(String user_id)
	{
		CyResult<Void> result = new CyResult<Void>();
		
//		Optional<UserEntity> userEntity = userRepository.findById( user_id );
//		
//		if(userEntity.isPresent())
//		{
//			System.out.println("존재하는 아이디....");
//		}
//		else
//		{
//			log.debug("사용가능한 아이디");
//		}
		
		if( userMapper.selectUserById( user_id ) != null ) result.setCode(Constant.RESULT_FAIL_CODE_03); 
		else result.setCode( Constant.RESULT_SUCCESS_CODE );	

		return result;
	}
	
	@PostMapping("/join")
	public @ResponseBody CyResult<String> joinMember( UserDto userDto )
	{
		CyResult<String> result = new CyResult<String>();
		
		if( StringUtils.isEmpty( userDto.getUser_id() ) || StringUtils.isEmpty( userDto.getPassword() ) )
		{
			result.setCode(Constant.RESULT_FAIL_CODE_01);
			result.setMessage("필수항목이 누락되었습니다.");
			return result;
		}
		
		String pwd = EncryptUtils.encryptSHA256( userDto.getPassword(), userDto.getUser_id().getBytes() ).toUpperCase();
		userDto.setPassword( pwd );

		int val = userMapper.insertUser( userDto );
		
		if(val == 1)
		{
			result.setCode( Constant.RESULT_SUCCESS_CODE );	
			result.setMessage( "회원가입 성공" );
		}
		else 
		{
			result.setCode( Constant.RESULT_FAIL_CODE_03 );	
			result.setMessage( "회원가입 실패, 다시 시도" );			
		}
		
		return result;
	}
	
	@RequestMapping(value="/reportList", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody List<ReportsDto> reportList()
	{
		return reportsMapper.reportsList();
	}
	
	@GetMapping("/reportPage")
	public String reportPage()
	{
		return "reports";
	}
	
	@GetMapping( "/reportPagingPage" )
	public String reportPagingPage()
	{
		return "reportPaging";
	}

	@PostMapping("/reportListPaging")
	public @ResponseBody Map reportsListPaging( @RequestParam( value="page_index", defaultValue="1" ) int page_index ) 
	{
		Map map = new HashMap();
		
		ReportsDto reportsDto = new ReportsDto();

		if( page_index == 1 ) page_index--;
		
		reportsDto.setPage_index( page_index );
		reportsDto.setTotal_cnt( 6 );
		
		int total_cnt = reportsMapper.reportSize();
		PageUtil pageUtil = new PageUtil();
		pageUtil.setPageSize( 6 );
		pageUtil.setPageNo( page_index );
		pageUtil.setBlockSize( 6 );
		pageUtil.setTotalCount( total_cnt );
		
		map.put( "reportPagingList", reportsMapper.selectReportsPaging( reportsDto ) );
		map.put( "page_index", page_index );
		map.put( "paging", pageUtil );
			
		return map;
	}
	
}
