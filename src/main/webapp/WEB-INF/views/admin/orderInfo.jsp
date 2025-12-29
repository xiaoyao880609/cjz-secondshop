<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单信息</title>
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
<nav class="navbar navbar-default navbar-fixed-top" role="navigation"
	 style="background-color: #f8f8f8">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#" style="font-size: 25px;color: #0bb9f8" >转合</a>
			<a class="navbar-brand" href="#" style="font-size: 25px;margin-left: -25px;">二手商城订单管理</a>
		</div>

		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a>${sessionScope.admin.getName()}</a></li>
				<li><a
						href="<c:url value="/admin/adminLogout?adminLogout=true"/>">退出</a></li>
			</ul>
		</div>
	</div>
</nav>
<div class="container"
	style="position: relative; transform: translate(0, 0)">
	<div class="col-md-9" style="float: left">
		<div class="col-md-12 r1"
			style="background-color: #00a0e9; height: 40px">
			<div class="col-md-6" style="margin-top: 5px">
				<B style="color: white; font-size: 20px">订单</B>
			</div>
		</div>

		<div class="col-md-12 r2"
			style="background-color: #f9f9f9; padding-top: 5px; padding-bottom: 30px; padding-left: 120px; padding-right: 120px; margin-bottom: 20px">
			<div class="col-md-12" align="center" style="margin-bottom: 5px">
				<h3>交易信息明细</h3>
			</div>
			<div class="col-md-12" style="background-color: #ffffff">
				<div class="col-md-12"
					style="margin-bottom: 10px; margin-top: 20px;">
					<div class="col-md-12"
						style="padding: 30px; background-color: #f2f2f2">
						<c:choose>
						<c:when test="${orderInfo.id != 0}">
						<div class="col-md-5"
							 style="padding-left: 60px; padding-top: 20px">
							<p style="color: #666666; height: 30px">
								<B>订单号</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>物品名称</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>卖家</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>联系方式</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>地址</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>-----------------------</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>买家</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>联系方式</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>地址</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>订单状态</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>交易时间</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>结束时间</B>
							</p>
						</div>
						<div id="order" class="col-md-7"
							 style="padding-left: 0; padding-top: 20px">
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.id}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.goodName}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.seller}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.sellerMobile}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.sellerAddress}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>-----------------------</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.customer}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.customerMobile}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.customerAddress}</B>
							</p>
							<p style="height: 30px">
								<c:choose>
									<c:when test="${orderInfo.statusId == 1}">
										<B style="color: red">交易取消</B>
									</c:when>
									<c:otherwise>
										<B style="display: ${orderInfo.statusId == 2 ? "":"none"}">交易中</B>
										<B style="display: ${orderInfo.statusId == 3 ? "":"none"};color: blue">交易完成</B>
									</c:otherwise>
								</c:choose>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.submitDate}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.endDate}</B>
							</p>
						</div>
					</div>
					<div class="col-md-12" style="margin-top: 20px">
						<button class="btn btn-success" onclick="deleteOrder()">删除</button>
						<button id="back" class="btn btn-primary pull-right" onclick="back()">返回</button>
					</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-12" align="center"
                            style="background-color: #ffffff; margin-top: 50px;">
                            <img src="<c:url value="/statics/image/logo/error.png"/>"
                                width="95%" height="170px;" alt="图片">
                            <p style="color: #c4c4c4; font-size: 16px">抱歉，暂无订单！</p>
                        </div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../home/footer.jsp" />

<script>
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": 285,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": 285,
                    "right": 15
                });
            }
        })
    });

    function deleteOrder() {
        $.getJSON("/cjz/user/order/delete/" + ${orderInfo.id}, function (data) {
            if (data === true){
                alert("订单删除成功！");
                $(window).attr('location','/cjz/user/userProfile');
            } else {
                alert("订单删除失败！");
            }
        })
    }
	function back() {
        $(window).attr('location','/cjz/admin/adminPage');
    }
</script>
<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.js"/>"></script>
<script
	src="<c:url value="/statics/jquery-ui-1.13.2/datepicker-zh-CN.js"/>"></script>
</body>
</html>