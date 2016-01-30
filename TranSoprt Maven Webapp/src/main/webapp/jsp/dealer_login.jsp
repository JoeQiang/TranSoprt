<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0" />
<title>港荣经销商客户端</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/kehuduanstyle.css"
	rel="stylesheet" type="text/css" />
</head>
<body>

	<!--导航-->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<div class="navbar-brand">港荣经销商客户端</div>
				<!-- <button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false" aria-haspopup="true">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu">
					<li><a href="#">未登录</a></li>
				</ul> -->
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<!-- <div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="name"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"> 未登录 </a></li>
				</ul>
			</div> -->
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<!--主内容-->
	<div class="row">
		<ul id="mytab" class="col-md-12 col-xs-12" role="tablist">
			<li role="presentation" class="loginTab col-md-6 col-xs-6 active"
				id="login1">手机密码登录</li>
			<li role="presentation" class="loginTab col-md-6 col-xs-6 "
				id="login2">手机验证登录</li>
		</ul>
	</div>
	<div class="container">
		<div class="col-md-4 col-md-offset-4 col-xs-12">
			<div class="biaoti"></div>
		</div>
		<div class="login-content">

			<div class="login1 ">
				<input type="text" placeholder="请输入手机号码" id="phoneInput2" /> <input
					type="password" placeholder="请输入密码" id="fixedPwd" />
				<div class="btnConfrim">
					<button id="btn_login2" role="button" value="登陆"
						href="javaScript:void(0);" onclick="login2()"
						class="btn btn-success btn-lg ">登陆</button>
				</div>
			</div>
			<div class="login2 hidden">
				<input type="text" name="phone" id="phoneInput"
					placeholder="请输入手机号码" />
				<div class="psd">
					<a class="btn btn-success btn-sm" id="btn_getpwd"
						href="javaScript:void(0);" onclick="getpwd()">获取动态密码</a>
				</div>
				<input type="password" name="pwd" id="dypwd" placeholder="请输入动态密码" />
				<div class="btnConfrim">
					<button id="btn_login" role="button" 
						href="javaScript:void(0);" onclick="login()"
						class="btn btn-success btn-lg">登陆</button>
				</div>
			</div>
		</div>
	</div>
	<!-- <footer>
		&copy;vanroid团队<br />All rights reserved.
	</footer> -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/project.js"></script>
	<script>
		/* 获取动态密码 */
		function getpwd() {
			var phone = $("#phoneInput").val();
			if (phone == null || phone == "") {
				alert("请输入手机号码！");
				return;
			}
			if (!phone
					.match(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/)) {
				alert("不是有效的手机号码！");
				return;
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/dealer/getdynamic/'
						+ phone,
				type : 'GET',
				dataType : 'json',
				success : function(data) {
					if (data == 0)
						alert("该手机未经注册为经销商！");
					if (data == 1)
						$("#btn_getpwd").attr("disabled", true);
					/*  alert("短信已发送！"); */
				}
			});
		}
		/* 动态密码登陆 
			1登陆成功，2密码错误，3用户不存在
		 */
		function login() {
		 	var phone = $("#phoneInput").val();
			if (phone == "") {
				alert("请填写手机号！");
				return;
			}
			var dypwd = $("#dypwd").val();
			if (dypwd == "") {
				alert("请填写登陆密码！");
				return;
			}
		$("#btn_login").text("正在登陆...");
			$
					.ajax({
						url : '${pageContext.request.contextPath }/dealer/logininput',
						type : 'POST',
						data : {
							'phone' : phone,
							'pwd' : dypwd
						},
						dataType : 'json',
						success : function(data) {
							if (data == 1) {
								/* alert("登陆成功！"); */
								window.location = "${pageContext.request.contextPath }/goods/totalgoods";
							}
							if (data == 2) {
								alert("密码错误！");
								$("#btn_login").text("登陆");
							}
							if (data == 3) {
								alert("用户不存在！");
								$("#btn_login").text("登陆");
							}
						}
					}); 
		}
		/* 固定密码登陆 */
		function login2() {
			var phone = $("#phoneInput2").val();
			var pwd = $("#fixedPwd").val();
			if (phone == "") {
				alert("请填写手机号！");
				return;
			}
			if (pwd == "") {
				alert("请填写登陆密码！");
				return;
			}
			$("#btn_login2").text("正在登陆...");
			$
					.ajax({
						url : '${pageContext.request.contextPath }/dealer/logininput',
						type : 'POST',
						data : {
							'phone' : phone,
							'pwd' : pwd
						},
						dataType : 'json',
						success : function(data) {
							if (data == 1) {
								/* alert("登陆成功！"); */
								window.location = "${pageContext.request.contextPath }/goods/totalgoods";
							}
							if (data == 2){
								alert("密码错误！");$("#btn_login2").text("登陆");}
							if (data == 3){
								alert("用户不存在！");$("#btn_login2").text("登陆");}
						}
					});
		}
	</script>
</body>
</html>