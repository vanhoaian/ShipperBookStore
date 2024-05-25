<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div style="padding: 5px; text-align: center;" id="myDIV">
	<a href="${pageContext.request.contextPath}/adminHome" class="item">Trang
		chủ</a> | <a
		href="${pageContext.request.contextPath }/adminOrderList/waiting"
		class="item">Các đơn hàng chưa xác nhận</a> | <a
		href="${pageContext.request.contextPath }/adminOrderList/delivering"
		class="item">Các đơn hàng đang chờ giao</a> | <a
		href="${pageContext.request.contextPath }/adminOrderList/delivered"
		class="item">Các đơn hàng đã giao</a> | <a
		href="${pageContext.request.contextPath }/adminOrderList/confirm-reject"
		class="item">Các đơn hàng khách trả lại cần xác nhận</a>| <a
		href="${pageContext.request.contextPath }/adminOrderList/reject"
		class="item">Các đơn hàng khách trả lại</a>
		
</div>
<style>
.active {
	color: red; /* Đổi màu tùy chọn cho liên kết đã chọn */
}
</style>
<script>
	// Lấy tất cả các liên kết
	var links = document.querySelectorAll('a');

	// Lặp qua mỗi liên kết và thêm sự kiện click
	links.forEach(function(link) {
		link.addEventListener('click', function() {
			// Xóa lớp 'active' từ tất cả các liên kết
			links.forEach(function(otherLink) {
				otherLink.classList.remove('active');
			});

			// Thêm lớp 'active' vào liên kết đã nhấp vào
			this.classList.add('active');

			// Lưu trạng thái của liên kết đã chọn vào sessionStorage
			sessionStorage.setItem('selectedLink', this.getAttribute('href'));
		});
	});

	// Kiểm tra nếu có liên kết được lưu trong sessionStorage
	var selectedLink = sessionStorage.getItem('selectedLink');
	if (selectedLink) {
		// Tìm liên kết tương ứng và thêm lớp 'active'
		var link = document.querySelector('a[href="' + selectedLink + '"]');
		if (link) {
			link.classList.add('active');
		} else {
			// Nếu không tìm thấy liên kết, hãy xóa trạng thái đã lưu khỏi sessionStorage
			sessionStorage.removeItem('selectedLink');
		}
	}
</script>

	<%-- <c:set var="url"
		value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:set var="url1" value="${pageContext.request.contextPath}/adminHome" />
	<c:set var="url2"
		value="${pageContext.request.contextPath}/adminOrderList/waiting" />
	<c:set var="url3"
		value="${pageContext.request.contextPath}/adminOrderList/delivering" />
	<c:set var="url4"
		value="${pageContext.request.contextPath}/adminOrderList/delivered" />
	<c:set var="url5"
		value="${pageContext.request.contextPath}/adminOrderList/reject" />
 --%>
	