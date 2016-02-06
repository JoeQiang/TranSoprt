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
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">
				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>公告栏内容设置</h5>

							</div>
							<div class="ibox-content">
								<textarea id="textarea" class="form-control" style="margin-bottom:3em" rows="5">${cont }</textarea>
								<div class="buttonInfo">
									<button id="btn_upd" onclick="update()" type="button"
										class="btn btn-info">发布</button>
								</div>
							</div>
						</div>
						


					</div>
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
					src="${pageContext.request.contextPath }/js/plugins/metisMenu/jquery.metisMenu.js"></script>
				<script
					src="${pageContext.request.contextPath }/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

				<!-- Custom and plugin  -->
				<script
					src="${pageContext.request.contextPath }/js/hplus.js?v=2.2.0"></script>
				<script
					src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>

				<script>
					
					function update() {
						var content = $("textarea").val();
						$.ajax({
							url : '${pageContext.request.contextPath}/public/update',
							data : {
							 'content' : content },
							type : 'post',
							dataType : 'json',
							success : function(data) {
							alert("更新成功！");
							}
						});
					}
					
				</script>
</body>

</html>