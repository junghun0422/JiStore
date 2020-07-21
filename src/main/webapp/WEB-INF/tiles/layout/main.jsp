<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/> --%>
<style>
	html, body
	{
		width	:	100%;
		height	:	100%;
	}
</style>
</head>
<body>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="body" />
	<%-- <tiles:insertAttribute name="footer" />	 --%>
<!-- 	<script>
		var header = "", token = "";

		$(function()
		{
			token = $("meta[name='_csrf']").attr("content");
			header =  $("meta[name='_csrf_header']").attr("content");
		});
	</script> -->
</body>
</html>