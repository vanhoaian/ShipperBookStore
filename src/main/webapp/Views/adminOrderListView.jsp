<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vnua.fita.bookstore.util.Constant"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bookstore_style.css">
<title>Trang chủ phía admin</title>
</head>
<body>
	<jsp:include page="_header_admin_order.jsp"></jsp:include>
	<jsp:include page="_menu_backend.jsp"></jsp:include>
	<div align="center">
	
		<h3>DANH SÁCH ĐƠN HÀNG ${listType }</h3>
		
		<input name="keyword" id="keyword" value="${keyword}"
			placeholder="Tìm mã đơn hàng"
			onkeyup="activeAsAjax('${pageContext.request.contextPath}/${servletUrl}?keyword='+this.value)" />
		
		<form id="adminOrderForm" method="POST" action="">
			<input type="hidden" name="orderId" id="orderIdOfAction" /> <input
				type="hidden" name="confirmType" id="confirmTypeOfAction" />
				
		</form>

		<p style="color: red;">${errors }</p>
		<p style="color: blue;">${message }</p>
		<div id="searchListArea">
		<table border="1">
			<tr>
				<th>Mã hóa đơn</th>
				<th>Tên khách</th>
				<th>Số điện thoại</th>
				<th>Ngày đặt mua</th>
				<th>Ngày xác nhận</th>
				<th>Địa chỉ nhận sách</th>
				<th>Phương thức thanh toán</th>
				<th>Trạng thái đơn hàng</th>
				<th>Thao tác</th>
			</tr>
			<c:forEach items="${orderListOfCustomer}" var="orderOfCustomer">
				<tr>
					<td>${orderOfCustomer.orderNo }</td>
					<td>${orderOfCustomer.customer.fullname }</td>
					<td>${orderOfCustomer.customer.mobile }</td>
					<td><fmt:formatDate value="${orderOfCustomer.orderDate }"
							pattern="dd-MM-yyyy HH:mm" /></td>
					<td><fmt:formatDate
							value="${orderOfCustomer.orderApproveDate }"
							pattern="dd-MM-yyyy HH:mm" /></td>
					<td>${orderOfCustomer.deliveryAddress }</td>
					<td>${orderOfCustomer.paymentModeDescription }<br /> <c:if
							test="${Constant.TRANSFER_PAYMENT_MODE.equals(orderOfCustomer.paymentMode) }">
							<button
								onclick="document.getElementById('divImg${orderOfCustomer.orderId}').style.display='block'">Xem
								chi tiết</button>
							<button
								onclick="document.getElementById('divImg${orderOfCustomer.orderId}').style.display='none'">Ẩn</button>
							<div id="divImg${orderOfCustomer.orderId}"
								style="display: none; padding-top: 5px;">
								<img alt="Transfer Image"
									src="${orderOfCustomer.paymentImagePath }"
									width="150" />
							</div>
						</c:if>
					</td>
					<td>${orderOfCustomer.orderStatusDescription }<c:if
							test="${Constant.WAITING_CONFIRM_ORDER_STATUS != orderOfCustomer.orderStatus}">
							&nbsp;-
							&nbsp;${orderOfCustomer.paymentStatusDescription}
						</c:if>
					</td>
					<td>
						<button
							onclick="document.getElementById('div${orderOfCustomer.orderId}').style.display='block'">Xem
							chi tiết</button>
						<button
							onclick="document.getElementById('div${orderOfCustomer.orderId}').style.display='none'">Ẩn</button>
						<div id="div${orderOfCustomer.orderId}" style="display: none;">
							
							<h3>Các cuốn sách trong hóa đơn</h3>
							<table border="1">
								<tr style="background: yellow;">
									<th>Tiêu đề</th>
									<th>Tác giả</th>
									<th>Giá tiền</th>
									<th>Số lượng mua</th>
									<th>Tổng thành phần</th>
								</tr>
								<c:forEach var="cartItem"
									items="${orderOfCustomer.orderBookList }">
									<tr>
										<td>${cartItem.selectedBook.title }</td>
										<td>${cartItem.selectedBook.author }</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="0"
												value="${cartItem.selectedBook.price }" /><sup>đ</sup></td>
										<td>${cartItem.quantity }</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="0"
												value="${cartItem.selectedBook.price*cartItem.quantity }" /><sup>đ</sup></td>
									</tr>
								</c:forEach>
							</table>
							<br /> Tổng số tiền: <b> <span><fmt:formatNumber
										type="number" maxFractionDigits="0"
										value="${orderOfCustomer.totalCost }" /></span> <sup>đ</sup>
							</b>
							<c:if
								test="${Constant.WAITING_CONFIRM_ORDER_STATUS == orderOfCustomer.orderStatus }">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button
									onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.DELEVERING_ORDER_STATUS },'${Constant.WAITING_APPROVE_ACTION }')">Xác
									nhận đơn</button>
							</c:if>
							<c:if
								test="${Constant.DELEVERED_ORDER_STATUS==orderOfCustomer.orderStatus }">
								<br />
								<br />
								Ảnh xác nhận đã giao đơn hàng: <br />
								<img alt="Delivered Image"
									src="${orderOfCustomer.deliveryImagePath }"
									width="150" />
							</c:if>
							<c:if
								test="${Constant.CONFIRM_REJECT_ORDER_STATUS==orderOfCustomer.orderStatus }">
								<br />
								<br />
								Ảnh xác nhận trạng thái đơn hàng <br />
								<img alt="Delivered Image"
									src="${orderOfCustomer.deliveryImagePath }"
									width="150" />
								<br> Trạng thái đơn hàng: <b> <select name="bookStatus"
									value="${orderOfCustomer.bookStatus}"
									onclick="document.getElementById('uploadDiv').style.display='none';">
										<option value="${Constant.INTACT}">Nguyên vẹn</option>
										<option value="${Constant.FAILURE}">Hỏng hóc</option>
								</select>
								</b>
								<br> Lý do hủy đơn hàng: <b>
									${orderOfCustomer.rejectReasonDescription}</b>
								<br>
								<button
									onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.DELEVERING_ORDER_STATUS },'${Constant.CONFIRM_REJECT_ACTION }')">Xác
									nhận hoàn đơn hàng</button>
								<c:choose>
									<c:when
										test="${orderOfCustomer.paymentStatusDescription==Constant.PAYMENTED_STATUS}">
										<button
											onclick="document.getElementById('div_reject${orderOfCustomer.orderId}').style.display='block'">Xác
											nhận hủy đơn hàng</button>
										<div id="div_reject${orderOfCustomer.orderId}"
											style="display: none;">
											<br /> Trạng thái hoàn tiền: <br /> <input type="radio"
												name="refundStatus" value="${Constant.REFUND_STATUS}"
												onclick="document.getElementById('uploadDiv').style.display='none';" />
											Hoàn tiền <br /> <input type="radio" name="refundStatus"
												value="${Constant.NO_REFUND_STATUS}"
												onclick="document.getElementById('uploadDiv').style.display='none';" />
											Không hoàn tiền <br />
											<button
												onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.DELEVERING_ORDER_STATUS },'${Constant.CONFIRM_REJECT_ACTION }')">Xác
												nhận</button>
											<button
												onclick="document.getElementById('div_reject${orderOfCustomer.orderId}').style.display='none'">Hủy</button>
										</div>
									</c:when>
									<c:otherwise>
										<button
											onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.REJECT_ORDER_STATUS },'${Constant.CONFIRM_REJECT_ACTION }')">Xác
											nhận hủy đơn hàng</button>
									</c:otherwise>
								</c:choose>
								

							</c:if>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
			<!-- không có hoạt động tìm kiếm -->
			<c:if test="${empty keyword }">
				<div style="margin-top: 5px">
					<!-- link previous chỉ xuất hiện khi trang hiện tại lớn hơn 1 -->
					<c:if test="${currentPage gt 1 }">
						<a href="${dbservletUrl}?page=${currentPage - 1} ">Previous</a> &nbsp;
				</c:if>
					<c:forEach begin="1" end="${noOfPages }" var="i">
						<c:choose>
							<c:when test="${currentPage eq i}">
								<!-- Trùng lặp trang hiện tại thì không tạo link -->
							&nbsp;${i}&nbsp;
						</c:when>
							<c:otherwise>
							&nbsp;<a href="${dbservletUrl}?page=${i}">${i}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- Link Next chỉ xuất hiện khi trang hiện tại nhỏ hơn tổng số trang -->
					<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a href="${dbservletUrl}?page=${currentPage + 1}">Next</a>
					</c:if>
				</div>
			</c:if>
			<!-- có hoạt động tìm kiếm, thêm tham số keyword -->
			<c:if test="${not empty keyword }">
				<div style="margin-top: 5px">
					<c:if test="${currentPage gt 1}">
						<a href="${dbservletUrl}?page=${currentPage - 1}&keyword=${keyword}">Previous</a>&nbsp;
				</c:if>
					<c:forEach begin="1" end="${noOfPages }" var="i">
						<c:choose>
							<c:when test="${currentPage eq i}">
							&nbsp;${i}&nbsp;
						</c:when>
							<c:otherwise>
							&nbsp;<a href="${dbservletUrl}?page=${i}&keyword=${keyword}">${i}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a
							href="${dbservletUrl}?page=${currentPage + 1}&keyword=${keyword}">Next</a>
					</c:if>
				</div>
			</c:if>
	</div>
	</div>

	<jsp:include page="_footer.jsp"></jsp:include>
	<script type="text/javascript">
	function onClickAdminOrderConfirm(orderId,confirmType,action){
		document.getElementById("orderIdOfAction").value=orderId;
		document.getElementById("confirmTypeOfAction").value=confirmType;
		document.getElementById("adminOrderForm").action=action.substring(0);
		document.getElementById("adminOrderForm").submit();
	}
	
	function loadImage(event) {
		let output = document.getElementById('bookImage');
		output.src = URL.createObjectURL(event.target.files[0]);
		output.onload = function() {
			URL.revokeObjectURL(output.src)
		}
	}
	</script>
</body>
</html>