
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
								<h5>订单管理</h5>

							</div>
							<div class="ibox-content">

								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th>经销商</th>
											<th>电话号码</th>
											<th>详细地址</th>
											<th>货品数量（箱）</th>
											<th>货品种类</th>
											<th>货品规格</th>
											<th>下单时间</th>
											<th>发货后规定到达时间</th>
											<th>分配厂家</th>
										</tr>
										</tr>
									</thead>
									<tbody>
										<c:if test="${fn:length(newOrder)==0 }">
											<tr class="gradeB">
												<td>暂无未分配订单</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
										</c:if>
										<c:forEach items="${newOrder}" var="order">
											<tr class="gradeB" id="td${order.oid }">
												<td>${order.dealer.dname}</td>
												<td>${order.dealer.phone}</td>
												<td>${order.dealer.province}</td>
												<td>${order.num }</td>
												<td>${order.gname }</td>
												<td>${order.sname}</td>
											   <td><fmt:formatDate value="${order.createtime }"  type="both"  pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><select id="chaarrday${order.oid }">
														<c:forEach var="i" begin="1" end="20">
															<c:choose>
																<c:when test="${i==order.reqarrday}">
																	<option  selected = selected" value="${i }">${i }</option>
																</c:when>
																<c:otherwise>
																	<option value="${i }">${i }</option>
																</c:otherwise>
															</c:choose>

														</c:forEach>
												</select>&nbsp;天
												</td>
												<td ><select id="factory${order.oid }">
														<c:forEach items="${factorys}" var="factory">
															<option value="${factory.fid}">${factory.fname}</option>
														</c:forEach>
												</select> <a type="button" class="btn btn-warning"
													href="javascript:disfactory(${order.oid})">确定</a></td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<th>经销商</th>
											<th>电话号码</th>
											<th>详细地址</th>
											<th>货品数量（箱）</th>
											<th>货品种类</th>
											<th>货品规格</th>
											<th>下单时间</th>
											<th>发货后规定到达时间</th>
											<th>分配厂家</th>
										</tr>
									</tfoot>
								</table>

							</div>

						</div>
					</div>
				</div>

				<!--分页 -->
				<div class="col-sm-6 col-sm-offset-9">
					<div class="dataTables_paginate paging_simple_numbers"
						id="dataTables-example_paginate">
						<ul class="pagination">
							<li class="paginate_button previous" tabindex="0"
								id="dataTables-example_previous"><a
								href="${pageContext.request.contextPath }/order/distorder/<c:if test='${pager.pageNumber ge 1 }'>1</c:if>
											<c:if test='${pager.pageNumber ne 1 }'>${pager.pageNumber-1}</c:if>-${fid }">上一页</a></li>
							<c:forEach var="i" begin="1" end="${pager.totalPage }">
								<c:if test="${pager.pageNumber eq i}">
									<li class="paginate_button active disabled" tabindex="0"><a
										href="${pageContext.request.contextPath }/order/distorder/${i}"><c:out
												value="${i }" /></a></li>
								</c:if>
								<c:if test="${pager.pageNumber ne i}">
									<li class="paginate_button" tabindex="0"><a
										href="${pageContext.request.contextPath }/order/distorder/${i}">
											<c:out value="${i }" />
									</a></li>
								</c:if>
							</c:forEach>
							<li class="paginate_button next" tabindex="0"
								id="dataTables-example_next"><a id="next"
								href="${pageContext.request.contextPath }/order/distorder/<c:if test='${pager.pageNumber eq pager.totalPage }'>${pager.totalPage }</c:if>
											<c:if test='${pager.pageNumber ne pager.totalPage }'>${pager.pageNumber+1}</c:if>-${fid }">下一页</a></li>
						</ul>
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
		function disfactory(oid) {
			var fid = $("#factory" + oid).find("option:selected").val();
			var arrdays = $("#chaarrday"+oid).find("option:selected").val();
			$.ajax({
				url : '${pageContext.request.contextPath}/order/distfactory/'
						+ fid + '-' + oid+'-'+arrdays,
				type : 'GET',
				success : function(data) {
					/* alert(data); */
					if (data == 1)
						$("#td" + oid).hide();
				},
				dataType : 'json'
			});
		}

		$(document).ready(function() {
			$("table th").eq(3).css("width", "80px");
			
		});
	</script>
</body>

</html>