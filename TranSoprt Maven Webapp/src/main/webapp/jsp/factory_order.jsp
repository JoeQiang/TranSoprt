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
								<h5>厂家订单</h5>
							</div>
							<div class="ibox-content">
								<form class="form-inline"
									action="${pageContext.request.contextPath}/factory/search"
									method="post">
									<input type="hidden" name="fid" value="${fid }">
									<div class="col-sm-2">
										<select name="option" id="option" class="form-control"
											required="">
											<option value="">条件查询</option>
											<option value="4">地域查询</option>
											<option value="5">货品数量查询</option>
											<option value="6">品类查询</option>
											<option value="7">规格查询</option>
											<option value="8">状态查询</option>
											<option value="9">订单编号查询</option>
										</select>
									</div>
									<input id="search" name="search" type="text"
										placeholder="请选择查询条件" class="form-control" required="" />
									<button type="submit" class="btn btn-info">筛选</button>
								</form>
								<form
									action="${pageContext.request.contextPath}/factory/filterDay"
									method="post" class="form-inline">
									<input type="hidden" name="fid" value="${fid }">
									<div class="col-sm-2">
										<select name="dateType" id="option" class="form-control"
											required="">
											<option value="">时间查询</option>
											<option value="1">按下单时间查询</option>
											<option value="2">按发货时间查询</option>
										</select>
									</div>
									<input name="begin" type="date" placeholder="起始时间"
										class="form-control" required="" /> <label>-</label> <input
										style="display: inline;" name="end" type="date"
										placeholder="结束时间" class="form-control" required="" />
									<button type="submit" class="btn btn-primary">查询</button>
									<button type="button" class="btn btn-warning" onclick="dow()">数据下载</button>
								</form>

							</div>
							<form id="download"
								action="${pageContext.request.contextPath}/factory/excelOrder"
								method="post" onsubmit="return checkSelect()"
								style="display: inline;">
								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th><input id="CheckAll" type="checkbox"
												class="form-control"></th>
											<th>序号</th>
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
											<th>状态</th>
											<!-- <th>操作</th> -->
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty list}">
											<tr class="gradeB">
												<td colspan="13">暂无订单</td>
											</tr>
										</c:if>
										<c:if test="${!empty list }">
											<c:forEach items="${list }" var="order">
												<tr>
													<td><input name="select" type="checkbox"
														class="form-control" value="${order.oid }"></td>
													<td>${order.seqnum}</td>
													<td><c:out value="${order.dealer.dname}" /></td>
													<td><c:out value="${order.dealer.phone}" /></td>
													<td><c:out value="${order.dealer.province}" /></td>
													<td><c:out value="${order.num }" /></td>
													<td><c:out value="${order.gname }" /></td>
													<td><c:out value="${order.sname }" /></td>
													<td><c:out value="${order.createtime}" /></td>
													<td><c:out value="${order.sendday}" /></td>
													<td><c:out value="${order.factoryname }" /></td>
													<td><c:out value="${order.reqarrday}" />天</td>
													<td><c:out value="${order.status }" /></td>
												</tr>
											</c:forEach>
										</c:if>

									</tbody>
									<tfoot>
										<tr>
											<th>&nbsp;&nbsp;&nbsp;</th>
											<th>序号</th>
											<th>经销商</th>
											<th>电话号码</th>
											<th>所在省市</th>
											<th>货品数量(箱)</th>
											<th>货品品类</th>
											<th>货品规格</th>
											<th>下单时间</th>
											<th>发货时间</th>
											<th>发货厂家</th>
											<th>规定到达时间</th>
											<th>状态</th>
											<!-- <th>操作</th> -->
										</tr>
									</tfoot>
								</table>
							</form>
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
		src="${pageContext.request.contextPath }/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script
		src="${pageContext.request.contextPath }/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

	<!-- Custom and plugin  -->
	<script src="${pageContext.request.contextPath }/js/hplus.js?v=2.2.0"></script>
	<script
		src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>
	<script>
		/* 检查是有选择订单 */
		function checkSelect() {
			var flag = $("[name=select]:checkbox").is(':checked');
			if (!flag) {
				alert("请选择需要导出订单");
				return false;
			}
			return true;
		}

		/* 	function checkSearch() {
				alert("Hello:" + $('#option option:selected').val());
				var selectIndex = $("#option").get(0).selectedIndex;
				return false;
			} */

		$(document).ready(function() {
			
			$("#option").change(function() {
				var selectIndex = $("#option").get(0).selectedIndex;
				if (selectIndex == 1) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入需要查询的地域'
					});
				} else if (selectIndex == 2) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入货品数量进行查询'
					});
				} else if (selectIndex == 3) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入货品品类进行查询'
					});
				} else if (selectIndex == 4) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入货品规格进行查询'
					});
				} else if (selectIndex == 5) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入状态进行查询'
					});
				} else if (selectIndex == 6) {
					$('#search').attr({
						'type' : 'text',
						'placeholder' : '请输入订单编号进行查询'
					});
				}
			});
		});

		/* 全选所有订单*/
		$(function() {
			$("#CheckAll").click(function() {
				var flag = $("#CheckAll").is(':checked');
				$("[name=select]:checkbox").each(function() {
					/* $(this).attr("checked", flag); */
					$("[name=select]:checkbox").prop("checked", flag);
				});
			});
		});
		function dow() {
			$('#download').submit();
		}
	</script>
</body>

</html>