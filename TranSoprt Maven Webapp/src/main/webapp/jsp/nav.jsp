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
							src="img/business_man.png" />
						</span> <a data-toggle="dropdown" class="dropdown-toggle" href="#"> <span
							class="clear"> <span class="block m-t-xs"> <!-- <strong class="font-bold">Beaut-zihan</strong> -->
							</span> <span class="text-muted text-xs block"><c:if
										test="${!empty user.nickname }">管理员</c:if> <c:if
										test="${empty user.nickname }">
											厂家
										</c:if> <b class="caret"></b></span>
						</span>
						</a>
						<ul class="dropdown-menu animated fadeInRight m-t-xs">
							<li><a
								href="${pageContext.request.contextPath }/account/pwdpage">修改密码</a></li>
							<li class="divider"></li>
							<li><a
								href="${pageContext.request.contextPath }/account/logout">安全退出</a></li>
						</ul>
					</div>
					<div class="logo-element">港荣</div>

				</li>
				<!-- 账户模块-->
				<c:if test="${!empty user.nickname }">
					<li id="li_account" ><a href="#"><i
							class="fa fa-th-large"></i> <span class="nav-label">账户</span> <span
							class="fa arrow"></span></a>
						<ul id="ulsecond"class="nav nav-second-level">


							<li id="li_distorder"><a
								href="${pageContext.request.contextPath}/order/distorder/1">订单管理</a></li>
							<li id="li_factory"><a
								href="${pageContext.request.contextPath}/factory/account/1">厂家管理</a></li>
							<li id="li_dealer"><a
								href="${pageContext.request.contextPath}/manager/dealer">经销商管理</a></li>
							<li id="li_goods"><a
								href="${pageContext.request.contextPath}/goods/list/1">商品管理</a></li>

							<li id="li_setting"><a
								href="${pageContext.request.contextPath }/factory/setting/1">厂家设置</a></li>


						</ul></li>
				</c:if>
				<!-- 厂家模块 -->
				<li><c:if test="${!empty user.nickname}">
						<li id="li_factory_order"><a
							href="${pageContext.request.contextPath}/factory/manager/1"><i
								class="fa fa-flask "></i> <span class="nav-label">厂家</span><span
								class="label label-danger pull-right"></span></a>
					</c:if> <c:if test="${empty user.nickname }">
						<a
							href="${pageContext.request.contextPath}/factory/order/${user.fid }"><i
							class="fa fa-flask"></i> <span class="nav-label">厂家</span><span
							class="label label-danger pull-right"></span></a>
					</c:if></li>
				<!-- 经销商管理模块 -->
				<li id="li_dealer_order"><a
					href="${pageContext.request.contextPath}/order/deliveryorder/1"><i
						class="fa fa-comments"></i> <span class="nav-label">经销商</span><span
						class="label label-danger pull-right"></span></a></li>
				<!-- 公告 -->
				<li><c:if test="${!empty user.nickname}">
						<li id="li_public"><a
							href="${pageContext.request.contextPath}/public"><i
								class="fa fa-flask "></i> <span class="nav-label">公告</span><span
								class="label label-danger pull-right"></span></a>
					</c:if>
			</ul>
		</div>
	</nav>
	<script	src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
	<script>
	$(document).ready(
							function() {

								var li_id = '${li_id}';
								$("#" + li_id).addClass("active");
								if (!(li_id == "li_factory_order"
										|| li_id == "li_dealer_order"||li_id=="li_public")) {
									$("#li_account").addClass("active");
									
								}
							});
	</script>
</body>

</html>