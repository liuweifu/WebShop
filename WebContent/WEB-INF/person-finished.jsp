<!DOCTYPE html>
<html lang="zh-Hans">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html lang="zh-Hans">
<%
	if (session.getAttribute("currentUser") == null) {
		response.sendRedirect("/WebShop/login/signin.jsp");
	}
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>已完成的</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css">
    <!-- Custom styles for this template -->
    <link href="css/person.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="libs/iconfont/iconfont.css">
</head>

<body>
<div class="top-nav cf">
    <div class="top-nav-inner">
        <div class="top-nav-l fl">
            大学生 C2C 交易平台
        </div>
        <div class="top-nav-r fr">
            <s:if test="#session.currentUser==null">
					<div class="not-login">
						<a class="active" href="/WebShop/login/signin.jsp">亲,请登录</a> <a
							href="/WebShop/login/signup.jsp">免费注册</a> <a
							href="/WebShop/UserGoodAction?pageCount=0">个人中心</a>
					</div>
				</s:if>
				<s:else>
					<div class="log-in">
						<a class="active"><s:property
								value='#session.currentUser.user_username' /></a> <a
							href="/WebShop/SaledGoodListAction?pageCount=0">已发布商品</a> <a
							href="/WebShop/UserGoodAction?pageCount=0">个人中心</a>
						<s:if test="#session.currentUser.manager">
							<a href="/WebShop/UserListAction?pageCount=0" class="">管理中心</a>
						</s:if>
					<a href="/WebShop/LogoutAction">注销</a>
					</div>
				</s:else>
        </div>
    </div>
</div>
<!-- #############################这里变了START#############################--><div class="header">
		<div class="header-inner cf">
			<div class="header-logo fl"></div>

			<div class="header-search fr">
				<form method="post" action="/WebShop/GoodListAction" name="search">
					<input class="input-search" id="HeaderSearchQuery" name="essential"
						type="text" value="" placeholder="搜宝贝" autocomplete="off">
					<button class="btn-search" type="submit">
						<i class="iconfont icon-sousuo"></i><span class="search-img"></span>
					</button>
				</form>
			</div>
		</div>
	</div>
	<div class="header-nav">
		<ul class="header-menu cf">
			<li class=""><a href="/WebShop/IndexAction">首页</a></li>
			<li class=""><a
				href="/WebShop/GoodListAction?type=0&pageCount=0">二手商城</a></li>
			<li class=""><a href="/WebShop/UserGoodAction?pageCount=0">个人中心</a></li>
			<li class=""><a href="/WebShop/publish.jsp">发布商品</a></li>
			<s:if test="#session.currentUser.manager">
				<li class=""><a href="/WebShop/UserListAction?pageCount=0"
					class="">管理中心</a></li>
			</s:if>
		</ul>
	</div>
<!-- #############################这里变了END#############################-->
<div class="page">
    <div class="content person cf">

        <div class="leftside">
            <div class="user-info">
                <div class="user-avatar">
                    <s:if test="#session.currentUser.headImage!=null">
							<img src='<s:property value="#session.currentUser.headImage"/>'
								alt="">
						</s:if>
						<s:else>
							<img
								src="https://img.alicdn.com/bao/uploaded/i1/181510260073118980/TB2glCLtFXXXXanXpXXXXXXXXXX_!!0-mytaobao.jpg"
								alt="">
						</s:else>
                </div>
              <a href="#" class="user-nick"><s:property
							value="#session.currentUser.user_username" /></a>
            </div>
            <ul class="navigations">
                <li class=""><a href="/WebShop/person-info.jsp">个人信息</a></li>
					<li class=""><a href="/WebShop/UserGoodAction?pageCount=0">正在出售</a></li>
					<li class=""><a href="/WebShop/SaledGoodListAction?pageCount=0">已售出的</a></li>
					<li class="selected"><a href="/WebShop/CompleteGoodListAction?pageCount=0">已买到的</a></li>
					<s:if test="#session.currentUser.manager">
						<li class=""><a href="/WebShop/UserListAction?pageCount=0">管理中心</a></li>
					</s:if>
            </ul>
        </div>
        <div class="main-content">
            <!--当里面没内容的时候,将class hidden去掉,在下面resell-list里加入hidden-->
            <div class="empty-page no-orders hidden">
                <p class="tips-title">亲,这里似乎什么东西都没有哦</p>
                <a href="#" type="button" class="btn btn-success btn-block btn-publish">发布宝贝</a>
            </div>
            <div id="resell-list" class="">
                <!-- 列表头 -->
                <div class="hd">
                    <table>
                        <thead>
                        <tr>
                            <th class="item-info">宝贝</th>
                            <th class="unit">原价（元）</th>
                            <th class="amount">数量</th>
                            <th class="pay">成交价（元）</th>
                            <th class="operation">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>

                <!-- 列表主体 -->
                <div class="bd">
                    <ul>

                      <s:iterator value="#request.goods" var="index" status="status">
									<li class="selected">
										<table class="table">
											<tbody>
												<tr>
													<td colspan="5" class="deal-date">时间：<s:property
															value="#index.goodId.createDate" /> &nbsp;&nbsp;订单号：<s:property
															value="#index.goodId.goodId" /></td>
												</tr>
												<tr>
													<td class="item-info"><s:if
															test="#index.goodId.firstImage !=null">
															<a
																href="/WebShop/GoodInfoAction?goodId=<s:property value='#index.goodId.goodId' />"
																target="_blank"><img alt="暂无图片"
																src="<s:property value='#index.goodId.firstImage'/>"></a>
														</s:if> <s:else>
															<a
																href="/WebShop/GoodInfoAction?goodId=<s:property value='#index.goodId.goodId' />"
																target="_blank"><img alt="暂无图片"
																src="/WebShop/img/noimg.jpg"></a>
														</s:else>
														<p class="title">
															<a
																href="/WebShop/GoodInfoAction?goodId=<s:property value='#index.goodId.goodId' />"
																target="_blank"><s:property value="#index.goodId.goodName" /></a>
														</p>
														<p class="attr"></p> <s:if test="#index.goodId.goodType == 1">
															<p class="attr">类型:全新宝贝</p>
														</s:if> <s:else>
															<p class="attr">类型:二手宝贝</p>
														</s:else>
														<p></p></td>
													<td class="unit"><s:property
															value="#index.goodId.formerPrice" /></td>
													<td class="amount"><s:property value="#index.goodId.goodNum" /></td>
													<td rowspan="1" class="pay">
														<p>
															<s:property value="#index.goodId.salePrice" />
														</p>
														<p class="sub"></p>
													</td>
												</tr>
											</tbody>
										</table>
									</li>
								</s:iterator>
							</ul>
						</div>

				<s:if test="#request.goods!=null">
					<div class="page-nav">
						<nav>
							<ul class="pagination">
								<s:bean name="org.apache.struts2.util.Counter" id="counter">
									<s:param name="first" value="1" />
									<s:param name="last" value="#request.pageNum	+1" />
									<s:iterator>
										<li><a
											href="/WebShop/CompleteGoodListAction?pageCount=<s:property value="current-1-1"/>"><s:property
													value="current-1" /> </a></li>
									</s:iterator>
								</s:bean>
							</ul>
						</nav>
					</div>
				</s:if>
				<s:else></s:else>
			</div>
		</div>


	</div>
	</div>

	<div class="footer">
		<p>2016 Copyright &copy 浙江省大学生科技创新活动计划暨新苗人才计划2014R453004项目组</p>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="libs/bootstrap/js/bootstrap.min.js"></script>
	<script>
		$(".js-btn-message")
				.on(
						"click",
						function() {
							$(this).closest("table").closest("li").find(
									".js-table-message").fadeToggle("normal",
									"linear");
						})
	</script>
</body>
</html>
