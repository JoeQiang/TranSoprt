<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<title>港荣食品订单管理系统</title>
<meta name="keywords" content="港荣食品订单管理系统">
<meta name="description" content="港荣食品订单管理系统">
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
				<%@include file="top.jsp"%>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="dataTable_wrapper">
						<div id="dataTables-example_wrapper"
							class="dataTables_wrapper dt-bootstrap no-footer">
							<div class="row">
								<div class="col-sm-6">
									<ol class="breadcrumb">
										<li><a href="#">账户</a></li>
										<li>经销商管理</li>
										<li>更新</li>
									</ol>
								</div>
							</div>
							<div class="row" style="margin-top: 20px">
								<div class="col-sm-6">
									<div class="dataTables_length" id="dataTables-example_length">
										<form
											action="${pageContext.request.contextPath }/manager/dealer/doUpdate"
											method="post">
											<input type="hidden" name="did" value="${dealer.did }">
											<input type="hidden" name="operation" value="update">
											<div class="form-group">
												<label>经销商</label> <input type="text" class="form-control"
													placeholder="经销商名称" name="dname" value="${dealer.dname }">
												<label style="color: red;"> <c:out
														value="${dnameMsg }" /></label>
											</div>
											<div class="form-group">
												<label>联系电话</label> <input type="text" class="form-control"
													placeholder="联系电话" name="phone" value="${dealer.phone }">
												<label style="color: red;"> <c:out
														value="${phoneMsg }" /></label>
											</div>
											<div class="form-group">
												<label>详细地址</label> <input type="text" class="form-control"
													placeholder="所在省市" name="province"
													value="${dealer.province }"> <label
													style="color: red;"> <c:out value="${provinceMsg }" /></label>
											</div>
											<div class="form-group">
												<label>规定到达天数</label> <input type="text"
													class="form-control" placeholder="天数" name="limitdays"
													value="${dealer.limitdays }"> <label
													style="color: red;"> <c:out
														value="${limitdaysMsg }" /></label>
											</div>
											<button class="btn btn-outline btn-primary" type="submit">更新</button>
											<a class="btn btn-outline btn-default" type="button"
												href="javascript:history.go(-1);">返回</a>
										</form>
									</div>
								</div>
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
		<script>
		
		
	</script>
</body>

</html>