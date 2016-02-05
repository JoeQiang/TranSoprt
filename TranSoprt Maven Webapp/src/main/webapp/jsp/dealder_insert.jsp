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
	href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css?v=4.3.0"
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
				<!-- 导航条 -->

				<div class="row" style="margin-top: 20px">
					<div class="col-sm-8">

						<div class="form-group">
							<label>新增经销商</label> <select id="select" name="type"
								class="form-control" required="">
								<option value="">选择新增方式</option>
								<option value="">Excel导入</option>
								<option value="">单条导入</option>
							</select> <label style="color: red;"> <c:out value="${error }" /></label>
							<div id="panel1" style="display: none;">
								<form
									action="${pageContext.request.contextPath }/manager/dealer/excelInsert"
									method="post" enctype="multipart/form-data">
									<div class="form-group">
										<%-- <input type="hidden" name="token" value="<%=tokenValue%>"> --%>
										<label>请选择Excel文件</label> <input type="file" name="excel"
											class="form-control" required="">
										<p class="help-block">
											Excel文件必须符合规范，<a
												href="${pageContext.request.contextPath }/download/supplierTemplate">点击下载</a>经销商导入模版
										</p>
									</div>
									<button class="btn btn-outline btn-primary" type="submit">新增</button>
									<a class="btn btn-outline btn-default" type="button"
										href="javascript:history.go(-1);">返回</a>
								</form>
							</div>
							<div id="panel2" style="display: none;">
								<form
									action="${pageContext.request.contextPath }/manager/dealer/singleInsert"
									method="post" onsubmit="return dosubmit()">
									<input type="hidden" name="operation" value="insert">
									<div class="form-group">
										<label>供应商</label> <input type="text" class="form-control"
											placeholder="供应商名称" name="dname" required="">
									</div>
									<div class="form-group">
										<label>联系电话</label> <input id="phone" type="text"
											class="form-control" placeholder="联系电话" name="phone"
											required="">
										<p id="phoneMsg"></p>
									</div>
									<div class="form-group">
										<label>详细地址</label> <input type="text" class="form-control"
											placeholder="所在省市" name="province" required="">
									</div>
									<div class="form-group">
										<label>规定到达天数</label> <input id="limitdays" type="text"
											class="form-control" placeholder="天数" name="limitdays"
											required="">
										<p style="color: red" id="info"></p>
									</div>
									<button class="btn btn-outline btn-primary" type="submit">新增</button>
									<a class="btn btn-outline btn-default" type="button"
										href="javascript:history.go(-1);">返回</a>

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 内容主体结束 -->
			<!-- 脚部 -->
			<div class="footer">
				<div>
					<strong>订单管理系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
				</div>
			</div>
		</div>
	</div>
	<!-- 脚部 -- >
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
		var isCommitted = false;//表单是否已经提交标识，默认为false
		var isRegedit = false; //手机号是否被注册
		$(document)
				.ready(
						function() {
							var li_id = '${li_id}';
							$("#" + li_id).addClass("active");
							if (li_id == "li_factory_order"
									|| li_id == "li_dealer_order") {
								$("#li_account").removeClass("active");
							}
							$("#select")
									.change(
											function() {
												var selectIndex = $("#select")
														.get(0).selectedIndex;
												if (selectIndex == 1) {
													$("#panel1").slideToggle(
															"slow");
													$("#panel2").css("display",
															"none");
												} else if (selectIndex == 2) {
													$("#panel2").slideToggle(
															"slow");
													$("#panel1").css("display",
															"none");
												} else {
													$("#panel2")
															.slideUp("slow");
													$("#panel1")
															.slideUp("slow");
												}
											});
							$("#phone")
									.bind(
											'blur',
											function() {
												var phone = $('#phone').val();
												var ispass = true;
												if (!/^1[3|4|5|8][0-9]\d{4,8}$/
														.test(phone)) {
													$('#phoneMsg').css("color",
															"red");
													$('#phoneMsg').html(
															'输入手机号码不合法');
													ispass = false;
												}
												if (ispass) {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/manager/dealer/checkpwd',
																data : {
																	'phone' : phone
																},
																success : function(
																		data) {
																	var result = eval(data);
																	if (result.status == 'success') {
																		$(
																				'#phoneMsg')
																				.css(
																						"color",
																						"green");
																		$(
																				'#phoneMsg')
																				.html(
																						result.msg);
																		isRegedit = false;
																	} else if (result.status == 'error') {
																		$(
																				'#phoneMsg')
																				.css(
																						"color",
																						"red");
																		$(
																				'#phoneMsg')
																				.html(
																						result.msg);
																		isRegedit = true;
																	}
																	console
																			.log(result);
																}
															});
												}
											});
						});
		function dosubmit() {
			var limitdays = $('#limitdays').val();
			var phone = $('#phone').val();
			if (isRegedit) {
				alert('输入手机已经被注册,请更换!');
				return false;
			}

			if (!/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone)) {
				$('#info').html('输入手机号码不合法');
				return false;
			}

			if (isNaN(limitdays)) {
				$('#info').html('天数只能输入数字');
				return false;
			}
			if (limitdays.length >= 4) {
				$('#info').html('输入天数超出限制');
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
