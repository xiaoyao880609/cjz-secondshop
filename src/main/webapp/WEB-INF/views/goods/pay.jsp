<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>支付页面</title>
    <link rel="stylesheet"
          href="<c:url value="/statics/bootstrap-4.3.1/css/bootstrap.css"/>">
    <link rel="stylesheet"
          href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.css"/>">
    <link rel="stylesheet"
          href="<c:url value="/statics/jquery-ui-1.13.2/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <link rel="stylesheet"
          href="<c:url value="/statics/css/swiper.min.css"/>">
    <link rel="stylesheet"
          href="<c:url value="/statics/css/simpleAlert.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
    <script src="<c:url value="/statics/js/simpleAlert.js"/>"></script>
    <script src="<c:url value="/statics/js/swiper.min.js"/>"></script>
    <style>
        body {
            font-family: "微软雅黑", serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 800px;
            margin: 0 auto;
            border: 1px solid #ddd;
        }
        .header {
            height: 80px;
            background-color: #108ee9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .logo {
            width: 120px;
            height: 40px;
            margin-left: 20px;
        }
        .title {
            color: white;
            font-size: 24px;
            margin-right: 20px;
        }
        .content {
            padding: 20px;
        }
        .order-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .order-name {
            font-size: 18px;
        }
        .order-price {
            color: red;
            font-size: 24px;
        }
        .pay-methods {
            margin-top: 20px;
        }
        .pay-method {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .pay-icon {
            width: 40px;
            height: 40px;
        }
        .pay-name {
            font-size: 18px;
            margin-left: 10px;
        }
        .pay-button {
            width: 100%;
            height: 40px;
            background-color: #108ee9;
            color: white;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
        }
        .popup {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .popup h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .popup p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .popup button {
            padding: 8px 20px;
            background: #1abc9c;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
    </style>
    <script>
        function getPayButton() {
            if(${sessionScope.user.name == null}) {
                alert("请重新登录！");
                $(window).attr('location','/cjz/login');
            }
            show();
        }
        function show() {
            var overlay = document.querySelector(".overlay");
            var popup = document.querySelector(".popup");
            var closePopup = document.querySelector("#closePopup");

            overlay.style.display = "block"; // 显示遮盖层
            popup.style.display = "block"; // 显示弹窗

            closePopup.onclick = function() {
                overlay.style.display = "none"; // 隐藏遮盖层
                popup.style.display = "none"; // 隐藏弹窗
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="<c:url value="/statics/image/logo/alipay-logo.png"/>" alt="支付宝" class="logo">
            <span class="title">支付宝 - 知托付！</span>
        </div>
        <div class="content">
            <div class="overlay"></div>
            <div class="order-info">
                <span class="order-name">订单名称：购买${goodInfo.name}</span>
                <span class="order-price">￥${goodInfo.prise}</span>
            </div>
            <div style="text-align: center">
                <img src="${goodInfo.photoUrl}" alt="商品" width="20%" height="20%">
            </div>
            <div class="pay-methods">
                <div class="pay-method">
                    <input type="radio" name="pay-method" value="alipay" checked>
                    <img src="<c:url value="/statics/image/logo/alipay-icon.png"/>"  alt="支付宝" class="pay-icon">
                    <span class="pay-name">支付宝</span>
                </div>
                <div class="pay-method">
                    <input type="radio" name="pay-method" value="wechat">
                    <img src="<c:url value="/statics/image/logo/wechat-icon.png"/>"  alt="微信" class="pay-icon">
                    <span class="pay-name">微信</span>
                </div>
                <button class="pay-button" onclick="show();"
                        style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? 'none':''}">
                    立即付款
                </button>
                <button onClick="javascript :history.back(-1);" class="pay-button"
                        style="margin-top: 10px">取消付款</button>
<%--                </c:when>--%>
            </div>

            <div class="popup">
                <h2>请扫码支付</h2>
                <p>支付金额：${goodInfo.prise}</p >
                <img src="<c:url value="/statics/image/logo/pay.png"/>" alt="支付二维码" style="width: 50%;height: 50%;">
                <div>
                    <button id="success" onclick="getPay()">已支付</button>
                    <button id="closePopup">未支付</button>
                </div>
            </div>
        </div>
    </div>
<script>
    function getPay() {
        if (${sessionScope.user == null } || ${sessionScope.user.name == null}) {
            alert("请先登录！");
            $(window).attr('location','/cjz/login');
        } else {
            alert("请稍等！正在创建订单！");
            const order = {
                "goodName": "${goodInfo.name}",
                "seller": "${goodInfo.goodUser.name}",
                "sellerId": ${goodInfo.goodUser.id},
                "sellerMobile": ${goodInfo.goodUser.mobile},
                "sellerAddress": "${goodInfo.goodUser.address}",
                "customer": "${sessionScope.user.name}",
                "customerId": "${sessionScope.user.id}",
                "customerMobile": ${sessionScope.user.mobile},
                "customerAddress": "${sessionScope.user.address}",
                "goodId": ${goodInfo.id},
                "money": ${goodInfo.prise}
            };
            console.log(order);
            $.ajax({
                type:"POST",
                url:"/cjz/user/order/create",
                contentType: "application/json", //必须这样写
                dataType:"json",
                data:JSON.stringify(order),//要提交是json字符串
                success:function (data) {
                    if (data === false){
                        alert("由于未知原因，订单创建失败！");
                    } else {
                        alert("订单创建成功，请及时与卖家联系，线下验货交易！");
                        $(window).attr('location','/cjz/user/orderInfo?orderId=' + data);
                    }
                }
            });
        }
    }
</script>
</body>
</html>