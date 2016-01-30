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
				<%@include file="top.jsp"%>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">

				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>经销商发货</h5>
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

								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th>经销商</th>
											<th>电话号码</th>
											<th>所在省市</th>
											<th>货品数量（箱）</th>
											<th>货品种类</th>
											<th>货品规格</th>
											<th>下单时间</th>
											<!-- <th>发货时间</th> -->
											<th>发货厂家</th>
											<th>发货后规定到达时间</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${fn:length(delivOrder)==0 }">
											<tr class="gradeB">
												<td>暂无未发货订单</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
										</c:if>
										<c:forEach items="${delivOrder}" var="order">
											<tr class="gradeB" id="tr${order.oid }">
												<td>${order.dealer.dname}</td>
												<td>${order.dealer.phone}</td>
												<td>${order.dealer.province}</td>
												<td>${order.num}</td>
												<td>${order.gname}</td>
												<td>${order.sname}</td>
												<td>${order.createday}</td>
												<%-- 	<td>${order.sendday}</td> --%>
												<td>${order.factoryname}</td>
												<td>${order.dealer.limitdays}天</td>
												<td>${order.status}</td>
												<td><a type="button" class="btn btn-warning"
													href="javascript:delivery(${order.oid})">发货</a></td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<th>经销商</th>
											<th>电话号码</th>
											<th>所在省市</th>
											<th>货品数量（箱）</th>
											<th>货品种类</th>
											<th>货品规格</th>
											<th>下单时间</th>
											<!-- <th>发货时间</th> -->
											<th>发货厂家</th>
											<th>发货后规定到达时间</th>
											<th>状态</th>
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
						<li id="lipre"><c:if test="${pageNum!=1}">
								<a
									href="${pageContext.request.contextPath }/order/deliveryorder/${pageNum-1}"
									aria-label="Previous">
							</c:if> <span aria-hidden="true">上一页</span> </a></li>
						<c:forEach var="i" begin="1" end="${totalPage}" step="1">
							<li><a
								href="${pageContext.request.contextPath}/order/deliveryorder/${i}">${i}</a></li>
						</c:forEach>
						<li id="linext"><c:if test="${pageNum<totalPage}">
								<a
									href="${pageContext.request.contextPath }/order/deliveryorder/${pageNum+1}"
									aria-label="Next">
							</c:if> <span aria-hidden="true">下一页</span> </a></li>
					</ul>
				</nav>
				<!-- 短信信息编辑 -->
				<div id="modal-form1" class="modal fade" aria-hidden="false">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-sm-6 b-r">
										<h2>短信额外通知：</h2>
										<div id="showsta"></div>


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

	<script>
		function delivery(oid) {
			$.ajax({
				url : '${pageContext.request.contextPath}/order/delivery/'
						+ oid,
				type : 'GET',
				success : function(data) {
					if (data == 1) {
						$("#tr" + oid).hide();
						alert("发货成功！已通知用户！");
					}
				},
				dataType : 'json'
			});
		}
	