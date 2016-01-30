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
											<td><c:out value="${order.dealer.limitdays }" /></td>
											<td><c:out value="${order.arriveday }" /></td>
											<td><c:out value="${order.status }" /></td>
											<td><button class="btn btn-primary"
													onclick="alert('${order.oid}')">查看</button></td>
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
			<nav>
				<ul class="pagination">
					<li id="lipre"><c:if test="${pager.pageNumber ne 1}">
							<a
								href="${pageContext.request.contextPath}/factory/showOrder/${pager.pageNumber-1}-${fid}"
								aria-label="Previous"><span aria-hidden="true">上一页</span> </a>
						</c:if></li>
					<c:forEach var="i" begin="1" end="${pager.totalPage }" step="1">
						<li><a
							href="${pageContext.request.contextPath}/factory/manager/${i}-${fid}">${i}</a></li>
					</c:forEach>

					<li id="linext"><c:if
							test="${pager.pageNumber ne pager.totalPage }">
							<a
								href="${pageContext.request.contextPath}/factory/showOrder/${pager.pageNumber+1}-${fid}"
								aria-label="Next"><span aria-hidden="true">下一页</span> </a>
						</c:if></li>
				</ul>
			</nav>
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
							<h4 class="modal-title" id="myModalLabel">Modal title</h4>
						</div>
						<div class="modal-body">...</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
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
					<strong>物流跟踪系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
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


	<button type="button" onclick="hello()">点击</button>
	<script>
		/* js是一种事件驱动的语言,原生的js有个缺点是触发他必须要绑定
		html的事件才可以使用，如上,点击按钮就会调用hello()这个函数绑定了button标签的onclick事件
		代码量一大的话，有个缺点是难以找到触发事件的源*/
		function hello() {
			alert('hello！');
		}
	</script>

	<button type="button">点击</button>

	<script>
	/* jquery写法,这样的话不用显性绑定button,方便代码的维护，
	而且jquery对于html的DOM操作比原生的js容易多 */
		$(document).ready(function() {
			$("button").click(function() {
				alert('hello!');
			});
		});
	</script>



</body>

</html>