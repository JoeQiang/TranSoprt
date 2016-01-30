<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<%@include file="nav.jsp"%>
		<!--侧边栏结束-->
		<!-- 搜索栏 -->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<%@include file="top.jsp" %>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="dataTable_wrapper">
						<div id="dataTables-example_wrapper"
							class="dataTables_wrapper  dt-bootstrap no-footer">
							<div class="row">
								<div class="col-sm-6">
									<ol class="breadcrumb">
										<li><a href="#">账户</a></li>
										<li>经销商管理</li>
										<li>详细</li>
									</ol>
								</div>
							</div>
							<div class="row" style="margin-top: 20px">
								<div class="col-sm-6 col-sm-offset-1">
									<h2 style="margin-bottom: 20px">
										<label>供应商信息</label>
									</h2>
									<p style="font-size: 16">
										<label>供应商:</label> <span>家好月圆</span>
									</p>
									<p style="font-size: 16">
										<label>联系电话:</label> <span>0750-5571493</span>
									</p>
									<p style="font-size: 16">
										<label>所在省市:</label> <span>广东广州</span>
									</p>
									<p style="font-size: 16">
										<label>规定到达天数:</label> <span>3</span>
									</p>
									<p>
										<a class="btn btn-outline btn-default" type="button"
											href="javascript:history.go(-1);">返回</a>
									</p>
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
			<!-- 脚部 -->
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
		<!-- 	<script>
		$(document).ready(function() {
			var pageNumber = ${pager.pageNumber };
			var totalPage = ${pager.totalPage};
			$("#next").click(function() {
				if (pageNumber != totalPage) {
					var number = pageNumber + 1;
					alert(number);
				}

			});
		});
	</script> -->
</body>

</html>