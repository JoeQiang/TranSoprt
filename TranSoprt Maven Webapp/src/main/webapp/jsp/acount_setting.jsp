<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<title>港荣订单管理系统</title>
<meta name="keywords" content="港荣订单管理系统">
<meta name="description" content="港荣订单管理系统">

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
						<div class="row">
							<div class="col-lg-12">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5>厂家设置</h5>
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
										<div class="">
											<a data-toggle="modal" data-target="#myModal1"
												class="btn btn-primary">新增</a>
										</div>
										<table class="table table-striped table-bordered table-hover "
											id="editable">
											<thead>
												<tr>
													<th>厂家帐号</th>
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
															<td style="width: 200px"><button data-toggle="modal"
																	data-target="#myModal2" class="btn btn-primary"
																	onclick="getInfo(${factory.fid })">修改</button></td>
														</tr>
													</c:forEach>
												</c:if>
											</tbody>
											<tfoot>
												<tr>
													<th>厂家账户</th>
													<th>操作</th>

												</tr>
											</tfoot>
										</table>

									</div>
								</div>
							</div>
						</div>
						<!--分页 -->
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

					<!-- 内容主体结束 -->

					<!-- 模态框（Modal） -->
					<!-- 新增厂家 -->
					<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">新增厂家</h4>
								</div>
								<form id="saveform" method="post">
									<div class="modal-body">
										<div class="form-group">
											<label>厂家账号</label> <input id="fname" class="form-control"
												type="text" placeholder="请输入厂家账号" required="">
											<p class="help-block">厂家以后登陆系统使用的账号</p>
										</div>
										<div class="form-group">
											<label>厂家密码</label> <input id="fpwd" class="form-control"
												type="password" placeholder="请输入厂家密码" required="">
											<p class="help-block">厂家以后登陆系统密码</p>
										</div>
										<div class="form-group">
											<label>重新输入</label> <input id="rpwd" class="form-control"
												type="password" placeholder="再次输入密码" required="">
											<p class="help-block">再次输入密码确认</p>
										</div>
										<label style="color:red;" id="msg"></label>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary" id="savebtn">新增</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">返回</button>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- 修改厂家信息 -->
						<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">修改厂家信息</h4>
									</div>
									<form>
										<div class="modal-body">
											<div class="form-group">
												<input id="ufid" type="hidden" value=""> <label>厂家账号</label>
												<input id="ufname" class="form-control" type="text"
													placeholder="请输入厂家账号">
												<p class="help-block">厂家以后登陆系统使用的账号</p>
											</div>
											<div class="form-group">
												<label>厂家密码</label> <input id="ufpwd" class="form-control"
													type="password" placeholder="请输入新密码">
												<p class="help-block">厂家以后登陆系统密码</p>
											</div>
											<div class="form-group">
												<label>重新输入密码</label> <input id="urpwd" class="form-control"
													type="password" placeholder="再次输入新密码">
												<p class="help-block">再次输入密码确认</p>
											</div>
											<label id="umsg" style="color: red"></label>
										</div>
										<div class="modal-footer">
											<button type="button" onclick="doUpadat()"
												class="btn btn-primary">更新</button>
											<button type="button" class="btn btn-default"
												data-dismiss="modal">返回</button>

										</div>
									</form>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
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
				</div>
			</div>
		</div>
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
		$(document).ready(function() {
			$('#savebtn').click(function() {
				save();
			});
		});
		function save() {
			if (check()) {
				savefactory();
			}
		}
		function savefactory() {
			$
					.ajax({
						url : '${pageContext.request.contextPath }/factory/saveFactory',
						dataType : 'json',
						type : 'POST',
						data : {
							fname : $('#fname').val(),
							fpwd : $('#fpwd').val(),
						},
						beforeSend : function() {
							$('#msg').html('录入中...请稍等');
						},
						success : function(data) {
							var json = eval(data);
							var flag = json.info;
							if (flag === true) {
								$('#msg').html('录入成功！');
								location.href = "${pageContext.request.contextPath}/factory/setting/1";
								$('#myModal1').modal('hide');
							} else {
								$('#msg').html('录入失败！');
							}
							console.log(data);
						}
					});
		}
		function check() {
			if ($('#fname').val() == '') {
				$('#msg').html('厂家帐号不能为空');
				$('fname').focus();
				return false;
			}
			if ($('#fpwd').val() == '') {
				$('#msg').html('登录密码不能为空');
				$('fpwd').focus();
				return false;
			}
			if ($('#rpwd').val() != $('#fpwd').val()) {
				$('#msg').html('两次输入密码必须一致');
				return false;
			}
			return true;
		}
		function checkUpdate() {
			if ($('#ufname').val() == '') {
				$('#umsg').html('厂家帐号不能为空');
				$('ufname').focus();
				return false;
			}
			if ($('#ufpwd').val() == '') {
				$('#umsg').html('登录密码不能为空');
				$('ufpwd').focus();
				return false;
			}
			if ($('#urpwd').val() != $('#ufpwd').val()) {
				$('#umsg').html('两次输入密码必须一致');
				return false;
			}
			return true;
		}
		function getInfo(fid) {
			var key = fid;
			$
					.ajax({
						url : '${pageContext.request.contextPath}/factory/getFactoryById',
						type : 'POST',
						data : {
							fid : key
						},
						dataType : 'json',
						success : function(data) {
							console.log(data);
							var obj = eval(data);
							$('#ufname').val(obj.fname);
							$('#ufid').val(obj.fid);
						}
					});
		}

		function doUpadat() {
			if (checkUpdate()) {

				$
						.ajax({
							url : '${pageContext.request.contextPath}/factory/updateFactory',
							data : {
								fid : $('#ufid').val(),
								fname : $('#ufname').val(),
								fpwd : $('#ufpwd').val()
							},
							type : 'POST',
							beforeSend : function() {
								$('#umsg').html('正在修改...');
							},
							success : function(data) {
								var json = eval(data);
								var flag = json.info;
								if (flag === true) {
									$('#umsg').html('修改成功！');
									location.href = "${pageContext.request.contextPath}/factory/setting/1";
									$('#myModal2').modal('hide');
								} else {
									$('#umsg').html('修改失败！');
								}
								console.log(data);
							}
						});
			}
		}
	</script>
</body>

</html>