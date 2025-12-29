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
<jsp:include page="../home/header.jsp" />
<body>
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
				<h3>订单信息明细</h3>
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
							<p style="color: #666666; height: 30px">
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
						<button id="success" class="btn btn-primary pull-right"
								style="display: ${orderInfo.statusId == 2 ? "":"none"}" onclick="selectValue()">完成交易</button>
						<button id="cancel" class="btn btn-primary pull-right"
								style="display: ${orderInfo.statusId == 2 ? "":"none"}" onclick="selectOrder()">取消交易</button>
						<button id="noSuccess" class="btn btn-primary pull-right"
								style="display: ${orderInfo.statusId == 3 ? "":"none"}" disabled="disabled">交易已完成</button>
						<button id="cancelSuccess" class="btn btn-primary pull-right"
								style="display: ${orderInfo.statusId == 1 ? "":"none"}" disabled="disabled">交易取消</button>
					</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-12" align="center"
                            style="background-color: #ffffff; margin-top: 50px;">
                            <img src="<c:url value="/statics/image/logo/error.png"/>"
                                width="95%" height="170px;" alt="图片">
                            <p style="color: #c4c4c4; font-size: 16px">抱歉，您暂无订单！</p>
                        </div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

	<div id="re-bar" class="col-md-3 r"
		style="background-color: #f9f9f9; padding-bottom: 15px;">
		<div class="col-md-12 r"
			style="text-align: center; margin-top: 10px; background-color: #00a0e9; padding: 5px">
			<B style="font-size: 20px; color: white">其他订单</B>
		</div>

		<div class="col-md-12 r"
			style="background-color: #ffffff; margin-top: 15px; overflow-y: auto; height: 500px; padding: 5px">
			<c:choose>
				<c:when test="${orders.size() == 0}">
					<div class="col-md-12" align="center"
						style="background-color: #ffffff; margin-top: 50px;">
						<img src="<c:url value="/statics/image/logo/error.png"/>"
							width="95%" height="170px;" alt="图片">
						<p style="color: #c4c4c4; font-size: 16px">抱歉，暂无其他订单！</p>
					</div>
				</c:when>
				
				<c:otherwise>
					<c:forEach var="order" items="${orders}">
						<a href="<c:url value="/user/orderInfo?orderId=${order.id}"/>">
							<div class="col-md-12 rev"
								style="padding: 10px; margin-bottom: 5px;">
								<p>${order.submitDate}</p>
								<p>${order.goodName}</p>
							</div>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
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

	function cancelOrder() {
		$.getJSON("/cjz/user/order/cancle/" + ${orderInfo.id}, function (data) {
			if (data === true){
				alert("订单取消成功！");
				$(window).attr('location','/cjz/user/userProfile');
			} else {
				alert("订单取消失败！");
			}
		})
	}

    function selectValue() {
        $.getJSON("/cjz/user/order/update/status/" + ${orderInfo.id} + "&3", function (data) {
            if (data === false){
                alert("操作失败！");
            } else {
                document.getElementById("cancel").style.display = "none";
                document.getElementById("cancelSuccess").style.display = "none";
				document.getElementById("success").style.display = "none";
				document.getElementById("noSuccess").style.display = "";
                document.getElementById("order").innerHTML = "<p style=\"color: #666666; height: 30px\"><B>" + data.id + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.goodName + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.seller + "</B></p>" +
					"<p style=\"color: #666666; height: 30px\"><B>" + data.sellerMobile + "</B></p>" +
					"<p style=\"color: #666666; height: 30px\"><B>" + data.sellerAddress+ "</B></p>" +
					"<p style=\"color: #666666; height: 30px\"><B>-----------------------</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.customer + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.customerMobile + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.customerAddress + "</B></p>" +
					"<p style=\"color: #666666; height: 30px\"><B style=\"color: blue\">${data.statusId == 2 ? '交易中':'交易完成' }</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.submitDate + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.endDate + "</B></p>";
            }
        })
    }

	function selectOrder() {
		$.getJSON("/cjz/user/order/cancel/status/" + ${orderInfo.id} + "&1" + "&${orderInfo.goodId}", function (data) {
            if (data === false){
				alert("订单取消失败！");
			}else {
				document.getElementById("success").style.display = "none";
				document.getElementById("noSuccess").style.display = "none";
				document.getElementById("cancel").style.display = "none";
				document.getElementById("cancelSuccess").style.display = "";
				document.getElementById("order").innerHTML = "<p style=\"color: #666666; height: 30px\"><B>" + data.id + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.goodName + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.seller + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.sellerMobile + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.sellerAddress+ "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>-----------------------</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.customer + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.customerMobile + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.customerAddress + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B style=\"color: red\">${data.statusId == 1 ? '交易取消':'交易取消' }</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.submitDate + "</B></p>" +
						"<p style=\"color: #666666; height: 30px\"><B>" + data.endDate + "</B></p>";
			}
		})
	}
</script>
<script src="<c:url value="/statics/bootstrap-4.3.1/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.js"/>"></script>
<script
	src="<c:url value="/statics/jquery-ui-1.13.2/datepicker-zh-CN.js"/>"></script>
</body>
</html>