# 转合二手商城

这是一个基于Java的Spring MVC框架开发的二手商品交易平台，支持用户注册、登录、商品发布、收藏、交易等功能。

## 功能特性

- **用户系统**：支持用户注册、登录、信息修改、头像上传等功能
- **商品管理**：用户可以发布、编辑、删除商品，上传商品图片
- **商品浏览**：支持首页展示、分类浏览、搜索功能
- **收藏系统**：用户可以收藏喜欢的商品
- **交易系统**：支持订单创建、查看、取消、删除等操作
- **评论系统**：支持商品评论及回复
- **后台管理**：管理员可以管理用户、商品、订单等信息

## 技术栈

- Java 8
- Spring MVC
- MyBatis
- MySQL
- Bootstrap 4
- jQuery
- HTML5/CSS3

## 目录结构

```
src/
├── main/
│   ├── java/                # Java源代码
│   ├── resources/             # 配置文件
│   └── webapp/                # Web资源
│       └── WEB-INF/
│           └── views/         # JSP视图文件
└── pom.xml                    # Maven项目配置
```

## 安装指南

1. 克隆仓库：
   ```bash
   git clone https://github.com/xiaoyao880609/cjz-secondshop.git
   ```

2. 创建数据库并导入`sql/secondshop.sql`

3. 修改数据库连接配置：
   ```properties
   # src/main/resources/db.properties
   jdbc.url=jdbc:mysql://localhost:3306/secondshop?useSSL=false&serverTimezone=UTC
   jdbc.username=root
   jdbc.password=your_password
   ```

4. 商品图片相关配置：
   将工程的webapp/statics下的images文件夹复制到tomcat的webapps下，并将路径配置到web.xml中的UPLOAD_IMAGE_PATH中

5. 使用Maven构建项目：
   ```bash
   mvn clean package
   ```

6. 部署到Tomcat服务器

## 使用说明

### 用户功能
- 注册：`/register`
- 登录：`/login`
- 发布商品：`/goods/publishGood`
- 浏览商品：`/`
- 收藏商品：`/collect/insert`
- 创建订单：`/user/order/create`
- 查看订单：`/user/orderInfo`

### 管理员功能
- 登录：`/admin/adminLogin`
- 管理用户：用户管理相关接口
- 管理商品：`/admin/goods/allGoods`
- 管理订单：`/admin/orderInfo`

## API文档

### 商品相关
- `GET /`：获取首页商品列表
- `GET /goods/goodInfo`：获取商品详情
- `GET /goods/publishGood`：获取发布商品页面
- `POST /goods/publishGood`：提交新商品
- `POST /goods/publishGood/uploadImage`：上传商品图片
- `GET /goods/userGoods`：查看用户发布的商品
- `GET /goods/userGoodEdit`：获取商品编辑页面
- `POST /goods/userGoodEdit`：提交商品修改
- `GET /goods/userGoodEdit/delete/{goodId}`：删除商品
- `GET /goods/userGoodEdit/updateGoodStatus/{goodId}`：更新商品状态
- `GET /admin/goods/allGoods`：管理员查看所有商品

### 用户相关
- `GET /login`：获取登录页面
- `POST /login`：提交登录
- `GET /register`：获取注册页面
- `POST /register`：提交注册
- `GET /logout`：用户登出
- `GET /userProfile`：查看用户资料
- `GET /userEdit`：获取用户资料编辑页面
- `POST /userEdit`：提交用户资料修改
- `POST /password/edit`：修改密码

### 收藏相关
- `POST /collect/insert`：添加收藏
- `GET /collect/delete/{collectId}&{userId}`：删除收藏

### 订单相关
- `GET /user/orderInfo`：查看订单详情
- `GET /admin/orderInfo`：管理员查看订单详情
- `GET /user/sellerInfo`：查看卖家订单信息
- `GET /user/order/delete/{orderId}`：删除订单
- `GET /user/order/cancel/status/{orderId}&{statusId}&{goodId}`：取消订单
- `GET /user/sellerOrder/delete/{orderId}&{goodId}`：卖家删除订单
- `GET /user/order/update/status/{orderId}&{statusId}`：更新订单状态
- `POST /user/order/create`：创建新订单
- `GET /user/order/allOrder`：获取所有订单

### 评论相关
- `POST /goods/goodInfo`：提交评论或回复

### 分类相关
- `GET /type/secondType/{firstTypeId}`：获取二级分类
- `POST /type/secondType/create`：创建二级分类
- `POST /type/firstType/create`：创建一级分类

### 管理员相关
- `GET /adminPage`：管理员主页
- `GET /user/delete/{userId}`：删除用户
- `GET /user/update/status/{statusId}&{userId}`：更新用户状态
