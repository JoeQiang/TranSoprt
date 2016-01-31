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
							class="dataTables_wrapper form-inline dt-bootstrap no-footer">
							<div class="row">
								<div class="col-sm-6">
									<ol class="breadcrumb">
										<li><a href="#">账户</a></li>
										<li class="active">经销商管理</li>
									</ol>
								</div>
							</div>
							<div class="row" style="margin-top: 20px">
								<div class="col-sm-6">
									<div class="dataTables_length" id="dataTables-example_length">
										<!-- <label>显示 <select id="show"
											name="dataTables-example_length"
											class="form-control input-sm">
												<option value="10"></option>
												<option value="10">10</option>
												<option value="25">25</option>
												<option value="50">50</option>
												<option value="100">100</option>
										</select> 记录
										</label> -->
									</div>
								</div>

								<div class="col-sm-6">
									<div id="dataTables-example_filter" class="dataTables_filter">
										<a
											href="${pageContext.request.contextPath }/manager/dealer/insert_page"
											type="button" class="btn btn-outline btn-primary"
											style="float: right; margin-right: 40px" role="button">新增</a>
									</div>
								</div>
							</div>
							<div class="row" style="margin: 10px">
								<div class="col-sm-12">
									<table
										class="table table-striped table-bordered table-hover dataTable no-footer"
										id="dataTables-example" role="grid">
										<thead>
											<tr role="row">
												<th class="sorting" tabindex="0" rowspan="1" colspan="1">经销商</th>
												<th class="sorting" tabindex="0" rowspan="1" colspan="1">联系号码</th>
												<th class="sorting" tabindex="0" rowspan="1" colspan="1">所在省市</th>
												<th class="sorting" tabindex="0" rowspan="1" colspan="1">规定到达天数</th>
												<th tabindex="0" rowspan="1" colspan="1">操作</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty pager.list }">
												<tr>
													<td colspan="5">暂无经销商记录！</td>
												</tr>
											</c:if>
											<c:if test="${!empty pager.list }">

												<c:forEach items="${pager.list }" var="dealer">
													<tr class="gradeA odd" role="row">
														<td><c:out value="${dealer.dname }" /></td>
														<td class="center">${dealer.phone }</td>
														<td class="center">${dealer.province }</td>
														<td class="center">${dealer.limitdays }</td>
														<td class="center">
															<div class="dropdown">
																<button type="button"
																	class="btn dropdown-toggle btn-circle btn-primary"
																	id="dropdownMenu1" data-toggle="dropdown">
																	<i class="fa fa-list"></i>
																</button>
																<ul class="dropdown-menu" role="menu" style="width:20px">
																	<li role="presentation"><a role="menuitem"
																		tabindex="-1"
																		href="${pageContext.request.contextPath }/manager/dealer/detial?did=${dealer.did}"><i
																			class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;查看</a></li>
																	<li role="presentation"><a role="menuitem"
																		tabindex="-1"
																		href="${pageContext.request.contextPath }/manager/dealer/update?did=${dealer.did}"><i
																			class="fa fa-file-text-o"></i>&nbsp;&nbsp;&nbsp;修改</a></li>
																	<li role="presentation"><a role="menuitem"
																		tabindex="-1" id="item"
																		onclick="deleteItem('${pageContext.request.contextPath }/manager/dealer/delete?did=${dealer.did}')">
																			<input type="hidden" id="url_delete" value="">
																			<i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;删除
																	</a></li>
																	<li role="presentation" class="divider"></li>
																</ul>
															</div>
														</td>
													</tr>
												</c:forEach>

											</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6">
									<div class="dataTables_info" id="dataTables-example_info"
										role="status" aria-live="polite">
										总记录&nbsp;&nbsp; <span class="text-primary"><c:out
												value="${pager.totalRow }" /></span>&nbsp;&nbsp;条
									</div>
								</div>
								<div class="col-sm-6">
									<div class="dataTables_paginate paging_simple_numbers"
										id="dataTables-example_paginate">
										<ul class="pagination">
											<li class="paginate_button previous" tabindex="0"
												id="dataTables-example_previous"><a
												href="${pageContext.request.contextPath }/manager/dealer/${pager.pageNumber-1}">上一页</a></li>
											<c:forEach var="i" begin="1" end="${pager.totalPage }">
												<c:if test="${pager.pageNumber eq i}">
													<li class="paginate_button active disabled" tabindex="0"><a
														href="${pageContext.request.contextPath }/manager/dealer"><c:out
																value="${i }" /></a></li>
												</c:if>
												<c:if test="${pager.pageNumber ne i}">
													<li class="paginate_button" tabindex="0"><a
														href="${pageContext.request.contextPath }/manager/dealer/${i}">
															<c:out value="${i }" />
													</a></li>
												</c:if>
											</c:forEach>
											<li class="paginate_button next" tabindex="0"
												id="dataTables-example_next"><a id="next"
												href="${pageContext.request.contextPath }/manager/dealer/<c:if test='${pager.pageNumber eq pager.totalPage }'>${pager.totalPage }</c:if>
											<c:if test='${pager.pageNumber ne pager.totalPage }'>${pager.pageNumber+1}</c:if>">下一页</a></li>
										</ul>
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

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					确定要删除
					<c:out value="${dealer.dname }" />
					这条记录信息？
				</div>
				<div class="modal-footer">
					<button id="delete" type="button" class="btn btn-primary">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->




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
			function deleteItem(url) {
				/* alert(url); */
				$('#myModal').modal('toggle');
				$('#delete').click(function() {
					location.href = url;
				});
			}
		</script>
</body>

</html>