<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
</head>
<body>
	<nav class="navbar-default navbar-static-side" role="navigation">
		<!--侧边栏开始-->
		<div class="sidebar-collapse">

			<ul class="nav" id="side-menu">
				<li class="nav-header">


					<div class="dropdown profile-element">
						<span> <img alt="image" class="img-circle"
							src="img/profile_small.jpg" />
						</span> <a data-toggle="dropdown" class="dropdown-toggle"
							href="index.html#"> <span class="clear"> <span
								class="block m-t-xs"> <!-- <strong class="font-bold">Beaut-zihan</strong> -->
							</span> <span class="text-muted text-xs block"><c:if
										test="${!empty user.nickname }">管理员</c:if> <c:if
										test="${empty user.nickname }">
											厂家
										</c:if> <b class="caret"></b></span>
						</span>
						</a>
						<ul class="dropdown-menu animated fadeInRight m-t-xs">
							<li><a href="">修改密码</a></li>
							<li class="divider"></li>
							<li><a
								href="${pageContext.request.contextPath }/account/logout">安全退出</a></li>
						</ul>
					</div>
					<div class="logo-element">港荣</div>

				</li>
				<!-- 账户模块-->
				<li><a href="index.html"><i class="fa fa-th-large"></i> <span
						class="nav-label">账户&nbsp;<b class="caret"></b></span> <span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">

						<c:if test="${!empty user.nickname }">
							<li class="active"><a
								href="${pageContext.request.contextPath}/order/distorder/1">订单管理</a></li>
							<li><a
								href="${pageContext.request.contextPath}/factory/account/1">厂家管理</a></li>
							<li><a
								href="${pageContext.request.contextPath}/manager/dealer">经销商管理</a></li>
							<li><a
								href="${pageContext.request.contextPath}/goods/list/1">商品管理</a></li>

							<li><a
								href="${pageContext.request.contextPath }/factory/setting/1">厂家设置</a></li>
						</c:if>
						<c:if test="${empty user.nickname}">
							<li><a href="">修改密码</a></li>
						</c:if>
					</ul></li>
				<!-- 厂家模块 -->
				<li><c:if test="${!empty user.nickname}">
						<a href="${pageContext.request.contextPath}/factory/manager/1"><i
							class="fa fa fa-globe"></i> <span class="nav-label">厂家</span><span
							class="fa arrow"></span></a>
					</c:if> <c:if test="${empty user.nickname }">
						<a
							href="${pageContext.request.contextPath}/factory/order/${user.fid }"><i
							class="fa fa fa-globe"></i> <span class="nav-label">厂家</span><span
							class="fa arrow"></span></a>
					</c:if></li>
				<!-- 经销商管理模块 -->
				<li><a
					href="${pageContext.request.contextPath}/order/deliveryorder/1"><i
						class="fa fa-bar-chart-o"></i> <span class="nav-label">经销商</span><span
						class="fa arrow"></span></a></li>

			</ul>
		</div>
	</nav>
</body>
</html>