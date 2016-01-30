<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
<body style="background: #ccc;">

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<div class="navbar-brand">查看订单</div>
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false" aria-haspopup="true">
					<span class="sr-only">叠合选择</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
					<li><a href="login.html">注销</a></li>
					<li class="modify"><a href="modify.html">修改密码</a></li>
				</ul>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a
						href="${pageContext.request.contextPath }/dealer/logout">注销</a></li>
					<li class="modify"><a
						href="${pageContext.request.contextPath }/dealer/changepwdpage">修改密码</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div>
		<ul class="list-group" id="ulOrder">
			<c:forEach items="${myorders }" var="order">
			<c:choose>
			<c:when test="${order.status=='已确认签收' }">
			<li class="list-group-item history-order">
					<div class="row">
						<div class="col-xs-5">${order.gname }&nbsp;${order.sname }*${order.num }箱</div>
						<div class="col-xs-7">
							<div class="">下单时间:${order.createday }</div>
							<div id="sta${order.oid }" class="">状态：${order.status}</div>
						</div></div></li>
			</c:when>
			<c:otherwise>
				<li class="list-group-item">
					<div class="row">
						<div class="col-xs-5">${order.gname }&nbsp;${order.sname }*${order.num }箱</div>
						<div class="col-xs-7">
							<div class="">下单时间:${order.createday }</div>
							<div id="sta${order.oid }" class="">状态：${order.status}</div>
						</div>
						<c:if test="${order.status=='已发货' }">
							<div class="col-xs-4 col-xs-offset-9">
								<button onclick="confirm(${order.oid })" type="button"
									class="btnShouhuo btn btn-success btn-xs" role="button">确认收货</button>
							</div>
						</c:if>
					</div>
				</li></c:otherwise>
			</c:choose>
			</c:forEach>
		</ul><c:if test="${fn:length(myorders)>0 }">
		<a  href="javaScript:void(0);"onclick="getMoreOrder()"><div class="content" style="margin:5px 0px 50px;">
			<div class="more" >显示更多<span style="float:right;"><strong>></strong></span></div>
		</div>
		</a></c:if>
	</div><footer style="margin-bottom:70px;">港荣食品</footer>
	<div class="posi">
		<div class="row" style="margin-bottom: 0px;">
			<ul id="mytab" class="col-md-12 col-xs-12" role="tablist"
				style="margin-bottom: 0px;">
				<a href="${pageContext.request.contextPath }/goods/totalgoods"><li
					style="padding:20px 0px;" role="presentation"
					class="loginTab col-md-6 col-xs-6 ">我要下单</li></a>
				<a href="${pageContext.request.contextPath }/order/getOrderbydealer"><li
					style="padding:20px 0px;" role="presentation"
					class="loginTab col-md-6 col-xs-6 active">查看订单</li></a>
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
		var pageNum = 2;
		/* 显示更多 */
		function getMoreOrder() {
			$
					.ajax({
						url : '${pageContext.request.contextPath }/order/getOrderbydealerAjax/'
								+ pageNum,
						type : 'GET',
						dataType : 'json',
						success : function(data) {
							if (data.length == 0)
								alert("已显示所有订单！！！");
							for (i = 0; i < data.length; i++) {
								var str = "<li class='list-group-item'><div class='row'><div class='col-xs-5'>"
										+ data[i].gname
										+ "&nbsp;"
										+ data[i].sname
										+ "*"
										+ data[i].num
										+ "箱</div><div class='col-xs-7'><div class=''>下单时间:"
										+ data[i].createday
										+ "</div><div id='sta"+data[i].oid+"'>状态："
										+ data[i].status + "</div></div>";
								if (data[i].status == "已发货") {
									str += "<div class='col-xs-4 col-xs-offset-9'><button type='button' onclick='confirm("+data[i].oid+")' class='btnShouhuo btn btn-success btn-xs'role='button'>确认收货</button></div></div></li>";
								} else {
									str += "</div></li>";
								}
								$("#ulOrder").append(str);
							}
							pageNum++;
						}
					});
		}
		/* 确认收货 */
		function confirm(oid) {
			$
					.ajax({
						url : '${pageContext.request.contextPath }/order/confirmArrive/'
								+ oid,
						type : 'GET',
						dataType : 'json',
						success : function(data) {
							if (data == 1) {
								$("#sta" + oid).text("状态：已确认签收");
							} else
								alert("订单异常，请稍后再试！");
						}
					});
		}
	</script>
</body>
</html>