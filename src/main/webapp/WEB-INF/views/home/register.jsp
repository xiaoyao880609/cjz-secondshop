<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
</head>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-4.3.1/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<body
	style="background-image: url(<c:url value="/statics/image/background/background1.jpg"/>); background-size: cover">
	<div class="container" style="margin-top: 30px;">
		<div class="row">
			<div style="margin: 20px auto; color: #ffffff">
				<h1 align="center" style="color: #292b33">新用户注册</h1>
			</div>

			<div class="col-xs-5 r"
				style="position: absolute; left: 50%; transform: translateX(-50%); padding: 30px; background-color: #ffffff">
				<form:form method="post" commandName="user" items="${user}"
					id="register">
					<spring:bind path="name">
						<div class="form-group">
							<form:label path="name" cssClass="control-label">姓名</form:label>
							<form:input path="name" cssClass="form-control"
								placeholder="请输入姓名"/>
						</div>
					</spring:bind>

					<spring:bind path="gender">
						<div class="form-group">
							<form:label path="gender" cssClass="control-label">性别</form:label>
							<form:select path="gender" id="gender" cssClass="form-control">
								<form:option value="男">男</form:option>
								<form:option value="女">女</form:option>
							</form:select>
						</div>
					</spring:bind>

					<spring:bind path="mobile">
						<div class="form-group">
							<form:label path="mobile" cssClass="control-label">手机</form:label>
							<form:input path="mobile" cssClass="form-control"
								placeholder="请输入手机号码"/>
							<output itemid="status" style="color: red"></output>
						</div>
					</spring:bind>

					<spring:bind path="email">
						<div class="form-group">
							<form:label path="email" cssClass="control-label">邮箱</form:label>
							<form:input path="email" cssClass="form-control"
								placeholder="请输入邮箱"/>
							<output itemid="status" style="color: red" value=""></output>
						</div>
					</spring:bind>

					<spring:bind path="address">
						<div class="form-group">
							<form:label path="address" cssClass="control-label">地址</form:label>
							<form:input path="address" cssClass="form-control"
										placeholder="请输入地址"/>
							<output itemid="status" style="color: red" value=""></output>
						</div>
					</spring:bind>

					<spring:bind path="password">
						<div class="form-group">
							<form:label path="password" cssClass="control-label">密码</form:label>
							<form:input id="p1" path="password" cssClass="form-control"
								placeholder="请输入密码" type="password"/>
						</div>
					</spring:bind>

					<spring:bind path="password2">
						<div class="form-group">
							<form:label path="password2" cssClass="control-label">确认密码</form:label>
							<form:input id="p2" path="password2" cssClass="form-control"
								placeholder="再次请输入密码" type="password" onblur="checkpass(this)"/>
							<output id="passError" style="color: red"></output>
						</div>
					</spring:bind>

					<div class="form-group">
						<button type="submit" class="btn btn-primary">注册</button>
						<a class="btn btn-success pull-right" href="<c:url value="/login"/>">返回</a>
					</div>
					<output style="color: red">${status}</output>
				</form:form>
			</div>
		</div>
	</div>
	</div>

	<script>
		function checkpass() {
			const password = document.getElementById("p1");
			const passwordConfirm = document.getElementById("p2");
			if (password.value != passwordConfirm.value) {
				document.getElementById("passError").innerHTML = "对不起，您2次输入的密码不一致";
			} else {
				document.getElementById("passError").innerHTML = "";
			}
		}
	</script>
	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.13.2/datepicker-zh-CN.js"/>"></script>
</body>
</html>