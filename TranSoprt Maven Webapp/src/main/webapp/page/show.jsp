<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath }/css/datetimepicker/bootstrap-datetimepicker.min.css"
	rel="stylesheet">
</head>

<body>
	<input id="date" class="span2" size="16" type="text" value="12-02-2012">





	<!-- spring -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/datetimepicker/bootstrap-datetimepicker.fr.js"></script>
	<script type="text/javascript">
		$('#date').datetimepicker({
			format: 'yyyy-mm-dd'
		});
	</script>
</body>

</html>
