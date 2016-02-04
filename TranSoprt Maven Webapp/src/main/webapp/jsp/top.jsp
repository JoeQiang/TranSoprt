<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-static-top" role="navigation"
	style="margin-bottom: 0">
	<div class="navbar-header">
		<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "><i
			class="fa fa-bars"></i> </a>
		<form role="search" class="navbar-form-custom" method="post"
			action="search_results.html">
			<div class="form-group"></div>
		</form>
	</div>
	<ul class="nav navbar-top-links navbar-right">
		<li><span class="m-r-sm text-muted welcom	e-message"><a
				href="index.html" title="返回首页"></a>欢迎使用港荣后台管理系统</span>
		</li>
		<li>
			
				<a href="${pageContext.request.contextPath }/account/logout"> <i
					class="fa fa-sign-out"></i> 退出
				</a>
			</li>
	</ul>

</nav>