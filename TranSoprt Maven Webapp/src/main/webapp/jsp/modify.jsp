<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
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
				<div class="navbar-brand">修改密码</div>
				
			</div>

			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container">
		<div id="col-md-12 col-xs-12">
			<div class="modi-cont">
				<div class="note"></div>
				<input type="password" id="newpwd" placeholder="请输入固定密码"
					id="guding-password" /> <input type="password" id="again"
					placeholder="请再次输入固定密码" id="again-password" />
				<div class="btnConfrim">
					<input type="button" href="javaScript:void(0);"
						onclick="changePwd()" role=" button" value="确定"
						class="btn btn-success btn-lg">
				</div>
			</div>
		</div>
	</div>
	<!-- <footer>
		&copy;vanroid团队<br />All rights reserved.
	</footer> -->
	<!--<div class="orderTab col-md-12 col-xs-12">-->
	<!--<a href="booking.html"><div class="col-md-6 col-xs-6 orderTab-item">我要下单</div></a>-->
	<!--<a href="order.html"><div class="col-md-6 col-xs-6 orderTab-item">查看订单</div></a>-->
	<!--</div>-->
	<div class="posi">
		<div class="row" style="margin-bottom: 0px;">
			<ul id="mytab" class="col-md-12 col-xs-12" role="tablist"
				style="margin-bottom: 0px;">
				<a href="${pageContext.request.contextPath }/goods/totalgoods"><li style="padding:20px 0px;"
					role="presentation" class="loginTab col-md-6 col-xs-6">我要下单</li></a>
				<a href="${pageContext.request.contextPath }/order/getOrderbydealer"><li style="padding:20px 0px;"
					role="presentation" class="loginTab col-md-6 col-xs-6">查看订单</li></a>
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
		function changePwd() {
			var pwd1 = $("#newpwd").val();
			var pwd2 = $("#again").val();
			console.log(pwd2==pwd1);
			if (pwd1 != pwd2) {
				alert("密码不一致！");
				return;
			}else{
			$
					.ajax({
						url : '${pageContext.request.contextPath}/dealer/changepwd',
						type : 'POST',
						data : {
							'newPwd' : pwd1,
						},
						dataType : 'json',
						success : function(data) {
							if (data == 1) {
								alert("修改成功！");
								window.location = "${pageContext.request.contextPath }/goods/totalgoods";
							}
							if (data == 0)
								alert("修改失败！");

						}
					});}
		}
	</script>
</body>
</html>