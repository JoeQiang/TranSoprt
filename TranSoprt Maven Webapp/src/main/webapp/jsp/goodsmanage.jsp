<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>港荣食品物流跟踪系统</title>
<meta name="keywords" content="港荣食品物流跟踪系统">
<meta name="description" content="港荣食品物流跟踪系统">

 <link href="../css/bootstrap.min.css?v=3.4.0" rel="stylesheet">
    <link href="../font-awesome/css/font-awesome.css?v=4.3.0" rel="stylesheet">
    <link href="../css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="../css/animate.css" rel="stylesheet">
    <link href="../css/style.css?v=2.2.0" rel="stylesheet">

</head>

<body>
	<div id="wrapper">

		<%@include file="nav.jsp"%>
		<!--侧边栏结束-->
		<!-- 搜索栏 -->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top" role="navigation"
					style="margin-bottom: 0">
					<div class="navbar-header">
						<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "
							href="#"><i class="fa fa-bars"></i> </a>
						<form role="search" class="navbar-form-custom" method="post"
							action="search_results.html">
							<div class="form-group">
								<input type="text" placeholder="请输入您需要搜索的订单 …"
									class="form-control" name="top-search" id="top-search">
							</div>
						</form>
					</div>
					<ul class="nav navbar-top-links navbar-right">
						<li><span class="m-r-sm text-muted welcome-message"><a
								href="index.html" title="返回首页"><i class="fa fa-home"></i></a>欢迎使用港荣后台管理系统</span>
						</li>
						<li><a href="login.html"> <i class="fa fa-sign-out"></i>
								退出
						</a></li>
					</ul>

				</nav>
			</div>
			<!-- 搜索栏结束 -->
			<!-- 内容主体结束 -->
			<div class="row wrapper border-bottom white-bg page-heading">

				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>商品管理</h5>
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
									<a  data-toggle="modal" class="btn btn-primary" href="form_basic.html#modal-form">
										添加商品</a>
								</div>
								<table class="table table-striped table-bordered table-hover "
									id="editable">
									<thead>
										<tr>
											<th>商品名称</th>
											<th>商品规格</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${goodslist}" var="goods">
											<tr class="gradeB" id="tr${goods.gid}">
												<td>${goods.gname}</td>
												<td><c:forEach items="${goods.standard}" var="sd">
												<div id="div${goods.gid}${sd.sid }">
													${sd.sname}&nbsp;<a href="javascript:delSta(${goods.gid},${sd.sid })">X</a></div>
											</c:forEach></td>
												<td><a type="button" class="btn btn-danger" href="javascript:delGoods(${goods.gid})">删除</a></td>
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

			<!-- 新增商品表单 -->
			<div id="modal-form" class="modal fade" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6 b-r">
                            <h3 class="m-t-none m-b">新增商品</h3>

                            <form role="form" action="${pageContext.request.contextPath}/goods/addgoods" method="post">
                                <div class="form-group">
                                    <label>商品名称：</label>
                                    <input type="text"  name="gname" placeholder="请输入商品名称" class="form-control">
                                </div>
                                
                               <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">重量规格</label>

                                        <div class="col-sm-10">
                                             <div class="col-sm-10">
                                             <label class="checkbox-inline i-checks">
                                                <input type="checkbox" value="1" name="weight">800g</label>
                                            <label class="checkbox-inline i-checks">
                                                <input type="checkbox" value="2" name="weight">1kg</label>
                                            <label class="checkbox-inline i-checks">
                                                <input type="checkbox" value="3" name="weight">2kg</label>
                                            <label class="checkbox-inline i-checks">
                                                <input type="checkbox" value="4" name="weight">1.5kg</label>
                                        </div>
                                        </div>
                                    </div>
                                <div>
                                    <button class="btn btn-sm btn-primary pull-right m-t-n-xs" type="submit"><strong>添加</strong>
                                    </button>
                                    
                                </div>
                            </form>
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
					<strong>物流跟踪系统</strong>&copy; 港荣食品有限公司 &nbsp;&nbsp;2016
				</div>
			</div>

		</div>
		<!-- 脚部 -->
	</div>
<!-- Mainly scripts -->
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/bootstrap.min.js?v=3.4.0"></script>
    <script src="../js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="../js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="../js/hplus.js?v=2.2.0"></script>
    <script src="../js/plugins/pace/pace.min.js"></script>

    <!-- iCheck -->
    <script src="../js/plugins/iCheck/icheck.min.js"></script>
	<script>
	$(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
		function delGoods(gid) {
		if(window.confirm('确定要删除该商品吗？')){
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/goods/delete?gid='
						+ gid,
				success : function(data) {
					$("#tr"+gid).hide();
				},
				dataType : 'json'
			});}
		}
		function delSta(gid,sid){
		if(window.confirm('确定要删除该规格吗？')){
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/goods/delsta?gid='
						+ gid+"&sid="+sid,
				success : function(data) {
				$("#div"+gid+sid).hide();
				/* alert(data); */
				},
				dataType : 'json'
			});}
		}
		
	</script>
</body>

</html>