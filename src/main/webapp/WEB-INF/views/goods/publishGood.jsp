<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品发布</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-4.3.1/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container"
		style="position: relative; transform: translate(0, 0)">
		<div class="col-md-9">
			<div class="col-md-12 r1"
				style="background-color: #00a0e9; height: 40px;">
				<div style="margin-top: 5px">
					<B style="color: white; font-size: 20px;">商品详细信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
				<div class="col-md-12">
					<form:form method="post" commandName="good" items="${good}"
						id="register">
						<spring:bind path="name">
							<div class="form-group">
								<form:label path="name" cssClass="control-label">商品标题</form:label>
								<form:input path="name" id="name" cssClass="form-control"/>
								<output id="nameError" style="color: red"></output>
							</div>
						</spring:bind>
						
						<spring:bind path="firstTypeId">
							<div class="form-group">
								<form:label path="firstTypeId" cssClass="control-label">一级分类</form:label>
								<form:select id="goodType" onchange="selectValue()"
									cssClass="form-control" path="firstTypeId"
									items="${firstTypes}" itemLabel="name" itemValue="id"/>
							</div>
						</spring:bind>
						
						<spring:bind path="secondTypeId">
							<div class="form-group">
								<form:label path="secondTypeId" cssClass="control-label">二级分类</form:label>
								<form:select id="secondType" cssClass="form-control"
									path="secondTypeId"/>
							</div>
						</spring:bind>
						
						<spring:bind path="prise">
							<div class="form-group">
								<form:label path="prise" cssClass="control-label">商品价格</form:label>
								<form:input id="prise" path="prise" cssClass="form-control"
									onblur="checkNum(this)"/>
								<output id="priseError" style="color: red"></output>
							</div>
						</spring:bind>
						
						<spring:bind path="describe">
							<div class="form-group">
								<form:label path="describe" cssClass="control-label">商品描述</form:label>
								<form:textarea path="describe" cssClass="form-control"
									cssStyle="height: 160px"/>
							</div>
						</spring:bind>
						
						<div class="form-group" align="right" onclick="return checkName()">
							<c:choose>
								<c:when test="${good.id == 0}">
									<button  class="btn"
										style="background-color: #e5e5e5" onclick="return checkName()">获取商品ID</button>
								</c:when>
								
								<c:otherwise>
									<button disabled="disabled" type="submit" class="btn"
										style="background-color: #e5e5e5">已获取商品ID${good.id}</button>
								</c:otherwise>
							</c:choose>
						</div>
					</form:form>
				</div>
			</div>
			
			<div class="col-md-12 r1"
				style="background-color: #00a0e9; height: 40px; margin-top: 20px;">
				<div style="margin-top: 5px">
					<B style="color: white; font-size: 20px;">商品图片信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
				<div class="col-md-12 r"
					style="margin-top: 15px; background-color: #ffffff; padding: 0">
					<div class="col-md-12"
						style="display: ${good.id == 0 ? '' : 'none'}">
						<div class="col-md-12" align="center"
							style="height: 100px; padding-top: 20px">
							<h3 style="color: #dcdcdc">请先填写商品信息，获取商品ID</h3>
						</div>
					</div>
					
					<div class="col-md-12"
						style="padding: 0; display: ${good.id == 0 ? 'none' : ''}">
						<form action="/cjz/goods/publishGood/uploadImage" method="post" enctype="multipart/form-data">
							<label>
							<input name="goodId" value="${good.id}" style="display: none">
							</label>
							<div class="col-md-12" style="padding: 0px">
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img1" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="mainFile"
										onchange="change(event)" onclick="changeImgId('img1')">
								</div>
								
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img2" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="file"
										onchange="change(event)" onclick="changeImgId('img2')">
								</div>
								
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img3" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="file"
										onchange="change(event)" onclick="changeImgId('img3')">
								</div>
							</div>
							
							<div id="addImg" class="col-md-12"
								style="padding: 0px; display: none;">
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img4" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="file"
										onchange="change(event)" onclick="changeImgId('img4')">
								</div>
								
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img5" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="file"
										onchange="change(event)" onclick="changeImgId('img5')">
								</div>
								
								<div class="col-md-4" style="padding: 15px" align="center">
									<div style="width: 100%; height: 230px;">
										<img src="/images/goods/default/nophoto.png" id="img6" height="100%" width="100%">
									</div>
									<input style="width: 100%" type="file" name="file"
										onchange="change(event)" onclick="changeImgId('img6')">
								</div>
							</div>
							
							<div class="col-md-12" style="padding: 15px">
								<div class="col-md-6" style="padding: 0px">
									<p id="addBtn" class="btn" style="background-color: #e5e5e5"
										onclick="addImg()">添加图片</p>
								</div>
								
								<div class="col-md-6" align="right" style="padding: 0px">
									<button type="submit" class="btn"
										style="background-color: #e5e5e5">提交</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div id="re-bar" class="col-md-3 r"
			style="background-color: #f9f9f9; padding-bottom: 15px;">
			<div class="col-md-12 r"
				style="text-align: center; margin-top: 10px; background-color: #00a0e9; padding: 5px">
				<B style="font-size: 20px; color: white">最新发布的商品</B>
			</div>
			
			<div class="col-md-12"
				style="margin-top: 20px; padding-left: 0px; padding-right: 0px">
				<c:choose>
					<c:when test="${goods.size() == 0}">
						<div align="center">
							<h4>抱歉，暂无此类推荐！</h4>
						</div>
					</c:when>
				</c:choose>
				
				<c:forEach var="Good" items="${goods}">
					<a target="_blank"
						href="<c:url value="goodInfo?goodId=${Good.id}"/>">
						<div class="col-md-12 b"
							style="padding-left: 0px; padding-right: 0px">
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px">
								<img src="${Good.photoUrl}" height="100px" width="100px">
							</div>
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px; height: 130px">
								<p style="height: 75px">${Good.name}</p>
								<p align="right" style="color: red">￥${Good.prise}</p>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script>
		$(function() {
			const goodType = $("#goodType option:selected").attr("value");
			$.getJSON("/cjz/type/secondType/" + goodType, function(
					data) {
				$.each(data, function(i, type) {
					const id = type.id;
					const name = type.name;
					const option = '<option value= \"' + id + '\"> ' + name
							+ '</option>';
					$("#secondType").append(option);
				})
			});
		});
		
		function selectValue() {
			const goodType = $("#goodType option:selected").attr("value");
			$.getJSON("/cjz/type/secondType/" + goodType, function(
					data) {
				document.getElementById("secondType").innerHTML = "";
				$.each(data, function(i, type) {
					const id = type.id;
					const name = type.name;
					const option = '<option value= \"' + id + '\"> ' + name
							+ '</option>';
					$("#secondType").append(option);
				})
			});
		}
		
		function checkNum() {
			const name = document.getElementById("name").value;
			const prise = document.getElementById("prise").value;
			const reg = /^[-+]?[0-9]*\.?[0-9]+$/;
			if (!reg.test(prise)) {
				document.getElementById("priseError").innerHTML = "对不起，请输入数字！";
			} else if(prise === "" || prise == null) {
				window.alert("Please enterprise")
				return false;
				// document.getElementById("priseError").innerHTML = "对不起，请输入价格！";
			}else {
				document.getElementById("priseError").innerHTML = "";
			}
		}

		function checkName() {
			const name = document.getElementById("name").value;
			if (name === "" || name ==null) {
				document.getElementById("priseError").innerHTML = "对不起，请输入商品标题！";
				return false;
			} else {
				document.getElementById("priseError").innerHTML = "";
				return true;
			}
		}
	</script>
	
	<script>
		let imgId = "img1";

		function changeImgId(img) {
			imgId = img;
		}
		
		function change(ev) {
			const event = window.event || ev;
			const files = event.target.files[0];
			const myimg = document.getElementById(imgId);
			myimg.src = URL.createObjectURL(files);
		}
		
		function addImg() {
			if (document.getElementById("addImg").style.display === "none") {
				document.getElementById("addImg").style.display = "";
				document.getElementById("addBtn").innerHTML = "取消添加";
			} else {
				document.getElementById("addImg").style.display = "none";
				document.getElementById("addBtn").innerHTML = "添加图片";
			}
		}
	</script>

	<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.13.2/datepicker-zh-CN.js"/>"></script>
</body>
</html>