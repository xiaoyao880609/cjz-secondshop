<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>error</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-4.3.1/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container">
		<div class="col-md-12" align="center"
			style="height: 560px; padding-top: 60px">
			<h1>抱歉出现了异常！！</h1>
			<p>
				<img src="<c:url value="/statics/image/logo/error.png"/>"
					height="309px" width="240px">
			</p>
			<B>啊噢！页面好像被外星人偷走了！</B>
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
</body>
</html>