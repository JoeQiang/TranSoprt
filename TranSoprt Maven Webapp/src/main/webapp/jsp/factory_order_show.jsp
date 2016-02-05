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
						<div class="ibox float-e-margins"></div>
						<table class="table table-striped table-bordered table-hover "
							id="editable">
							<thead>
								<tr>
									<th>经销商</th>
									<th>电话号码</th>
									<th>所在省市</th>
									<th>货品数量</th>
									<th>货品品类</th>
									<th>货品规格</th>
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
										<td colspan="13">暂无订单</td>
									</tr>
								</c:if>
								<c:if test="${!empty pager.list }">
									<c:forEach items="${pager.list }" var="order">
										<tr>
											<td><c:out value="${order.dealer.dname}" /></td>
											<td><c:out value="${order.dealer.phone}" /></td>
											<td><c:out value="${order.dealer.province}" /></td>
											<td><c:out value="${order.num }" /></td>
											<td><c:out value="${order.gname }" /></td>
											<td><c:out value="${order.sname }" /></td>
											<td><c:out value="${order.createday}" /></td>
											<td><c:out value="${order.sendday}" /></td>
											<td><c:out value="${order.factoryname }" /></td>
											<td><c:out value="${order.reqarrday}" /></td>
											<td><c:out value="${order.arriveday }" /></td>
											<td><c:out value="${order.status }" /></td>
											<td><button class="btn btn-primary"
													onclick="getInfo(${order.oid})">查看</button></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
							<tfoot>
								<tr>
									<th>经销商</th>
									<th>电话号码</th>
									<th>所在省市</th>
									<th>货品数量</th>
									<th>货品品类</th>
									<th>货品规格</th>
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
			<div class="row">
				<div class="col-sm-6 col-sm-offset-9">
					<div class="dataTables_paginate paging_simple_numbers"
						id="dataTables-example_paginate">
						<ul class="pagination">
							<li class="paginate_button previous" tabindex="0"
								id="dataTables-example_previous"><a
								href="${pageContext.request.contextPath }/factory/showOrder/<c:if test='${pager.pageNumber ge 1 }'>1</c:if>
											<c:if test='${pager.pageNumber ne 1 }'>${pager.pageNumber-1}</c:if>-${fid }">上一页</a></li>
							<c:forEach var="i" begin="1" end="${pager.totalPage }">
								<c:if test="${pager.pageNumber eq i}">
									<li class="paginate_button active disabled" tabindex="0"><a
										href="${pageContext.request.contextPath }/factory/showOrder/${i}-${fid }"><c:out
												value="${i }" /></a></li>
								</c:if>
								<c:if test="${pager.pageNumber ne i}">
									<li class="paginate_button" tabindex="0"><a
										href="${pageContext.request.contextPath }/factory/showOrder/${i}-${fid }">
											<c:out value="${i }" />
									</a></li>
								</c:if>
							</c:forEach>
							<li class="paginate_button next" tabindex="0"
								id="dataTables-example_next"><a id="next"
								href="${pageContext.request.contextPath }/factory/showOrder/<c:if test='${pager.pageNumber eq pager.totalPage }'>${pager.totalPage }</c:if>
											<c:if test='${pager.pageNumber ne pager.totalPage }'>${pager.pageNumber+1}</c:if>-${fid }">下一页</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- 内容主体结束 -->

			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">经销商信息</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-sm-2">
									<label>经销商:</label>
								</div>
								<div class="col-sm-4">
									<p id="dname">经销商1</p>
								</div>
								<div class="col-sm-2">
									<label>电话号码:</label>
								</div>
								<div class="col-sm-4">
									<p id="dphone">18826243710</p>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<label>所在省市:</label>
								</div>
								<div class="col-sm-4">
									<p id="province">广东广州</p>
								</div>
								<div class="col-sm-2">
									<label>货品详情:</label>
								</div>
								<div class="col-sm-4">
									<p>
										货品:<span id="gname">鸡蛋</span>,规格:<span id="sname">1kg</span>,数量:<span
											id="num">11</span>
									</p>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<label>下单时间:</label>
								</div>
								<div class="col-sm-4">
									<p id="createday">2016-01-18</p>
								</div>
								<div class="col-sm-2">
									<label>发货时间:</label>
								</div>
								<div class="col-sm-4">
									<p id="sendday">2016-01-18</p>
								</div>
								<div class="col-sm-2">
									<label>到货时间:</label>
								</div>
								<div class="col-sm-4">
									<p id="arriveday">2016-01-18</p>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<label>发货厂家:</label>
								</div>
								<div class="col-sm-4">
									<p id="fname">广东广州</p>
								</div>
								<div class="col-sm-3">
									<label>规定到达时间:</label>
								</div>
								<div class="col-sm-2">
									<p id="limitday"></p>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">确定</button>
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
		function getInfo(oid) {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/factory/getOrderInfo',
						data : {
							'oid' : oid
						},
						dataType : 'json',
						error : function(xhr) {
							alert("错误提示： " + xhr.status + " " + xhr.statusText);
						},
						success : function(data) {

							var result = eval(data);
							var order = result.order;
							//添加经销商名称
							$('#dname').html(order.dealer.dname);
							//添加经销商电话
							$('#dphone').html(order.dealer.phone);
							//添加经销商省市
							$('#province').html(order.dealer.province);
							//添加货品名称
							$('#gname').html(order.gname);
							//添加货品数量
							$('#num').html(order.num);
							//添加货品规格
							$('#sname').html(order.sname);
							//添加下单时间
							$('#createday').html(order.createday);
							//添加发货时间
							$('#sendday').html(order.sendday);
							//添加到货时间
							$('#arriveday').html(order.arriveday);
							//添加发货厂家
							$('#fname').html(order.factoryname);
							//添加限制天数
							$('#limitday').html(order.dealer.limitdays);
							//弹出模态框
							$('#myModal').modal('show');

							console.log(result);

						}
					});
		}
	</script>

</body>

</html>