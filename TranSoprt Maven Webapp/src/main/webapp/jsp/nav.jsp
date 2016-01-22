<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=">
</head>
<body>
<nav class="navbar-default navbar-static-side" role="navigation">
			<!--侧边栏开始-->
			<div class="sidebar-collapse">

				<ul class="nav" id="side-menu">
					<li class="nav-header">


						<div class="dropdown profile-element">
							<span> <img alt="image" class="img-circle"
								src="../img/profile_small.jpg" />
							</span> <a data-toggle="dropdown" class="dropdown-toggle"
								href="index.html#"> <span class="clear"> <span
									class="block m-t-xs"> <strong class="font-bold">Beaut-zihan</strong>
								</span> <span class="text-muted text-xs block">超级管理员 <b
										class="caret"></b></span>
							</span>
							</a>
							<ul class="dropdown-menu animated fadeInRight m-t-xs">
								<li><a href="form_avatar.html">修改密码</a></li>
								<li class="divider"></li>
								<li><a href="login.html">安全退出</a></li>
							</ul>
						</div>
						<div class="logo-element">H+</div>

					</li>
					<!-- 账户模块-->
					<li><a href="index.html"><i class="fa fa-th-large"></i> <span
							class="nav-label">账户&nbsp;<b
										class="caret"></b></span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li class="active"><a href="${pageContext.request.contextPath}/order/distorder">订单分配</a></li>
							<li><a href="">厂家订单</a></li>
							<li><a href="index_2.html">经销商管理</a></li>
							<li><a href="${pageContext.request.contextPath}/goods/list?page=1">商品管理</a></li>
							<li><a href="index_2.html">厂家设置</a></li>
						</ul></li>
					<!-- 厂家模块 -->
					<li><a href="#"><i class="fa fa fa-globe"></i> <span
							class="nav-label">厂家</span><span class="fa arrow"></span></a>
						</li>
					<!-- 经销商管理模块 -->
					<li><a href="#"><i class="fa fa-bar-chart-o"></i> <span
							class="nav-label">经销商</span><span class="fa arrow"></span></a>
						</li>
					
				</ul>
			</div>
		</nav>
</body>
</html>