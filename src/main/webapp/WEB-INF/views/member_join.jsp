<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	html 
	{
		height: 100%;
	}
	body
	{
		background-image: url(http://getwallpapers.com/wallpaper/full/a/5/d/544750.jpg);
	    background-size: cover;
	    background-repeat: no-repeat;
	    height: 100%;
	    font-family: 'Numans', sans-serif;
	}
	
	.container
	{
		display	:	flex;
		height	:	100%;
	}
	
	.bg-light
	{
		width				:	500px;
		background-color	:	rgba(0,0,0,0.5) !important;
		margin				:	auto;
	}
	
	.container h4
	{
		color	:	white;
		font-weight	:	bold;
		margin-bottom: 1.75rem;
	}
	
	.input-group-prepend span 
	{
    	width: 50px;
	    background-color: #FFC312;
	    color: black;
	    border: 0 !important;
	}
	
	.input-group>.form-control
	{
		width	:	310px;
	}
	
	.btn-block
	{
		width			:	150px;
		color			:	white;
		font-weight		:	bold;
		margin-left		:	auto;
		margin-right	:	auto;
	}
</style>
</head>
<body>
	<div class="container">
		<div class="card bg-light" >
			<article class="card-body mx-auto" style="max-width: 400px;">
				<h4 class="card-title mt-3 text-center">회원 가입</h4>
				<div class="form-group input-group">
					<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-user"></i> </span>
				 	</div>
				 	<span><input name="user_id" id="user_id" class="form-control" placeholder="아이디" type="text" style="width:250px;"></span>
				 	<span><button id="checkBtn" class="btn btn-danger" style="margin-left:3px;">중복</button></span>
		    	</div> <!-- form-group// -->
				<div class="form-group input-group">
					<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa"></i> </span>
				 	</div>
				 	<input name="user_nm" id="user_nm" class="form-control" placeholder="이름" type="text">
		    	</div> <!-- form-group// -->
				<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-lock"></i> </span>
					</div>
		        	<input name="pwd1" id="pwd1" class="form-control" placeholder="비밀번호" type="password" required >
		    	</div> <!-- form-group// -->
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa"></i> </span>
					</div>
		        	<input name="pwd2" id="pwd2" class="form-control" placeholder="비밀번호 확인" type="password" required>
		        	<div class="alert alert-success" id="alert-success" style="display:none;">비밀번호가 일치합니다.</div>
		        	<div class="alert alert-danger" id="alert-danger" style="display:none;">비밀번호가 일치하지 않습니다.</div>
		    	</div> <!-- form-group// -->
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
				 	</div>
		        	<input name="email" id="email" class="form-control" placeholder="이메일" type="email">
		    	</div> <!-- form-group// -->
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-phone"></i> </span>
					</div>
		    		<input name="phone_num" id="phone_num" class="form-control" placeholder="휴대폰 번호" type="text">
		    	</div> <!-- form-group// -->
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-building"></i> </span>
					</div>
					<select id="user_type" name="user_type" class="form-control">
						<option selected value="1">판매자</option>
						<option value="2">고객</option>
					</select>
				</div>
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-shipping-fast"></i> </span>
					</div>
					<input type="text" class="form-control" name="zip_code" placeholder="우편번호 찾기" id="zip_code" readonly="readonly" style="cursor:pointer;">
				</div>				
		    	<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa fa-map-marker-alt"></i> </span>
					</div>
					<input type="text" class="form-control" placeholder="주소를 검색해주세요" id="address1" readonly="readonly" style="cursor:pointer;">
				</div> 
				<div class="form-group input-group">
		    		<div class="input-group-prepend">
				    	<span class="input-group-text"> <i class="fa"></i> </span>
					</div>
					<input type="text" class="form-control" placeholder="상세주소" id="address2">
				</div>
				<!-- form-group end.// -->
	                                      
		    	<div class="form-group">
		        	<button class="btn btn-warning btn-block" id="joinBtn"> 가입하기  </button>
		    	</div> <!-- form-group// -->                                                                 
			</article>
		</div> <!-- card.// -->
	</div> 
	<!--container end.//-->
</body>
<script>
	var check = false;
	$("#checkBtn").click(function() 
	{
		if($("#user_id").val() == "") 
		{
			alert("아이디를 입력해주세요."); 
			return;
		}

		$.ajax({
			url			:	"/checkUser",
			type		:	"post",
			datatype	:	"json",
			data		:	{ "user_id" : $("#user_id").val() },
			success		:	function(responseData)
			{	
				if("00" == responseData.code) 
				{
					check = true;
					alert("사용가능한 아이디입니다.");
				}
				else alert("다른 아이디를 입력해주세요.");
			},
			error		:	function(request, status, error)
			{
				console.log(request.status);
				console.log(request.responseText);
				console.log(error);
 			}
		});
	});

	$("#joinBtn").click(function () 
	{	
		if(!check) 
		{
			alert("아이디 중복확인을 해주세요.");
			return;
		}
		
		var param = 
		{
			"user_id"	:	$("#user_id").val(),
			"user_nm"	:	$("#user_nm").val(),
			"password"	:	$("#pwd1").val(),
			"email"		:	$("#email").val(),
			"auth_level":	$("select[name=user_type]").val(),
			"zip_code"	:	$("#zip_code").val(),
			"phone_num"	:	$("#phone_num").val(),
			"address"	:	$("#address1").val(),
			"detail_address"	:	$("#address2").val()
		};

		console.log(JSON.stringify(param));
		
		$.ajax({
			url			:	"/join",
			type		:	"post",
			datatype	:	"json",
			data		:	param,
			success		:	function(responseData)
			{
				if("00" == responseData.code)
				{
					alert("가입에 성공하셨습니다.\n로그인 페이지로 이동합니다.");
					location.replace("/");
				}
			},
			error:function(request,status,error)
			{
				console.log(request.status);
				console.log(request.responseText);
				console.log(error);
 			}
		});
	});

	$("#pwd1, #pwd2").keyup(function() 
	{
		var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();

		if(pwd1 != "" || pwd2 != "")
		{
			if(pwd1 == pwd2)
			{
				$("#alert-success").show();
				$("#alert-danger").hide();
			}
			else
			{
				$("#alert-danger").show();
				$("#alert-success").hide();
			}
		}
	});

	$("#zip_code, #address1").click(function() 
	{
		new daum.Postcode(
		{
			oncomplete:function(data) 
			{
				$("#zip_code").val(data.zonecode);
				$("#address1").val(data.roadAddress);
			}
		})
		.open({
			left	:	(window.screen.width/2) - (500/2),
			top		:	(window.screen.height/2) - (600/2)
		});
	});
</script>
</html>