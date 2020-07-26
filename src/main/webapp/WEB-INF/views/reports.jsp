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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- DataTables CSS -->
<link href="lib/scripts/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
<!-- DataTables Responsive CSS -->
<link href="lib/scripts/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
</head>
<body>
<div id="tableDiv"></div>

    <!-- jQuery -->
<!--     <script src="/_admin/vendor/jquery/jquery.min.js"></script> -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <!-- Bootstrap Core JavaScript -->
    <script src="lib/scripts/bootstrap/js/bootstrap.min.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="lib/scripts/datatables/js/jquery.dataTables.min.js"></script>
    <script src="lib/scripts/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="lib/scripts/datatables-responsive/dataTables.responsive.js"></script>
    
    <script type="text/javascript">

	$(document).ready(function() {
		// 공지 목록 그리기
		noticeList();
	});


	// 공지사항 그리기
	function noticeList()
	{
		$('#tableDiv').append("<table id='table' class='table table-striped table-borered table-hover' style='width:85%;'></table");

		 var table = $('#table').DataTable({
	    	 "paging" : true,
	    	 "ordering" : true,
	    	 "info" : true,
	    	 "searching" : false,
	    	 responsive : true,
	    	 "processing" : true,
    		 "ajax" : {
    			 "url" : "/reportList",
    			 type : "post",
    			 async : true,
    			 dataType : "json",
    			 "data" : function() { },
    			 complete : function() { },
    			 "dataSrc" : ""
    		 },
    		 "columns" : [
    		              {"title" : '상호명', "width" : "30px", "data" : "name"},
    		              {"title" : '지역', "width" : "80px", "data" : "location"},
    		              {"title" : '주소', "width" : "70px", "data" : "address"}/* ,
    		              {"title" : '', "width" : "60px", "data" : null,
    		            	"render" : 
	    		            function(data, type, row)
	    		            {
    		            	return "<button class='btn btn-default'>공지보기</button> <button class='btn btn-warning'>공지수정</button> <button class='btn btn-danger'>공지삭제</button>"; 
	    		            },  
    		              } *//* ,
    		              {"title" : "공지삭제", "width" : "60px", "data" : null,
    		               "render" : 
    		            	   function(data, type, row)
    		            	   {
    		            	   	return "<button class='btn btn-danger'>공지삭제</button>";
    		            	   }
    		              } */
    		]
		 });
		
/*  		$('#table').on('click', '.btn-default', function() {
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
	    });  */
	}
	
	</script>
</body>