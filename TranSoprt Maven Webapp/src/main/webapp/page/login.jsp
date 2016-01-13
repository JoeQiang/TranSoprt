<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
</head>

<body>
	<form action="login" method="post">
		账号：<input type="text" name="user.username"> <br> 密码<input
			type="text" name="user.password"><br> <br> <input
			type="submit" value="登陆">
	</form>

</body>
</html>
