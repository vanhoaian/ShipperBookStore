<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="leftcolumn">
	<div class="block">
		<div class="v_menu">
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách thiếu nhi</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách ngoại ngữ</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách kỹ năng sống</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách nuôi dạy con</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách cổ học tinh hoa</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách kinh tế - xã hội</a>
		<a href=""><i class="fa fa-book" style="color: red"></i>Sách khoa học - công nghệ</a>
		</div>
	</div>
	
	<div class="block" align="center">
		<h2>Sách mới</h2>
		<div>
			<c:forEach items="bookList" var="book">
				<img class="mySlides" id="bookImage" alt="" src="book.imagePath" width="70%">
			
			</c:forEach>
		</div>
		
		<script>
			var myIndex = 0;
			carousel();
			
			function carousel() {
				let x = document.getElementsByClassName("mySlides");
				
				for(let i =0; i< x.length; i++){
					x[i].style.display = "none";
				}
				myIndex++;
				if(myIndex > x.length){myIndex = 1}
				x[myIndex-1].style.display = "block";
				setTimeout(carousel,8000)
			}
		
		</script>
	</div>
	
	<div class="block">
	<h3>Đăng kí nhận mail</h3>
	<input type = "text" placeholder="Nhập email...">
	<button class="green_button" style="margin-top: 15px;padding: 15px;padding-top: 5px;padding-bottom: 5px">Gửi<i class="fa fa-send-o" style="color: white"></i></button>
	</div>
</div>