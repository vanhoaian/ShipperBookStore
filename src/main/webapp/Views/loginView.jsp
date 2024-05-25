<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang đăng nhập phía máy khách</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bookstore_style.css">
</head>
<body>
	<div align="center">
		<h3>Trang đăng nhập</h3>
		<p style="color: red;">${errors}</p>
		<form action="login" method="POST">
			<table border="0">
				<tr>
					<td>Tài khoản</td>
					<td><input value="${loginForm.username}" type="text"
						name="username" required="required" /></td>
				</tr>
				<tr>
					<td>Mật khẩu</td>
					<td><input type="password" name="password"
						value="${loginForm.password}" /></td>
				</tr>
				
				<tr>
				<td>Ghi nhớ</td>
				<td><input type="checkbox" name="rememberMe" id="rememberMe" value="${loginForm.rememberMe }"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="Đăng nhập" />
					<a href="${pageContext.request.contextPath }">Bỏ qua</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>