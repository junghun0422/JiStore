<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#storeDiv
{
	width	:100%;
	height	:85%;	
}

#paingDiv
{
	width	:	100%;
	height	:	15%;
}
</style>
<link rel="stylesheet" type="text/css" href="css/bootstrap-combined.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
	$(function() 
	{
		changePaging(1);
	});

	function changePaging(page_index)
	{
		$("#storeDiv").empty();
		$("#paingDiv").empty();
		
		$.ajax(
		{
			url:"/reportListPaging",
			type: "POST",
			data : { "page_index" :  page_index },
			dataType : "json",
			success : function( map )
			{
				console.log( JSON.stringify( map ) );
				var tag = "";
				for( var i=0; i<map.reportPagingList.length; i++ )
				{
					tag += "<div><span>" + map.reportPagingList[i].name + "</span><span>" + map.reportPagingList[i].location + "</span></div>";
				}

				$("#storeDiv").append(tag);

				$("<div class='dataTables_paginate paging_simple_numbers' id='dataTables-example_paginate'><ul class='pagination' id='page_ul'>").appendTo("#paingDiv");
				if( map.paging.pageNo != map.paging.firstPageNo )
				{
					var tag = "<li><a href='javascript:changePaging(" + map.paging.firstPageNo + ")'>처음</a></li><li class='paginate_button previous' aria-controls='dataTables-example' tabindex='0' id='dataTables-example_previous'><a href='javascript:changePaging(" + map.paging.prevPageNo + ");'>이전</a></li>";
					$(tag).appendTo( "#page_ul" );
				}

				var page_tag = "";
 				for(var z = map.paging.startPageNo; z <= map.paging.endPageNo; z++)
				{
					if(z == map.paging.pageNo)
					{
						page_tag += "<li class='paginate_button active' aria-controls='dataTables-example' tabindex='0'><a href='#'>" + z + "</a></li>";
					}
					else
					{
						page_tag += "<li class='paginate_button' aria-controls='dataTables-example' tabindex='0'><a href='javascript:changePaging(" + z + ")'>" + z + "</a></li>";
					}
				}
 				$(page_tag).appendTo("#page_ul");

 				if(map.paging.pageNo != map.paging.finalPageNo)
 				{
 					var tag = "<li class='paginate_button next' aria-controls='dataTables-example' tabindex='0' id='dataTables-example_next'><a href='javascript:changePaging(" + map.paging.nextPageNo + ")'>다음</a></li><li><a href='javascript:changePaging(" + map.paging.finalPageNo + ")'>마지막</a></li></ul></div>";
 					$(tag).appendTo("#page_ul"); 					
 				}				
			},
			error : function()
			{

			}
		});
	}
</script>
<div id="storeDiv"></div>
<div id="paingDiv"></div>
</body>
</html>