<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<title>港荣食品物流跟踪系统</title>
<meta name="keywords" content="港荣食品物流跟踪系统">
<meta name="description" content="港荣食品物流跟踪系统">

<link href="../css/bootstrap.min.css?v=3.4.0" rel="stylesheet">
<link href="../css/font-awesome.css?v=4.3.0" rel="stylesheet">
<link href="../css/animate.css" rel="stylesheet">
<link href="../css/style.css?v=2.2.0" rel="stylesheet">

</head>

<body>
	<div id="wrapper">

		<%@include file="nav.jsp" %>
		<!--侧边栏结束-->
		<!-- 搜索栏 -->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top" role="navigation"
					style="margin-bottom: 0">
					<div class="navbar-header">
						<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "
							href="#"><i class="fa fa-bars"></i> </a>
						<form role="search" class="navbar-form-custom" method="post"
							action="search_results.html">
							<div class="form-group">
								<input type="text" placeholder="请输入您需要搜索的订单 …"
									class="form-control" name="top-search" id="top-search">
							</div>
						</form>
					</div>
					<ul class="nav navbar-top-links navbar-right">
						<li><span class="m-r-sm text-muted welcome-message"><a
								href="index.html" title="返回首页"><i class="fa fa-home"></i></a>欢迎使用港荣后台管理系统</span>
						</li>
						<li><a href="login.html"> <i class="fa fa-sign-out"></i>
								退出
						</a></li>
					</ul>

				</nav>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading"></div>
			<!-- 内容主体结束 -->
			<!-- 脚部 -->
			<div class="footer">
				<!-- <div class="pull-right">
	                               By：<a href="#" target="_blank">港荣</a>
	                           </div> -->
				<div>
					<strong>物流跟踪系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
				</div>
			</div>
		</div>
		<!-- 脚部 -->
	</div>

	<!-- Mainly scripts -->
	<script src="../js/jquery-2.1.1.min.js"></script>
	<script src="../js/bootstrap.min.js?v=3.4.0"></script>
	<script src="../js/metisMenu/jquery.metisMenu.js"></script>
	<script src="../js/slimscroll/jquery.slimscroll.min.js"></script>
	<!-- Custom and plugin javascript -->
	<script src="../js/hplus.js?v=2.2.0"></script>
	<script src="../js/plugins/pace/pace.min.js"></script>
</body>

</html>