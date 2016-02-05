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
<style>
.staspan {
	margin: 10px;
}
</style>
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
			<!-- 内容主体 -->
			<div class="row wrapper border-bottom white-bg page-heading">
				<div>
					<div>
						<div>
							<div class="row">
								<div class="col-lg-12">
									<div class="ibox float-e-margins">
										<div class="ibox-title">
											<h5>商品管理</h5>

										</div>
										<div class="ibox-content">
											<div class="">
												<a data-toggle="modal" onclick="addgoods()"
													class="btn btn-primary"> 添加商品</a> <a data-toggle="modal"
													class="btn btn-primary" href="#modal-form2"> 添加规格</a> <a
													data-toggle="modal" onclick="showsta()"
													class="btn btn-primary">删除规格</a>
											</div>

											<table
												class="table table-striped table-bordered table-hover "
												id="editable">
												<thead>
													<tr>
														<th>商品名称</th>
														<th>商品规格</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${fn:length(goodslist)==0 }">
														<tr class="gradeB">
															<td colspan="7">您还未添加任何商品</td>
													</c:if>
													<c:forEach items="${goodslist}" var="goods">
														<tr class="gradeB" id="tr${goods.gid}">
															<td>${goods.gname}</td>
															<td><c:forEach items="${goods.standard}" var="sd">
																	<div id="div${goods.gid}${sd.sid }">
																		${sd.sname}&nbsp;</div>
																</c:forEach></td>
															<td><a type="button" class="btn btn-danger"
																href="javascript:delGoods(${goods.gid})">删除</a> <a
																type="button" class="btn btn-warning"
																href="javascript:updGoods(${goods.gid},'${goods.gname}')">修改</a>
															</td>
														</tr>
													</c:forEach>
												</tbody>
												<tfoot>
													<tr>
														<th>商品名称</th>
														<th>商品规格</th>
														<th>操作</th>

													</tr>
												</tfoot>
											</table>

										</div>
									</div>
								</div>
							</div>
							<!--分页 -->
							<nav style="float:right;margin-right: 100px">
								<ul class="pagination">
									<li id="lipre"><c:if test="${pageNum!=1}">
											<a
												href="${pageContext.request.contextPath }/goods/list/${pageNum-1}"
												aria-label="Previous">
										</c:if> <span aria-hidden="true">上一页</span> </a></li>
									<c:forEach var="i" begin="1" end="${totalPage}" step="1">
										<li><a
											href="${pageContext.request.contextPath}/goods/list/${i}">${i}</a>
										</li>
									</c:forEach>
									<li id="linext"><c:if test="${pageNum<totalPage}">
											<a
												href="${pageContext.request.contextPath }/goods/list/${pageNum+1}"
												aria-label="Next">
										</c:if> <span aria-hidden="true">下一页</span> </a></li>
								</ul>
							</nav>
							<!-- 新增商品表单 -->
							<div id="modal-form1" class="modal fade" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body">
											<div class="row">
												<h3 class="m-t-none m-b">新增商品</h3>

												<form role="form"
													action="${pageContext.request.contextPath}/goods/addgoods"
													method="post">
													<div class="form-group">
														<label>商品名称：</label> <input type="text" name="gname"
															placeholder="请输入商品名称" class="form-control">
													</div>

													<div class="hr-line-dashed"></div>
													<div class="form-group">
														<label class="col-sm-2 control-label">重量规格:</label>

														<div id="divgetsta" class="col-sm-9">
															<!-- 多选框 -->
															<!-- <label class="checkbox-inline i-checks"> <input
															type="checkbox" value="1" name="weight">1800g
														</label> -->
														</div>
													</div>
											</div>
											<div>
												<button class="btn btn-sm btn-primary pull-right m-t-n-xs"
													type="submit">
													<strong>添加</strong>
												</button>

											</div>
											</form>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 修改商品表单 -->
					<div id="modal-form4" class="modal fade" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-body">
									<div class="row">
										<!-- <div class="col-sm-6 b-r"> -->
										<h3 class="m-t-none m-b">修改商品</h3>

										<form role="form" id="updform"
											<%-- action="${pageContext.request.contextPath}/goods/updgoods?gid" --%>
											method="post">
											<div class="form-group">
												<label>商品名称：</label> <input type="text" id="ingname"
													name="gname" class="form-control">
											</div>

											<div class="hr-line-dashed"></div>
											<div class="form-group">
												<label class="col-sm-2 control-label">重量规格:</label>

												<div class="col-sm-10">
													<div id="divgetsta1" class="col-sm-10">

														<!-- <label class="checkbox-inline i-checks"> <input
															type="checkbox" value="1" name="weight">800g 
														</label>-->
													</div>
												</div>
											</div>
											<div>
												<button class="btn btn-sm btn-primary pull-right m-t-n-xs"
													type="submit">
													<strong>修改</strong>
												</button>

											</div>
										</form>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
				<!--增加商品规格 -->
				<div id="modal-form2" class="modal fade" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div>
										<h3 class="m-t-none m-b">新增规格</h3>

										<form role="form"
											action="${pageContext.request.contextPath}/goods/addsta"
											method="post">
											<div class="form-group">
												<label>商品规格：</label> <input type="text" name="sname"
													placeholder="请输入商品规格，如：1Kg" class="form-control">
											</div>
											<div>
												<button class="btn btn-sm btn-primary pull-right m-t-n-xs"
													type="submit">
													<strong>添加</strong>
												</button>

											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 删除规格 -->
				<div id="modal-form3" class="modal fade" aria-hidden="false">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div>
										<h2>商品规格：</h2>
										<div id="showsta"></div>


									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 触发标签 -->
				<a data-toggle="modal" id="aid1" href="#modal-form1"></a> <a
					data-toggle="modal" id="aid4" href="#modal-form4"></a> <a
					data-toggle="modal" id="aid3" href="#modal-form3"></a>
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
		<!-- 脚部结束 -->
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

	<!-- iCheck -->
	<script
		src="${pageContext.request.contextPath }/js/plugins/iCheck/icheck.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.i-checks').iCheck({
				checkboxClass : 'icheckbox_square-green',
				radioClass : 'iradio_square-green',
			});

			
		});
		function delGoods(gid) {
			if (window.confirm('确定要删除该商品吗？')) {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/goods/delete/'
							+ gid,
					success : function(data) {
						$("#tr" + gid).hide();
					},
					dataType : 'json'
				});
			}
		}
		function delSta(gid, sid) {
			if (window.confirm('确定要删除该规格吗？')) {
				$.ajax({
					type : 'GET',
					url : '${pageContext.request.contextPath}/goods/delsta/'
							+ gid + "-" + sid,
					success : function(data) {
						$("#div" + gid + sid).hide();
						/* alert(data); */
					},
					dataType : 'json'
				});
			}
		}
		function showsta() {
			$
					.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/goods/getallsta',
						success : function(data) {

							$("#showsta").html("");
							for (i = 0; i < data.length; i++) {
								$("#showsta")
										.append(
												"<span style='margin:5dp' class='staspan' id=divsid"+data[i].sid+">"
														+ data[i].sname
														+ "<a onclick=delGroblSta("
														+ data[i].sid
														+ ")><img width='15dp'  src='${pageContext.request.contextPath}/img/close.png'/></a></span>");
							}
							$("#aid3").click();
						},
						dataType : 'json'
					});
		}
		function delGroblSta(sid) {
			if (window.confirm('确定要删除该规格吗？')) {
				$
						.ajax({
							type : 'GET',
							url : '${pageContext.request.contextPath}/goods/delgroblesta/'
									+ sid,
							success : function(data) {
								if (data == 1)
									$("#divsid" + sid).hide();

							},
							dataType : 'json'
						});
			}
		}
		function addgoods() {
			$
					.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/goods/getallsta',
						success : function(data) {
							$("#divgetsta").html("");
							for (i = 0; i < data.length; i++) {
								$("#divgetsta")
										.append(
												"<label class='checkbox-inline i-checks'> <input type='checkbox'  value='"+data[i].sid+"' name='weight'>"
														+ data[i].sname
														+ "</label> ");
							}
							/* 让多选框再次应用css */
							$('.i-checks').iCheck({
								checkboxClass : 'icheckbox_square-green',
								radioClass : 'iradio_square-green',
							});
							$("#aid1").click();
						},
						dataType : 'json'
					});
		}
		/* 修改商品 */
		function updGoods(gid, gname) {
			var allsta;
			$("#ingname").val(gname);//显示原来商品名称
			//查询所有的规格
			$
					.ajax({
						type : 'GET',
						url : '${pageContext.request.contextPath}/goods/getallsta',
						success : function(data) {
							$("#divgetsta1").html("");

							var j = 0;
							for (i = 0; i < data.length; i++) {
								$("#divgetsta1")
										.append(
												"<label class='checkbox-inline i-checks '> <input id='updchebox"+j+"' type='checkbox' value='"+data[i].sid+"' name='weight'>"
														+ data[i].sname
														+ "</label> ");
								j++;
							}
							/* 让多选框再次应用css */
							$('.i-checks').iCheck({
								checkboxClass : 'icheckbox_square-green',
								radioClass : 'iradio_square-green',
							});
							allsta = j;
						},
						dataType : 'json'
					});
			//查询本商品有的规格
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/goods/getstabygid/'
						+ gid,
				success : function(data) {
					//返回的是一个goods对象

					var stalist = data.standard;
					for (i = 0; i < stalist.length; i++)
						for (j = 0; j < allsta; j++) {
							if ($("#updchebox" + j).val() == stalist[i].sid) {
								$("#updchebox" + j).attr("checked", "true");
							}
						}
					/* 让多选框再次应用css */
					$('.i-checks').iCheck({
						checkboxClass : 'icheckbox_square-green',
						radioClass : 'iradio_square-green',
					});
					$("#updform").attr(
							"action",
							"${pageContext.request.contextPath}/goods/updgoods?gid="
									+ gid + "&page=${pageNum}");
				},
				dataType : 'json'
			});
			$("#aid4").click();
		}
	</script>
</body>

</html>