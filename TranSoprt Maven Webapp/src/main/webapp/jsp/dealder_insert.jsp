<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<title>港荣订单管理系统</title>
<meta name="keywords" content="港荣订单管理系统">
<meta name="description" content="港荣订单管理系统">
<link
	href="${pageContext.request.contextPath }/css/bootstrap.min.css?v=3.4.0"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/css/font-awesome.css?v=4.3.0"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/animate.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/style.css?v=2.2.0"
	rel="stylesheet">
</head>

<body>
	<div id="wrapper">
		<%
			String tokenValue = new Date().getTime() + "";
			session.setAttribute("token", tokenValue);
		%>
		<%@include file="nav.jsp"%>
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
								<!-- <input type="text" placeholder="请输入您需要搜索的订单 …"
									class="form-control" name="top-search" id="top-search"> -->
							</div>
						</form>
					</div>
					<ul class="nav navbar-top-links navbar-right">
						<li><span class="m-r-sm text-muted welcome-message"><a
								href="index.html" title="返回首页"><i class="fa fa-home"></i></a>欢迎使用港荣后台管理系统</span>
						</li>
						<li><c:if test="${sessionScope.user == null }">
								<a href="login"> <i class="fa fa-sign-out"></i> 登录
								</a>
							</c:if> <c:if test="${sessionScope.user != null }">
								<a href="login/exit"> <i class="fa fa-sign-out"></i> 退出
								</a>
							</c:if></li>
					</ul>

				</nav>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">
				<!-- 导航条 -->
				<div class="row">
					<div class="col-sm-6">
						<ol class="breadcrumb">
							<li><a href="#">账户</a></li>
							<li>经销商管理</li>
							<li>新增经销商</li>
						</ol>
					</div>
				</div>
				<div class="row" style="margin-top: 20px">
					<div class="col-sm-8">

						<div class="form-group">
							<label>新增经销商</label> <select id="select" name="type"
								class="form-control" required="">
								<option value="">选择新增方式</option>
								<option value="">Excel导入</option>
								<option value="">单条导入</option>
							</select> <label style="color: red;"> <c:out value="${error }" /></label>
							<div id="panel1" style="display: none;">
								<form
									action="${pageContext.request.contextPath }/manager/dealer/excelInsert"
									method="post" onsubmit="return dosubmit()"
									enctype="multipart/form-data">
									<div class="form-group">
										<%-- <input type="hidden" name="token" value="<%=tokenValue%>"> --%>
										<label>请选择Excel文件</label> <input type="file" name="excel"
											class="form-control" required="">
										<p class="help-block">
											Excel文件必须符合规范，<a
												href="${pageContext.request.contextPath }/download/supplierTemplate">点击下载</a>经销商导入模版
										</p>
									</div>
									<button class="btn btn-outline btn-primary" type="submit">新增</button>
									<a class="btn btn-outline btn-default" type="button"
										href="javascript:history.go(-1);">返回</a>
								</form>
							</div>
							<div id="panel2" style="display: none;">
								<form
									action="${pageContext.request.contextPath }/manager/dealer/singleInsert"
									method="post" onsubmit="return dosubmit()">
									<input type="hidden" name="token" value="<%=tokenValue%>">
									<input type="hidden" name="operation" value="insert">
									<div class="form-group">
										<label>供应商</label> <input type="text" class="form-control"
											placeholder="供应商名称" name="dname" required=""> <label
											style="color: red;"> <c:out value="${dnameMsg }" /></label>
									</div>
									<div class="form-group">
										<label>联系电话</label> <input type="text" class="form-control"
											placeholder="联系电话" name="phone" required=""> <label
											style="color: red;"> <c:out value="${phoneMsg }" /></label>
									</div>
									<div class="form-group">
										<label>所在省市</label> <input type="text" class="form-control"
											placeholder="所在省市" name="province" required=""> <label
											style="color: red;"> <c:out value="${provinceMsg }" /></label>
									</div>
									<div class="form-group">
										<label>规定到达天数</label> <input type="text" class="form-control"
											placeholder="天数" name="limitdays" required=""> <label
											style="color: red;"> <c:out value="${limitdaysMsg }" /></label>
									</div>

									<button class="btn btn-outline btn-primary" type="submit">新增</button>
									<a class="btn btn-outline btn-default" type="button"
										href="javascript:history.go(-1);">返回</a>
								</form>
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- 内容主体结束 -->
			<!-- 脚部 -->
			<div class="footer">
				<!-- <div class="pull-right">
	                               By：<a href="#" target="_blank">港荣</a>
	                           </div> -->
				<div>
					<strong>订单管理系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
				</div>
			</div>
		</div>
	</div>
	<!-- 脚部 -- >
	</div>

	<!-- Mainly scripts -->
	<script
		src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/js/bootstrap.min.js?v=3.4.0"></script>
	<script
		src="${pageContext.request.contextPath }/js/metisMenu/jquery.metisMenu.js"></script>
	<script
		src="${pageContext.request.contextPath }/js/slimscroll/jquery.slimscroll.min.js"></script>
	<!-- Custom and plugin javascript -->
	<script src="${pageContext.request.contextPath }/js/hplus.js?v=2.2.0"></script>
	<script
		src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>

	<script>
		var isCommitted = false;//表单是否已经提交标识，默认为false
		$(document).ready(function() {
			$("#select").change(function() {
				var selectIndex = $("#select").get(0).selectedIndex;
				if (selectIndex == 1) {
					$("#panel1").slideToggle("slow");
					$("#panel2").css("display", "none");
				} else if (selectIndex == 2) {
					$("#panel2").slideToggle("slow");
					$("#panel1").css("display", "none");
				} else {
					$("#panel2").slideUp("slow");
					$("#panel1").slideUp("slow");
				}
			});
		});
		function dosubmit() {
			if (isCommitted == false) {
				isCommitted = true;//提交表单后，将表单是否已经提交标识设置为true
				return true;//返回true让表单正常提交
			} else {
				return false;//返回false那么表单将不提交
			}
		}
	</script>
</body>
</html>