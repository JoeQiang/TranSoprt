<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>港荣食品订单管理系统</title>
<meta name="keywords" content="港荣食品订单管理系统">
<meta name="description" content="港荣食品订单管理系统">

<link
	href="${pageContext.request.contextPath }/css/bootstrap.min.css?v=3.4.0"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css?v=4.3.0"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/css/plugins/iCheck/custom.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/animate.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/style.css?v=2.2.0"
	rel="stylesheet">

</head>

<body>
	<div id="wrapper">

		<%@include file="nav.jsp"%>
		<!--侧边栏结束-->
		<!-- 搜索栏 -->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<%@include file="top.jsp"%>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">

				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>修改密码</h5>
								<div class="ibox-tools">
									<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
									</a> <a class="dropdown-toggle" data-toggle="dropdown"
										href="table_data_tables.html#"> <i class="fa fa-wrench"></i>
									</a>
									<ul class="dropdown-menu dropdown-user">
										<li><a href="table_data_tables.html#">选项1</a></li>
										<li><a href="table_data_tables.html#">选项2</a></li>
									</ul>
									<a class="close-link"> <i class="fa fa-times"></i>
									</a>
								</div>
							</div>
							<div class="ibox-content">
								<div class="row">
									<div class="col-sm-5">
										<form
											action="${pageContext.request.contextPath }/account/cheangepwd"
											onsubmit="return check()" method="post">
											<div class="form-group">
												<label>账号</label>
												<p style="font-size: 20px">
													<c:if test="${rank eq 'factory' }">${user.fname }</c:if>
													<c:if test="${rank eq 'admin' }">${user.username }</c:if>
												</p>
											</div>
											<div class="form-group">
												<label>设置新密码</label> <input id="npwd" type="password"
													class="form-control" name="pwd" placeholder="请输入新的密码">
											</div>
											<div class="form-group">
												<label>再次输入</label> <input id="rpwd" type="password"
													class="form-control" placeholder="再次输入新的密码">
											</div>
											<button type="submit" class="btn btn-primary">修改</button>
											<button type="button" class="btn btn-default"
												onclick="history.go(-1)">返回</button>
											<label style="color: red;display: block;">
												<p id="msg">${msg }</p>
											</label>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 内容主体结束 -->
				<!-- 脚部 -->
				<!-- 		<div class="footer">
							<div class="pull-right">
	                               By：<a href="#" target="_blank">港荣</a>
	                           </div>
							<div>
								<strong>订单管理系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
							</div>

						</div> -->
				<!-- 脚部 -->
			</div>
			<!-- Mainly scripts -->
			<script
				src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
			<script
				src="${pageContext.request.contextPath }/js/bootstrap.min.js?v=3.4.0"></script>
			<script
				src="${pageContext.request.contextPath }/js/plugins/metisMenu/jquery.metisMenu.js"></script>
			<script
				src="${pageContext.request.contextPath }/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

			<!-- Custom and plugin  -->
			<script src="${pageContext.request.contextPath }/js/hplus.js?v=2.2.0"></script>
			<script
				src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>

			<script>
				function check() {
					var npwd = $('#npwd').val();
					var rpwd = $('#rpwd').val();
					if (npwd.length == 0) {
						$('#mag').html('密码不能为空');
						return false;
					}
					if (npwd.length < 6) {
						$('#mag').html('密码长度必须6位以上');
						return false;
					}
					if (rpwd != npwd) {
						$('#mag').html('两次输入密码必须一致');
						return false;
					}
					return true;
				}
			</script>
</body>

</html>