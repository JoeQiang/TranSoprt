<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0"/>
    <title>港荣经销商客户端</title>
    <link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath }/css/kehuduanstyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/project.js"></script>
</head>
<body>

<!--导航-->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <div class="navbar-brand">港荣</div>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false" aria-haspopup="true">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenu">
                    <li><a href="#">修改密码</a></li>
                    <li><a href="#">我要下单</a></li>
                    <li><a href="#">查看订单</a></li>
                </ul>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="name">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            未登录
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="#">注销</a></li>
                        </ul>
                    </li>
                    <li class="modify"><a href="#">修改密码</a></li>
                    <li class="booking"><a href="#">我要下单</a></li>
                    <li class="order"><a href="#">查看订单</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
<!--主内容-->
    <div class="container">
        <div class="biaoti">港荣经销商客户端</div>
        <div class="content">
        <form action="${pageContext.request.contextPath }/dealer/logininput" method="post">
            <input type="text" placeholder="请输入手机号码" id="account" name="phone"/>
            <div class="psd"><a class ="btn btn-primary btn-sm">获得动态密码</a></div>
            <input type="text" placeholder="请输入密码" id="password" name="pwd"/>
            <input class="btnConfrim" id="btnConfrim" type="submit">确定</div>
            </form>
        </div>
    </div>
<footer>&copy;vanroid团队</footer>
<script>
function getdynamic(phone){
	$.ajax({
	url:'${pageContext.request.contextPath}/dealer/getdynamic/'+phone,
	type:GET,
	dataType:Json,
	});
}
</script>
</body>
</html>