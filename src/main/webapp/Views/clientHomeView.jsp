<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bookstore_style.css">
<title>Website Cửa Hàng Sách</title>
<style>
.mySlydes {
	display: none
}
 @charset "UTF-8";
th, td{
	padding: 5px;
	border-bottom: 1px solid #ddd;
}
table{
	border-collapse: collapse;
}
*{
	box-sizing: border-box;
}

body{
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	font-size: 13px;
	padding: 10px;
	background: #f1f1f1;
}
.header{
	padding: 60px;
	text-align: center;
	background: white;
	position: relative;
}

.red_button{
	background-color: #ec0000;
	border: none;
	color: white;
	padding: 7px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	cursor: pointer;
	border-radius: 6px;
	
}

.red_button:hover{
	background-color: #ce0000;
	color: white;
}

.green_button{
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 7px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	cursor: pointer;
	border-radius: 6px;
	
}

.green_button:hover{
	background-color: #316f34;
	color:white;
}


input[type=text],input[type=password]{
	width: 100%;
	padding: 5px 5px;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px ;
	box-sizing: border-box;
}

.header a{
	color: black;
	text-align: center;
	text-decoration: none;
	line-height: 25px;
	padding: 10px;
	border-radius: 4px;
}

.header a:hover{
	background-color: #ddd;
	color: black;
}

.header_right{
	float: right;
	top: 10px;
	right: 20px;
	position: absolute;
}

.header_left{
	float: left;
	cursor: pointer;
	width: 150px;
	height: auto;
}

.h_menu{
	overflow: hidden;
	background-color: #333;
}
.h_menu a{
	float: left;
	display: block;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

.h_menu a:hover{
	background-color: #ddd;
	color: black;
}

.h_menu input[type = text]{
	float: right;
	border: none;
	margin-top: 8px;
	margin-right:16px ;
	width: 18%;
}

.v_menu{
	width: 100%;
	
}

.v_menu a{
	background-color: #eee;
	color: black;
	display: block;
	padding: 10px;
	text-decoration: none;
}

.v_menu a:hover{
	background-color: #ccc;
	
}

.footer{
	padding: 20px;
	text-align: center;
	background: #ddd;
	margin-top: 20px;
}

.row{
	display: table;
	width: 100%;
}

.leftcolumn{
	float: left;
	width: 25%;
}

.rightcolumn{
	float: left;
	width: 75%;
	background-color: #f1f1f1;
	padding-left: 20px;
}

.block{
	background-color: white;
	padding: 20px;
	margin-top: 20px;
	width: 100%;
	display: table;
}

.item_content{
	padding: 10px;
	margin: 0px 20px 20px 20px;
	text-align: center;
	background-color: #ffffff;
	float: left;
	width: calc(25% - 40px);;
	box-sizing: border-box;
}

.item_content:hover{
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
}
@media screen and (max-width: 800px){
	.leftcolumn,.rightcolumn{
		width: 100%;
		padding: 0;
	}
}

@media screen and (max-width: 400px){
	.h_menu a{
		float: none;
		width: 100%;
	}
	.h_menu input[type=text]{
		float: none;
		width: 100%;
		border-radius: 0px;
	}
	.header_left{
		float: none;
	}
	.header_right{
		float: none;
		position: relative;
	}
	.item_content{
		width: 100%;
		display: block;
		margin: 0px;
		margin-bottom: 20px;
	}
}
</style>
</head>

<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_menu.jsp"></jsp:include>
	<div class="row">
		<jsp:include page="_left_sidebar.jsp"></jsp:include>
		<div id="searchListArea">
			<div class="rightcolumn">
				<div class="block" align="center" id="searchResult">
					<c:forEach items="${bookList}" var="book">
						<a href="detailBook?bookId=${book.bookId}">
						<div class="item_content">
							<img id="bookImage" alt="" src="${book.imagePath}" height="200px"
								style="max-width: 100%" />
							<p style="height: 30px; margin: 5px;">
								<b>${book.title}</b>
							</p>
							<hr>
							<p style="margin: 5px;">
								<fmt:formatNumber type="number" maxFractionDigits="0"
									value="${book.price}" />
								<sup>đ</sup> &nbsp;&nbsp;
							</p>
						</div>
						</a>
					</c:forEach>

					<p style="color: red;">${errors}</p>
				</div>
				<div class="block" align="center">
					<!-- không có hoạt động tìm kiếm -->
					<c:if test="${empty keyword }">
						<div style="margin-top: 5px">
							<!-- link previous chỉ xuất hiện khi trang hiện tại lớn hơn 1 -->
							<c:if test="${currentPage gt 1 }">
								<a href="clientHome?page=${currentPage - 1} ">Previous</a> &nbsp;
				</c:if>
							<c:forEach begin="1" end="${noOfPages }" var="i">
								<c:choose>
									<c:when test="${currentPage eq i}">
										<!-- Trùng lặp trang hiện tại thì không tạo link -->
							&nbsp;${i}&nbsp;
						</c:when>
									<c:otherwise>
							&nbsp;<a href="clientHome?page=${i}">${i}</a>&nbsp;
						</c:otherwise>
								</c:choose>
							</c:forEach>

							<!-- Link Next chỉ xuất hiện khi trang hiện tại nhỏ hơn tổng số trang -->
							<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a href="clientHome?page=${currentPage + 1}">Next</a>
							</c:if>
						</div>
					</c:if>


					<!--có hoạt động tìm kiếm, thêm tham số keyword -->
					<c:if test="${not empty keyword }">
						<div style="margin-top: 5px">
							<c:if test="${currentPage gt 1}">
								<a href="clientHome?page=${currentPage - 1}&keyword=${keyword}">Previous</a>&nbsp;
				</c:if>
							<c:forEach begin="1" end="${noOfPages }" var="i">
								<c:choose>
									<c:when test="${currentPage eq i}">
							&nbsp;${i}&nbsp;
						</c:when>
									<c:otherwise>
							&nbsp;<a href="clientHome?page=${i}&keyword=${keyword}">${i}</a>&nbsp;
						</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a
									href="clientHome?page=${currentPage + 1}&keyword=${keyword}">Next</a>
							</c:if>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>