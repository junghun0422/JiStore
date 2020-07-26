<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	#table
	{
		text-align : center;
		width : 300px;
	}
	
	#table_wrapper 
	{
		margin-left: 210px;
		margin-top : 10px;
	}
	
	#table_paginate
	{
		text-align : center;
	}
</style>

<!-- DataTables CSS -->
<link href="/_admin/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
<!-- DataTables Responsive CSS -->
<link href="/_admin/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
<!-- drag CSS -->
<!-- <link rel="stylesheet" type="text/css" media="all" href="/_admin/drag/styles.css"> -->
   
<!-- ckeditor JavaScript -->
<!-- <script src="https://cdn.ckeditor.com/4.8.0/standard-all/ckeditor.js"></script> -->
<script src="/_admin/ckeditor.js"></script>
<script src="/js/jquery-1.9.1.js"></script>
</head>
<body>
<div id="btnDiv" style="margin-left:200px;"></div>
<div id="noticeDiv" style="margin-left:200px; display:none;">
	<form id='noticeForm' name='noticeForm'>
		<table style="margin-top:15px; cursor:pointer;">
			<tr>
				<td>제목 : </td>
				<td><input type="text" id="title" name="title" style="width:406px;"></td>
			</tr>
			<tr>
				<td colspan="2"><!-- filedrag -->
					<div id="check"><textarea class="form-control" rows="20" id="notice_content" name="notice_content"></textarea></div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button class='btn btn-default' onclick='cancel();'>취소</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="등록" onclick="writeNotice();" style="cursor:pointer;" class="btn btn-default"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="tableDiv"></div>

    <!-- jQuery -->
    <script src="/_admin/vendor/jquery/jquery.min.js"></script>
    
    <!-- Bootstrap Core JavaScript -->
    <script src="/_admin/vendor/bootstrap/js/bootstrap.min.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="/_admin/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/_admin/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/_admin/vendor/datatables-responsive/dataTables.responsive.js"></script>
    
    <script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction('${CKEditorFuncNum}', '${filePath}', '${message}');
	var beforeKey, debug_mode = false;
	$(document).ready(function() {
		// 공지 목록 그리기
		noticeList();
		
		editor = CKEDITOR.replace("notice_content", {
 			extraPlugins : 'uploadwidget,notificationaggregator,filetools,uploadimage,notification,widget,lineutils,widgetselection,imageresizerowandcolumn',
			width :	'472px',
			height : '700px',
			enterMode : CKEDITOR.ENTER_BR,
			uploadUrl : '/admin/ImageUpload.do',
			resize_enabled : false,
			toolbar : 
			[
			 	['Font', 'FontSize'],
			 	['BGColor', 'TextColor'],
				['Bold','Italic','Strike', 'Underline'],
				['Maximize', 'Preview'],
				'/',
				['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
				['NumberedList','BulletedList','-','Outdent','Indent'],
				['Table','HorizontalRule', 'SpecialChar'],
			 	['Undo','Redo']
			]
		});
		
		editor.on('fileUploadResponse', function(evt) {
			$(".cke_notifications_area").remove();			// 잘못된 응답 창 제거
			var fileLoader = evt.data.fileLoader,
				xhr = fileLoader.xhr,
				data = evt.data;
		
				var array = xhr.responseText.split(",");	
			
				$("#iframe").ready(function() {
					var requestUrl = array[1].replace(/'/gi, "");
					var src = requestUrl.substring(0,requestUrl.indexOf("?", 0));			
					var _img = document.createElement('img');
					_img.src = src;
					
					_img.onload = function() {
						var w = this.width;
						var h = this.height;

						if(w == h)			// 넓이 == 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 200);
						}
						else if(w > h)		// 넗이 > 높이
						{
							_img.setAttribute('width', 220);
							_img.setAttribute('height', 200);
						}
						else				// 넓이 < 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 220);
						}
					}

 					_img.onDrag = function() {
						resize_X = _img.x;
						resize_Y = _img.y;
						_img.srcElement.width = resize_x;
						_img.srcElement.height = resize_y;
					}
					
					
				var ifrm_win = document.getElementsByTagName("iframe")[0];		// iframe 선택
						
				if(ifrm_win != null)
					ifrm_win.contentWindow.document.body.append(_img);			// iframe body 업로드한 이미지 추가
					
				});		// iframe ready end
		});		// fileUploadResponse end
	});
	
	// 공지사항 등록 폼 그리기
	function noticeFormDraw()
	{
		$('#tableDiv').empty();
		$("#title").val("");
		$("#noticeDiv").css("display", "block");
		$('#btnDiv').empty();		
	}

	function cancel()
	{
		$("#noticeDiv").css("display", "none");
		noticeList();
	}
	
	function _cancel()
	{
		$("#noticeDiv").empty();
		$("#noticeDiv").css("display", "none");
	
		var html = "<from id='noticeForm' name='noticeForm'>"
			+ "<table style='margin-left; margin-top:15px; cursor:pointer;'>"
			+ "<tr><td>제목 : </td>"
			+ "<td><input type='text' id='title' name='title' style='width:406px;'/></td></tr>"
			+ "<tr><td colspan='2'><div><textarea class='form-control' rows='20' id='notice_content' name='notice_content'></textarea></div></td></tr>"
			+ "<tr><td colspan='2' align='center'><button class='btn btn-default' onclick='cancel();'>취소</button>&nbsp;&nbsp;&nbsp;<input type='submit' value='등록' onclick='writeNotice();' style='cursor:pointer;' class='btn btn-default'/></td></tr></table></form>";
			$('#noticeDiv').append(html); 
	
		editor = CKEDITOR.replace("notice_content", 
		{
			extraPlugins : 'uploadwidget,notificationaggregator,filetools,uploadimage,notification,widget,lineutils,widgetselection,imageresizerowandcolumn',
			width :	'472px',
			height : '700px',
			enterMode : CKEDITOR.ENTER_BR,
			uploadUrl : '/admin/ImageUpload.do',
			resize_enabled : false,
			allowedContent : true,
			toolbar : 
			[
			 	['Font', 'FontSize'],
			 	['BGColor', 'TextColor'],
				['Bold','Italic','Strike', 'Underline'],
				['Maximize', 'Preview'],
				'/',
				['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
				['NumberedList','BulletedList','-','Outdent','Indent'],
				['Table','HorizontalRule', 'SpecialChar'],
			 	['Undo','Redo']
			]
		});
		
		editor.on('fileUploadResponse', function(evt) {
			$(".cke_notifications_area").remove();			// 잘못된 응답 창 제거
			var fileLoader = evt.data.fileLoader,
				xhr = fileLoader.xhr,
				data = evt.data;
		
				var array = xhr.responseText.split(",");	
			
				$("#iframe").ready(function() {
					var requestUrl = array[1].replace(/'/gi, "");
					var src = requestUrl.substring(0,requestUrl.indexOf("?", 0));		

					var _img = document.createElement('img');
					_img.src = src;
					_img.style.cursor = "pointer";
					
					_img.onload = function() {
						var w = this.width;
						var h = this.height;

						if(w == h)			// 넓이 == 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 200);
						}
						else if(w > h)		// 넗이 > 높이
						{
							_img.setAttribute('width', 220);
							_img.setAttribute('height', 200);
						}
						else				// 넓이 < 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 220);
						}
					}
					
 					_img.onDrag = function() {
						resize_X = _img.x;
						resize_Y = _img.y;
						_img.srcElement.width = resize_x;
						_img.srcElement.height = resize_y;
					}					
	
				var ifrm_win = document.getElementsByTagName("iframe")[0];		// iframe 선택
						
				if(ifrm_win != null)
					ifrm_win.contentWindow.document.body.append(_img);			// iframe body 업로드한 이미지 추가
					
				});		// iframe ready end
		});		// fileUploadResponse end
			
		noticeList();
	}
	
	// 공지사항 등록
	function writeNotice()
	{	
		showProgress();
		if(debug_mode) console.log("notice regist function ....");
		var notice_content = CKEDITOR.instances.notice_content.getData();
		var notice_title = $("#title").val()

		if(notice_title == "" || notice_content == "")
		{
			alert("공지 제목과 내용을 확인하세요....");
			stopProgress();
			event.preventDefault();
		}
		else
		{
			var html = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></head><title>"
					+ notice_title + "</title><body>"
					+ notice_content + "</body>"
					+ "</html>";		
			$.ajax
			({
				url : "/admin/LiteNoticeUpload.do",
				type : "post",
				dataType : "json",
				data : {"title" : notice_title, "content" : html, "tag" : notice_content, "type" : "Y"},
				success : function(responseData) 
				{
					if(responseData.code == 00)
					{
						alert("공지사항 등록 성공!!!!");
						stopProgress();
						$('#noticeDiv').empty();
						noticeList();		
					}
				},
				error : function(responseData)
				{
					
				}	
			});
		}
	}
	
	// 공지사항 수정
	function modifyNotice(seq)
	{
		showProgress();
		if(debug_mode) console.log("notice modify function ....");
		var notice_content = CKEDITOR.instances.notice_content.getData();
		var notice_title = $("#title").val();

		if(notice_title == "" || notice_content == "")
		{
			alert("공지 제목과 내용을 확인하세요....");
/*			
			$('#tableDiv').append("<table id='table' class='table table-striped table-bordered table-hover'></table>");
			noticeList();
*/
			stopProgress();
			event.preventDefault();
		}
		else
		{
			var html = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></head><title>"
					+ notice_title + "</title><body>"
					+ notice_content + "</body>"
					+ "</html>";		
			$.ajax
			({
				url : "/admin/LiteNoticeUpload.do",
				type : "post",
				dataType : "json",
				data : {"seq" : seq, "title" : notice_title, "content" : html, "tag" : notice_content, "type" : "U", "beforeKey" : beforeKey},
				success : function(responseData) 
				{
					if(responseData.code == 00)
					{
						alert("공지사항 수정 성공!!!!");
						stopProgress();
						$('#noticeDiv').empty();
						noticeList();			
					}
				},
				error : function(responseData)
				{
					
				}	
			})
		}
	}
	
	// 공지사항 수정폼 그린후, 값 대입
	function modifyNoticeDraw(data)
	{
		$('#tableDiv').empty();
		$("#noticeDiv").empty();
 		var html = "<from id='noticeForm' name='noticeForm'>"
				+ "<table style='margin-left; margin-top:15px; cursor:pointer;'>"
				+ "<tr><td>제목 : </td>"
				+ "<td><input type='text' id='title' name='title' style='width:406px;'/></td></tr>"
				+ "<tr><td colspan='2'><div><textarea class='form-control' rows='20' id='notice_content' name='notice_content'></textarea></div></td></tr>"
				+ "<tr><td colspan='2' align='center'><button class='btn btn-default' onclick='_cancel();'>취소</button>&nbsp;&nbsp;&nbsp;<input type='submit' value='수정' onclick='modifyNotice(" + data.seq + ");' style='cursor:pointer;' class='btn btn-default'/></td></tr></table></form>";
		$('#noticeDiv').append(html); 
		
		editor = CKEDITOR.replace("notice_content", 
		{
 			extraPlugins : 'uploadwidget,notificationaggregator,filetools,uploadimage,notification,widget,lineutils,widgetselection,imageresizerowandcolumn',
			width :	'472px',
			height : '700px',
			enterMode : CKEDITOR.ENTER_BR,
			uploadUrl : '/admin/ImageUpload.do',
			resize_enabled : false,
			allowedContent : true,
			toolbar : 
			[
			 	['Font', 'FontSize'],
			 	['BGColor', 'TextColor'],
				['Bold','Italic','Strike', 'Underline'],
				['Maximize', 'Preview'],
				'/',
				['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
				['NumberedList','BulletedList','-','Outdent','Indent'],
				['Table','HorizontalRule', 'SpecialChar'],
			 	['Undo','Redo']
			]
		});
		
		editor.on('fileUploadResponse', function(evt) {
			$(".cke_notifications_area").remove();			// 잘못된 응답 창 제거
			var fileLoader = evt.data.fileLoader,
				xhr = fileLoader.xhr,
				data = evt.data;
		
				var array = xhr.responseText.split(",");	
			
				$("#iframe").ready(function() {
					var requestUrl = array[1].replace(/'/gi, "");
					var src = requestUrl.substring(0,requestUrl.indexOf("?", 0));		
					
					var _img = document.createElement('img');
					_img.src = src;
					_img.style.cursor = "pointer";			
					
					_img.onload = function() {
						var w = this.width;
						var h = this.height;

						if(w == h)			// 넓이 == 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 200);
						}
						else if(w > h)		// 넗이 > 높이
						{
							_img.setAttribute('width', 220);
							_img.setAttribute('height', 200);
						}
						else				// 넓이 < 높이
						{
							_img.setAttribute('width', 200);
							_img.setAttribute('height', 220);
						}
					}
					
 					_img.onDrag = function() {
						resize_X = _img.x;
						resize_Y = _img.y;
						_img.srcElement.width = resize_x;
						_img.srcElement.height = resize_y;
					}
					
					
				var ifrm_win = document.getElementsByTagName("iframe")[0];		// iframe 선택
						
				if(ifrm_win != null)
					ifrm_win.contentWindow.document.body.append(_img);			// iframe body 업로드한 이미지 추가
					
				});		// iframe ready end
		});		// fileUploadResponse end
		
		beforeKey = data.aws_file_path;

		$('#title').val(data.title);
		CKEDITOR.instances.notice_content.setData(data.tag);
		$("#noticeDiv").css("display", "block");
		$('#btnDiv').empty();			
	}
	
	// 공지사항 띄우기
	function showNotice(data)
	{
		var popUrl = data.context;
		var popOption = "width=800, height=800, resizable=no, scrollbars=no, status=no";
		window.open(popUrl, "", popOption);	
	}
	
	// 공지사항 삭제
	function deleteNotice(data)
	{
		showProgress()
		$.ajax({
			url : "/admin/liteNoticeDelete.do",
			type : "post",
			dataType : "json",
			data : {"seq" : data.seq, "aws_file_path" : data.aws_file_path},
			success : function(responseData)
			{
				if(responseData.code == 01)
				{
					alert("공지번호와 aws 경로를 확인하세요.");
					stopProgress();
					return false;
				}
				else if(responseData.code == 00)
				{
					alert("공지삭제 성공");
					$('#tableDiv').empty();
					$('#btnDiv').empty();
					stopProgress();
					noticeList();
				}
			},
			error : function(responseData)
			{
				
			}
		});
	}

	// 공지사항 그리기
	function noticeList()
	{
		$('#btnDiv').append("<button class='btn btn-default' onclick='noticeFormDraw();'>공지등록</button>");
		$('#tableDiv').append("<table id='table' class='table table-striped table-borered table-hover' style='width:85%;'></table");

		 var jsonObject;
		 var table = $('#table').DataTable({
	    	 "paging" : true,
	    	 "ordering" : true,
	    	 "info" : true,
	    	 "searching" : false,
	    	 responsive : true,
	    	 "processing" : true,
    		 "ajax" : {
    			 "url" : "/admin/liteNoticeList.do",
    			 type : "post",
    			 async : true,
    			 dataType : "json",
    			 "data" : function() {
    				 
    			 },
    			 complete : function() {
    				 
    			 },
    			 "dataSrc" : ""
    		 },
    		 "columns" : [
    		              {"title" : '공지번호', "width" : "30px", "data" : "seq"},
    		              {"title" : '공지제목', "width" : "80px", "data" : "title"},
    		              {"title" : '등록일', "width" : "70px", "data" : "create_date"},
    		              {"title" : '', "width" : "60px", "data" : null,
    		            	"render" : 
	    		            function(data, type, row)
	    		            {
    		            	return "<button class='btn btn-default'>공지보기</button> <button class='btn btn-warning'>공지수정</button> <button class='btn btn-danger'>공지삭제</button>"; 
	    		            },  
    		              }/* ,
    		              {"title" : "공지삭제", "width" : "60px", "data" : null,
    		               "render" : 
    		            	   function(data, type, row)
    		            	   {
    		            	   	return "<button class='btn btn-danger'>공지삭제</button>";
    		            	   }
    		              } */
    		]
		 });
		
 		$('#table').on('click', '.btn-default', function() {
 	    	var data = table.row($(this).parents('tr')).data();
 	    	showNotice(data);
	    });
 		
 		$('#table').on('click', '.btn-danger', function() {
 	    	var data = table.row($(this).parents('tr')).data();
 	    	deleteNotice(data);
	    }); 
 		
 		$('#table').on('click', '.btn-warning', function() {
 	    	var data = table.row($(this).parents('tr')).data();
 	    	modifyNoticeDraw(data);
	    }); 
	}
	
	</script>
</body>