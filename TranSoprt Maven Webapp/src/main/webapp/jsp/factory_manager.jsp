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
								<h5>厂家</h5>
								
							</div>
							<div class="ibox-content">

								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th>厂家</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty pager.list }">
											<tr>
												<td colspan="2">暂无厂家</td>
											</tr>
										</c:if>
										<c:if test="${!empty pager.list }">
											<c:forEach items="${pager.list }" var="factory">
												<tr>
													<td><c:out value="${factory.fname }" /></td>
													<td style="width: 200px"><a class="btn btn-primary"
														href="${pageContext.request.contextPath }/factory/order/${factory.fid}">查看所有订单</a></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
									<tfoot>
										<tr>
											<th>厂家</th>
											<th>操作</th>
										</tr>
									</tfoot>
								</table>

							</div>
						</div>
					</div>
				</div>
				<!--分页 -->

				<nav>
					<ul class="pagination">
						<li id="lipre"><c:if test="${pager.pageNumber ne 1}">
								<a
									href="${pageContext.request.contextPath}/factory/manager/${pager.pageNumber-1}"
									aria-label="Previous"><span aria-hidden="true">上一页</span> </a>
							</c:if></li>
						<c:forEach var="i" begin="1" end="${pager.totalPage }" step="1">
							<li><a
								href="${pageContext.request.contextPath}/factory/manager/${i}">${i}</a></li>
						</c:forEach>

						<li id="linext"><c:if
								test="${pager.pageNumber ne pager.totalPage }">
								<a
									href="${pageContext.request.contextPath}/factory/manager/${pager.pageNumber+1}"
									aria-label="Next"><span aria-hidden="true">下一页</span> </a>
							</c:if></li>
					</ul>
				</nav>
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
		src="${pageContext.request.contextPath }/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script
		src="${pageContext.request.contextPath }/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

	<!-- Custom and plugin  -->
	<script src="${pageContext.request.contextPath }/js/hplus.js?v=2.2.0"></script>
	<script
		src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>

	<script>
		$(document).ready(function() {

			var li_id = '${li_id}';
			$("#" + li_id).addClass("active");
			if (li_id == "li_factory_order" || li_id == "li_dealer_order") {
				$("#li_account").removeClass("active");
			}
		});
	</script>
</body>

</html>