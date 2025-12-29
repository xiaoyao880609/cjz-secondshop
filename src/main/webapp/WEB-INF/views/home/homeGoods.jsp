<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="height = device-height,width = device-width,initial-scale = 1.0 ,minimum-scale = 1.0 ,maximum-scale = 1.0,user-scalable = no">
<title>首页</title>
<link rel="stylesheet" href="<c:url value="/statics/css/materialize-icon.css"/>">
	<link rel="shortcut icon" href="#" />
	<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-4.3.1/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/js/materialize.min.js"/>"></script>
	<style>
		#search-bar {
			background-color: #f9f9f9;
			border-radius: 10px;
		}
		/*input {*/
		/*	border-radius: 5px;*/
		/*}*/
		/*button {*/
		/*	border-radius: 5px;*/
		/*	background-color: #00a0e9;*/
		/*	color: white;*/
		/*}*/
		.search-container{
			display: flex;
			width: 500px;
			height: 50px;
			line-height: 50px;
			margin-left: 200px;
		}
		.search-container input{
			flex:1;
			height: 50px;
			line-height: 50px;
			box-sizing: border-box;
			outline: none;
			border-color: rgb(0, 179, 255);
			border-top-left-radius: 25px;
			border-bottom-left-radius: 25px;
			padding: 0 20px;
			transition: all .3s;
		}
		.search-container button{
			height: 50px;
			line-height: 50px;
			padding: 0 30px;
			border: none;
			box-sizing: border-box;
			background-color: #00b3ff;
			font-size: 18px;
			color: #fff;
			cursor: pointer;
			border-top-right-radius: 25px;
			border-bottom-right-radius: 25px;
		}
		.search-container input:focus{
			box-shadow: 0 0 5px #00b3ff;
		}
		.btn-type:hover {
			background-color: #0086cf;
		}
		.r-type:hover {
			background-color: #eaeaea;
		}
	</style>
<script>
	$(function() {
		const width = $("#type-bar").width();
		$(window).scroll(function() {
			if ($(document).scrollTop() >= $("#search-bar").height()) {
				$("#type-bar").css({
					"position" : "fixed",
					"top" : 150 - $("#search-bar").height() + "px",
					"width" : width
				});
			} else {
				$("#type-bar").css({
					"position" : "fixed",
					"top" : 150 - $(document).scrollTop() + "px",
					"width" : width
				});
			}
		})
	})
</script>
</head>
<body>
	<div>
		<jsp:include page="header.jsp" />
	</div>
	<div class="col-md-12" style="height: 80px;" id="search-bar">
		<div class="col-md-3" style="height: 80px;"></div>
		<div class="col-md-6" style="padding-top: 10px">
			<form class="form-horizontal" action="<c:url value="/"/>" method="get">
				<div class="form-group col-md-12">
<%--					<div class="col-md-10">--%>
<%--						<input id="searchText" name="searchText" type="text"--%>
<%--							   class="form-control" value="${param.searchText}"--%>
<%--							   placeholder="在这里搜索">--%>
<%--					</div>--%>
					<div class="search-container">
						<label for="searchText"><input id="searchText" name="searchText" type="text"></label>
						<button>搜索</button>
					</div>
<%--					<button class="btn btn-success; col-md-2">🔍</button>--%>
					<div class="col-md-12">
						<c:if test="${param.searchText != '' && param.searchText != null}">
							<p></p>
							<p>为您搜索到“${param.searchText}”相关物品${goodsNum}条记录</p>
						</c:if>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="container">
		<div class="main-content">
	<div class="col-md-2" style="padding-left: 0px; padding-right: 0px;"
		 id="type-bar">
		<div class="col-md-12" align="center"
			 style="padding-left: 0px; padding-right: 0px;" id="type-button">
			<c:forEach var="firstType" items="${firstTypes}">
				<div
						style="height: 50px; width: 100%; background-color: #00a0e9; margin-top: 15px;text-align:center;"
						class="btn-type" id="type${firstType.id}"
						onclick="typeButton(${firstType.id})">
					<p><h4 style="color: white;">${firstType.name}</h4></p>
				</div>

				<div class="col-md-12 r" id="${firstType.id}"
					 style="display: none; background-color: #f0f0f0; padding-left: 0px; padding-right: 0px;"
					 align="center">
					<c:forEach var="secondType" items="${firstType.secondTypes}">
						<a class="col-md-12 r-type"
						   href="<c:url value="/?secondTypeId=${secondType.id}"/>">
							<p></p>
							<p>${secondType.name}</p>
						</a>
					</c:forEach>
				</div>
			</c:forEach>
			<div class="info" style="font-size: 14px;background-color: #00a0e9;margin: 10px 0;text-align: center;">
				<a href="<c:url value="/about"/>" target="_blank" style="color: white;">关于我们</a><em>-</em>
				<a href="<c:url value="/about"/>" target="_blank" style="color: white;">联系我们</a>
				<p style="color: white;">©2025 转合二手商城</p>
			</div>
		</div>
	</div>

			<div class="col-md-10" style="margin-top: 10px; float: right;">
				<c:choose>
					<c:when test="${goods.size() == 0}">
						<div align="center">
							<img style="width: 500px; height: 350px;margin-right: 80px;"
								src="<c:url value="/statics/image/photos/default/629cb7fd24892ec11d039d1d78e6c92b.jpeg"/>" alt="图片">
							<h2>抱歉，该物品已售罄！</h2>
						</div>
					</c:when>
				</c:choose>

				<c:forEach var="good" items="${goods}">
					<a target="_blank" href="goods/goodInfo?goodId=${good.id}">
						<div class="c col-md-3">
							<div class="a col-md-12" style="height: 245px;width: 200px">
								<img alt="图片" src="${good.photoUrl}" width="100%" height="150px">
								<p style="height: 25px; margin-top: 20px">${good.name}</p>
								<p style="color: red; text-align: right">
									<B>价格：${good.prise}￥</B>
								</p>
							</div>
						</div>
					</a>
				</c:forEach>

				<div class="col-md-12 column" align="right">
					<ul class="pagination">
						<c:choose>
							<c:when test="${offset >= limit}">
								<li><a
									href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${offset - limit}">上一页</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="#">上一页</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="page" begin="1" end="${pages}">
							<c:choose>
								<c:when test="${offset == limit * (page - 1)}">
									<li class="disabled"><a href="#">${page}</a></li>
								</c:when>
								<c:otherwise>
									<li><a
										href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${limit * (page - 1)}">${page}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:choose>
							<c:when test="${goods.size() >= limit}">
								<li><a
									href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${offset + limit}">下一页</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="#">下一页</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div>
		<jsp:include page="footer.jsp" />
	</div>
	<script>
    function typeButton(firstTypeId) {
		const firstType = "#" + firstTypeId;
		const firstType1 = "#type" + firstTypeId;
		if (document.getElementById(firstTypeId).style.display === "none") {
            // $(".btn-type").slideUp();
            $(firstType1).slideDown();
            $(firstType).slideDown();
        } else {
            $(".btn-type").slideDown();
            $(firstType).slideUp();
        }
    }
	</script>
	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.13.2/datepicker-zh-CN.js"/>"></script>
</body>
</html>