<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>港荣食品物流跟踪系统</title>
<meta name="keywords" content="港荣食品物流跟踪系统">
<meta name="description" content="港荣食品物流跟踪系统">

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
			<div class="row wrapper border-bottom white-bg page-heading">

				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>厂家订单</h5>
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
									<div class="col-sm-2">
										<select class="form-control">
											<option>全部</option>
											<option>未发货</option>
											<option>运输中</option>
											<option>已完成</option>
										</select>
									</div>
									<div class="col-sm-3">
										<a href="" class="btn btn-primary">查询</a>
									</div>
								</div>
								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th><input type="checkbox" class="form-control">
											</th>
											<th>经销商</th>
											<th>电话号码</th>
											<th>所在省市</th>
											<th>货物详情</th>
											<th>下单时间</th>
											<th>发货时间</th>
											<th>发货厂家</th>
											<th>规定到达时间</th>
											<th>到货时间</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty pager.list}">
											<tr class="gradeB">
												<td colspan="13">暂无未分配订单</td>
											</tr>
										</c:if>
										<c:if test="${!empty pager.list }">
											<c:forEach items="${pager.list }" var="order">
												<tr>
													<td><input type="checkbox" class="form-control"
														value="${order.oid }"></td>
													<td><c:out value="${order.dealer.dname}" /></td>
													<td><c:out value="${order.dealer.phone}" /></td>
													<td><c:out value="${order.dealer.province}" /></td>
													<td><c:forEach items="${order.goodsList}" var="goods">
															<div>名称：${goods.gname}，数量：${goods.num}，规格：${goods.sname }</div>
														</c:forEach></td>
													<td><c:out value="${order.createday}" /></td>
													<td><c:out value="${order.sendday}" /></td>
													<td><c:out value="${order.factoryname }" /></td>
													<td><c:out value="${order.dealer.limitdays }" /></td>
													<td><c:out value="${order.arriveday }" /></td>
													<td><c:out value="${order.stauts }" /></td>
													<td><a href="" class="btn btn-primary">查看</a></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
									<tfoot>
										<tr>
											<th>&nbsp;&nbsp;&nbsp;</th>
											<th>经销商</th>
											<th>电话号码</th>
											<th>所在省市</th>
											<th>货物详情</th>
											<th>下单时间</th>
											<th>发货时间</th>
											<th>发货厂家</th>
											<th>规定到达时间</th>
											<th>到货时间</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</tfoot>
								</table>

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
					<strong>物流跟踪系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
				</div>
			</div>

		</div>
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

</body>

</html>