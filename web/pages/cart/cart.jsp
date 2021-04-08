<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>购物车</title>

	<%--静态包含 base标签 css样式 jQuery文件--%>
	<%@include file="/pages/common/head.jsp"%>
	<script type="text/javascript">
		$(function () {
			$("a.deleteItem").click(function () {
				return confirm("确定删除【" + $(this).parent().parent().find("td:first").text()+ "】");
			});
			// 给清空购物车绑定单击事件
			$("#clearCart").click(function () {
				return confirm("你确定要清空购物车吗？");
			});
			// 给输入框绑定 onchange 内容发生改变事件
			$(".updateCount").change(function () {
				// 获取商品名称
				let name = $(this).parent().parent().find("td:first").text();
				let id = $(this).attr("bookId");
				// 获取商品数量
				let count = this.value;
				if ( confirm("你确定要将【" + name + "】商品修改数量为：" + count + " 吗?") ) {
				//发起请求。给服务器保存修改
					location.href =
							"http://localhost:8080/book/cartServlet?action=updateCount&count="+count+"&id="+id;
				} else {
				// defaultValue 属性是表单项 Dom 对象的属性。它表示默认的 value 属性值。
					this.value = this.defaultValue;
				}
			});

		});
	</script>

</head>
<body>
	
	<div id="header">
			<img class="logo_img" alt="" src="static/img/logo.gif" >
			<span class="wel_word">购物车</span>
			<%--jsp静态包含 登录成功的页面--%>
			<%@ include file="/pages/common/login_success_menu.jsp"%>
	</div>
	
	<div id="main">
	
		<table>
			<tr>
				<td>商品名称</td>
				<td>数量</td>
				<td>单价</td>
				<td>金额</td>
				<td>操作</td>
			</tr>
			<C:if test="${empty sessionScope.cart.items}">
				<%--如果购物车空的情况--%>
				<tr>
					<td colspan="5"><a href="index.jsp">当前购物车为空</a> </td>
				</tr>
			</C:if>



			<C:if test="${not empty sessionScope.cart.items}">
				<%--如果购物车非空的情况--%>
				<C:forEach items="${sessionScope.cart.items}" var="entry">
					<tr>
						<td>${entry.value.name}</td>
						<td>
							<input bookId="${entry.value.id}" class="updateCount" type="text" value="${entry.value.count}" style="width: 80px">
						</td>
						<td>${entry.value.price}</td>
						<td>${entry.value.totalPrice}</td>
						<td><a class="deleteItem" href="cartServlet?action=deleteItem&id=${entry.value.id}">删除</a></td>
					</tr>
				</C:forEach>

			</C:if>

		</table>

		<%--如果购物车非空才输出页面的内容--%>
		<C:if test="${not empty sessionScope.cart.items}">
			<div class="cart_info">
				<span class="cart_span">购物车中共有<span class="b_count">${sessionScope.cart.totalCount}</span>件商品</span>
				<span class="cart_span">总金额<span class="b_price">${sessionScope.cart.totalPrice}</span>元</span>
				<span class="cart_span"><a id="clearCart" href="cartServlet?action=clear">清空购物车</a></span>
				<span class="cart_span"><a href="orderServlet?action=createOrder">去结账</a></span>
			</div>
		</C:if>

	
	</div>

	<%--静态包含页脚内容--%>
	<%@include file="/pages/common/footer.jsp"%>

</body>
</html>