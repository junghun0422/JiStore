<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../lib/scripts/jquery-1.12.4.min.js"></script>
<style>
	.footer
	{
		position: fixed;
	    bottom: 0;
	    width: 100%;
	    height: 60px;
	    line-height: 60px;
	    background-color: #DAF9DA;
	}
</style>
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<a class="navbar-brand" href="#">SongShop</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          		<span class="navbar-toggler-icon"></span>
        	</button>
        	<div class="collapse navbar-collapse" id="navbarCollapse">
          		<ul class="navbar-nav mr-auto">
            		<li class="nav-item active">
              			<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            		</li>
		            <li class="nav-item">
		              <a class="nav-link" href="#">Link</a>
		            </li>
		            <li class="nav-item">
		              <a class="nav-link disabled" href="#">Disabled</a>
		            </li>
          		</ul>
          		<span class="userInfo" style="margin-right:15px; color:white; cursor:pointer;" data-toggle="tooltip" data-placement="top" title="로그아웃">
          		<svg class="bi bi-person-bounding-box" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M1.5 1a.5.5 0 0 0-.5.5v3a.5.5 0 0 1-1 0v-3A1.5 1.5 0 0 1 1.5 0h3a.5.5 0 0 1 0 1h-3zM11 .5a.5.5 0 0 1 .5-.5h3A1.5 1.5 0 0 1 16 1.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 1-.5-.5zM.5 11a.5.5 0 0 1 .5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 1 0 1h-3A1.5 1.5 0 0 1 0 14.5v-3a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v3a1.5 1.5 0 0 1-1.5 1.5h-3a.5.5 0 0 1 0-1h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 1 .5-.5z"/>
				  <path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
				</svg>
          		${userInfo}
          		</span>
          		<form class="form-inline mt-2 mt-md-0">
 	           		<input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
    	       	 	<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          		</form>
        	</div>
		</nav>
	</header>
	
	
	<footer class="footer">
      <div class="container">
        <span class="text-muted"> Ji Store </span>
      </div>
    </footer>
</body>
<script type="text/javascript">

</script>
</html>