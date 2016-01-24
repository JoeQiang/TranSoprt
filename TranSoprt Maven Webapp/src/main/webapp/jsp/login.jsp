<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<title>港荣食品物流跟踪系统</title>
<meta name="keywords" content="港荣食品物流跟踪系统">
<meta name="description" content="港荣食品物流跟踪系统">
<base href="<%=basePath%>">
<link href="css/bootstrap.min.css?v=3.4.0" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=2.2.0" rel="stylesheet">

</head>

<body class="gray-bg">

	<div class="middle-box text-center loginscreen  animated fadeInDown">
		<div>
			<div>

				<h1 class="logo-name"></h1>

			</div>
			<h3>欢迎使用物流跟踪系统</h3>

			<form class="m-t" role="form" action="login/dologin" method="post">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="用户名"
						name="username" required="">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" placeholder="密码"
						name="password" required="">
				</div>
				<div class="form-group">
					<select name="type" class="form-control" required="">
						<option value="">请选择账户类型</option>
						<option value="admin">管理员</option>
						<option value="factory">厂家</option>
						<option value="dealer">经销商</option>
					</select>
					<p class="help-block" style="red">${error }</p>
				</div>
				<button type="submit" class="btn btn-primary block full-width m-b">登
					录</button>


				<p class="text-muted text-center">
					<a href="login.html#"><small>忘记密码了？</small></a> | <a
						href="register.html">注册一个新账号</a>
				</p>
			</form>
		</div>
	</div>

	<!-- Mainly scripts -->
	<script src="js/jquery-2.1.1.min.js"></script>
	<script src="js/bootstrap.min.js?v=3.4.0"></script>

	<script type="text/javascript"
		src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
	<!--统计代码，可删除-->

</body>

</html>

