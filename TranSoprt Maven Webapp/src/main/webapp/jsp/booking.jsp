<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0" />
<title>港荣经销商客户端</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/kehuduanstyle.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<div class="navbar-brand">我要下单</div>
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false" aria-haspopup="true">
					<span class="sr-only">叠合选择</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
					<li><a
						href="${pageContext.request.contextPath }/dealer/logout">注销</a></li>
					<li class="modify"><a
						href="${pageContext.request.contextPath }/dealer/changepwdpage">修改密码</a></li>
				</ul>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<!--<li class="name">-->
					<!--<a id="account" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">-->
					<!--未登录-->
					<!--<span class="caret"></span>-->
					<!--</a>-->
					<!--    <ul class="dropdown-menu"> -->
					<li><a
						href="${pageContext.request.contextPath }/dealer/logout">注销</a></li>
					<li class="modify"><a
						href="${pageContext.request.contextPath }/dealer/changepwdpage">修改密码</a></li>
					<!--  </ul> -->
					<!-- </li> -->
					<!--<li class="booking"><a href="booking.html">我要下单</a></li>-->
					<!--<li class="order"><a href="order.html">查看订单</a></li>-->
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container">
		<div class="booking-content">
			<div class="row">
				<div class="col-md-2 col-md-offset-4 col-xs-5">蒸蛋糕种类：</div>
				<div class="col-md-5 col-xs-7">
					<div class="listview">
						<select id="cakeType">
							<c:forEach items="${allgoods}" var="goods">
								<option value="${goods.gid }">${goods.gname }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-md-offset-4 col-xs-5">蒸蛋糕规格：</div>
				<div class="col-md-5 col-xs-7">
					<div class="listview">
						<select id="cakeStandard">
							<c:forEach items="${g1standard}" var="sta">
								<option value="${sta.sid }">${sta.sname }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-md-offset-4 col-xs-5">订购数量：</div>
				<div class="col-md-5 col-xs-7">
					<input type="text" id="quantity" />&nbsp;箱
				</div>
			</div>
			<div class="btnConfrim">
				<button onclick="makeOrder()" role="button" value="下单"
					id="btn_mkorder" class="btn btn-success btn-lg">下单</button>
			</div>
		</div>
		 <div class="news">
		 <c:choose>
		 <c:when test="${empty public }">
		 暂无公告信息
		 </c:when><c:otherwise>
		 ${public }
		 </c:otherwise>
		 </c:choose>
		 </div>
	</div>
	<!-- <footer>
		&copy;vanroid团队<br />All rights reserved.
	</footer> -->
	<div class="posi">
		<div class="row" style="margin-bottom: 0px;">
			<ul id="mytab" class="col-md-12 col-xs-12" role="tablist"
				style="margin-bottom: 0px;">
				<a href="${pageContext.request.contextPath }/goods/totalgoods"><li
					style="padding:20px 0px;" role="presentation"
					class="loginTab col-md-6 col-xs-6 active">我要下单</li></a>
				<a href="${pageContext.request.contextPath }/order/getOrderbydealer"><li
					style="padding:20px 0px;" role="presentation"
					class="loginTab col-md-6 col-xs-6">查看订单</li></a>
			</ul>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/project.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							/* 现在数量框只能输入数字 */
							$("#quantity").keyup(function() {
								var tmptxt = $(this).val();
								$(this).val(tmptxt.replace(/\D|^0/g, ''));
							}).bind("paste", function() {
								var tmptxt = $(this).val();
								$(this).val(tmptxt.replace(/\D|^0/g, ''));
							}).css("ime-mode", "disabled");

							/* 级联下拉列表ajax */
							$("#cakeType")
									.change(
											function() {
												var gid = $(this).children(
														'option:selected')
														.attr("value");
												$
														.ajax({
															url : '${pageContext.request.contextPath}/goods/getStandardByGid/'
																	+ gid,
															type : 'GET',
															dataType : 'json',
															success : function(
																	data) {
																$(
																		"#cakeStandard option")
																		.remove();
																for (i = 0; i < data.length; i++) {
																	$(
																			"#cakeStandard")
																			.append(
																					"<option value='"+data[i].sid+"'>"
																							+ data[i].sname
																							+ "</option>");

																}
															}

														});
											});
						});
		function makeOrder() {
			var gid = $("#cakeType").children('option:selected').attr("value");
			var sid = $("#cakeStandard").children('option:selected').attr(
					"value");
			var num = $("#quantity").val();
			if (num<=0){
			alert("无效的订单数量！");
			return;}
				$("#btn_mkorder").text("正在下单...");
			$.ajax({
				url : '${pageContext.request.contextPath}/order/makeorder/'
						+ gid + "-" + sid + "-" + num,
				dataType : 'json',
				type : 'GET',
				success : function(data) {
					if (data == 1)
						alert("下单成功！");
					$("#btn_mkorder").text("下单");
				}
			});
		}
	</script>
</body>
</html>