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
	href="${pageContext.request.contextPath}/css/bookstore_style.css">
<title>Trang chủ phía shipper</title>
</head>
<body>

	<jsp:include page="_header_shipper.jsp"></jsp:include>
	<jsp:include page="_menu_shipper.jsp"></jsp:include>
	<div align="center">
		<h3>DANH SÁCH ĐƠN HÀNG ${listType }</h3>

		<input name="keyword" id="keyword" value="${keyword}"
			placeholder="Tìm mã hóa đơn"
			onkeyup="activeAsAjax('${pageContext.request.contextPath}/${servletUrl}?keyword='+this.value)" />


		<form id="shipperForm" method="POST" action=""
			enctype="multipart/form-data">
			<input type="hidden" name="orderId" id="orderIdOfAction" /> <input
				type="hidden" name="confirmType" id="confirmTypeOfAction" /> <input
				type="file" name="file" id="fileImage" hidden /> <input
				type="hidden" name="rejectReason" id="rejectReason"> <input
				type="hidden" name="bookStatus" id="bookStatus">
		</form>
		<p style="color: red;">${errors }</p>
		<p style="color: blue;">${message }</p>
		<div id="searchListArea">

			<table border="1">
				<tr>
					<th>Mã hóa đơn</th>
					<th>Tên khách</th>
					<th>Số điện thoại</th>
					<th>Địa chỉ nhận sách</th>
					<th>Trạng thái đơn hàng</th>
					<c:if
						test="${servletUrl.equals(Constant.DELEVERING_ACTION)||servletUrl.equals('shipperHome')}">
						<th>Thanh toán</th>
					</c:if>
					<c:if test="${servletUrl.equals(Constant.REJECT_ACTION)}">
						<th>Trạng thái hoàn tiền</th>
					</c:if>
					<c:if
						test="${servletUrl == Constant.DELEVERING_ACTION||servletUrl.equals('shipperHome')}">
						<th>Thao tác</th>
					</c:if>
					<c:if
						test="${servletUrl == Constant.DELEVERED_ACTION || servletUrl == Constant.REJECT_ACTION}">
						<th>Chi tiết</th>
					</c:if>

				</tr>
				<c:forEach items="${orderListOfCustomer}" var="orderOfCustomer">
					<tr>
						<td>${orderOfCustomer.orderNo }</td>
						<td>${orderOfCustomer.customer.fullname }</td>
						<td>${orderOfCustomer.customer.mobile }</td>
						<td>${orderOfCustomer.deliveryAddress }</td>
						<td>${orderOfCustomer.orderStatusDescription }</td>
						<c:if
							test="${servletUrl.equals(Constant.DELEVERING_ACTION)||servletUrl.equals('shipperHome')}">
							<c:choose>
								<c:when
									test="${orderOfCustomer.paymentStatusDescription != Constant.PAYMENTED_STATUS }">
									<td><span><fmt:formatNumber type="number"
												maxFractionDigits="0" value="${orderOfCustomer.totalCost}" /></span>
										<sup>đ</sup></td>
								</c:when>
								<c:otherwise>
									<td><span><fmt:formatNumber value="0" /></span> <sup>đ</sup>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${servletUrl.equals(Constant.REJECT_ACTION)}">
							<td>${orderOfCustomer.refundStatus}</td>
						</c:if>
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
											<td><fmt:formatNumber type="number"
													maxFractionDigits="0"
													value="${cartItem.selectedBook.price }" /><sup>đ</sup></td>
											<td>${cartItem.quantity }</td>
											<td><fmt:formatNumber type="number"
													maxFractionDigits="0"
													value="${cartItem.selectedBook.price*cartItem.quantity }" /><sup>đ</sup></td>
										</tr>
									</c:forEach>
								</table>
								<br> Tổng số tiền: <b> <span><fmt:formatNumber
											type="number" maxFractionDigits="0"
											value="${orderOfCustomer.totalCost }" /></span> <sup>đ</sup><br />
									<c:if test="${orderOfCustomer.orderStatus==Constant.DELEVERING_ORDER_STATUS}"></b>
								Tổng phải trả: <b> <c:choose>
										<c:when
											test="${orderOfCustomer.paymentStatusDescription != Constant.PAYMENTED_STATUS }">
											<span><fmt:formatNumber type="number"
													maxFractionDigits="0" value="${orderOfCustomer.totalCost}" /></span>
											<sup>đ</sup>

										</c:when>
										<c:otherwise>
											<span><fmt:formatNumber value="0" /></span>
											<sup>đ</sup>
										</c:otherwise>
									</c:choose>

								</b> <b> ( ${orderOfCustomer.paymentStatusDescription} )</b>
								</c:if>
								<c:if
									test="${Constant.DELEVERING_ORDER_STATUS==orderOfCustomer.orderStatus}">
									<br />

									<br /> Tải lên ảnh giao hàng thành công hoặc sản phẩm bị trả lại <br />

									<br />
									<img alt="" src="" id="bookImage${orderOfCustomer.orderId}"
										width="150">&nbsp;
									<input type="file" name="file" accept="image/*"
										onchange="loadImage(event,'bookImage${orderOfCustomer.orderId}')" />
									<br />
									<br />
									<button
										onclick="onClickShipperConfirm(${orderOfCustomer.orderId},${Constant.DELEVERED_ORDER_STATUS },'${Constant.DELEVERING_ACTION }')">Xác
										nhận đã giao hàng</button>
									<button
										onclick="document.getElementById('div_reject${orderOfCustomer.orderId}').style.display='block'">Xác
										nhận hủy đơn hàng</button>
									<div id="div_reject${orderOfCustomer.orderId}"
										style="display: none;">
										<br /> Lý do hủy: <br /> <input type="radio"
											name="rejectReason" value="${Constant.NO_CUSTOMERS_FOUND}"
											onclick="document.getElementById('uploadDiv').style.display='none';" />
										Không tìm thấy khách hàng <br /> <input type="radio"
											name="rejectReason"
											value="${Constant.CUSTOMERS_REQUEST_RETURN}"
											onclick="document.getElementById('uploadDiv').style.display='none';" />
										Khách yêu cầu trả hàng <br /> <input type="radio"
											name="rejectReason"
											value="${Constant.CUSTOMERS_REQUEST_EXCHANGE}"
											onclick="document.getElementById('uploadDiv').style.display='none';" />
										Khách yêu cầu đổi hàng <br /> Trạng thái hàng: <br /> <input
											type="radio" name="bookStatus" value="${Constant.INTACT}"
											onclick="document.getElementById('uploadDiv').style.display='none';" />
										Nguyên vẹn <br /> <input type="radio" name="bookStatus"
											value="${Constant.FAILURE}"
											onclick="document.getElementById('uploadDiv').style.display='none';" />
										Hư hỏng <br />
										<button
											onclick="onClickShipperConfirm(${orderOfCustomer.orderId},${Constant.CONFIRM_REJECT_ORDER_STATUS},'${Constant.DELEVERING_ACTION }')">Xác
											nhận</button>
										<button
											onclick="document.getElementById('div_reject${orderOfCustomer.orderId}').style.display='none'">Hủy</button>
									</div>
								</c:if>
								<c:if
									test="${Constant.DELEVERED_ORDER_STATUS==orderOfCustomer.orderStatus}">
									<br > Ảnh xác nhận đã giao hàng <br >
									<img alt="Delivered Image"
										src="${orderOfCustomer.deliveryImagePath}" width="150" />
									<br /><br>
								</c:if>
								<c:if
									test="${Constant.REJECT_ORDER_STATUS==orderOfCustomer.orderStatus}">
									<br> Trạng thái xác nhận: <b>${orderOfCustomer.bookStatusDescription}</b>
									<br> Ảnh xác nhận trạng thái hàng bị trả về <br>
									<img alt="Delivered Image"
										src="${orderOfCustomer.deliveryImagePath}" width="150" />
									<br><br>
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
						<a href="${servletUrl}?page=${currentPage - 1} ">Previous</a> &nbsp;
				</c:if>
					<c:forEach begin="1" end="${noOfPages }" var="i">
						<c:choose>
							<c:when test="${currentPage eq i}">
								<!-- Trùng lặp trang hiện tại thì không tạo link -->
							&nbsp;${i}&nbsp;
						</c:when>
							<c:otherwise>
							&nbsp;<a href="${servletUrl}?page=${i}">${i}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- Link Next chỉ xuất hiện khi trang hiện tại nhỏ hơn tổng số trang -->
					<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a href="${servletUrl}?page=${currentPage + 1}">Next</a>
					</c:if>
				</div>
			</c:if>
			<!-- có hoạt động tìm kiếm, thêm tham số keyword -->
			<c:if test="${not empty keyword }">
				<div style="margin-top: 5px">
					<c:if test="${currentPage gt 1}">
						<a href="${servletUrl}?page=${currentPage - 1}&keyword=${keyword}">Previous</a>&nbsp;
				</c:if>
					<c:forEach begin="1" end="${noOfPages }" var="i">
						<c:choose>
							<c:when test="${currentPage eq i}">
							&nbsp;${i}&nbsp;
						</c:when>
							<c:otherwise>
							&nbsp;<a href="${servletUrl}?page=${i}&keyword=${keyword}">${i}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${currentPage lt noOfPages }">
					&nbsp;<a
							href="${servletUrl}?page=${currentPage + 1}&keyword=${keyword}">Next</a>
					</c:if>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
	<script type="text/javascript">
	function onClickShipperConfirm(orderId,confirmType,action){
		var form = document.getElementById("shipperForm");
		
		document.getElementById("orderIdOfAction").value=orderId;
		document.getElementById("confirmTypeOfAction").value=confirmType;
		//document.getElementById("shipperForm").action=action.substring(0);
	
		// Lấy ra input chứa file
	    var fileInput = document.getElementById("fileImage");
	    
	    // Kiểm tra xem có file đã được chọn chưa
	    if (fileInput.files.length > 0) {
	        // Gán file đã chọn vào form
	        form.append("file", fileInput.files[0]);
	    }
	    else {alert("Vui lòng chọn ảnh giao hàng thành công hoặc sản phẩm bị trả lại.");return;}
	    // Gán giá trị action cho form
	    form.action = action;
	    
	 // Lấy radio button đã được chọn từ nhóm "rejectReason"
	    var rejectReasonRadio = document.querySelector('input[name="rejectReason"]:checked');

	    // Nếu không có radio button nào được chọn, gán giá trị là 0
	    var rejectReasonValue = rejectReasonRadio ? rejectReasonRadio.value : 0;

	    // Gán giá trị vào trường ẩn trong form
	    document.getElementById("rejectReason").value = rejectReasonValue;

	    // Lấy radio button đã được chọn từ nhóm "bookStatus"
	    var bookStatusRadio = document.querySelector('input[name="bookStatus"]:checked');

	    // Nếu không có radio button nào được chọn, gán giá trị là 0
	    var bookStatusValue = bookStatusRadio ? bookStatusRadio.value : 0;

	    // Gán giá trị vào trường ẩn trong form
	    document.getElementById("bookStatus").value = bookStatusValue;
	    
	    // Gửi form đi
	    form.submit();
	}
	function loadImage(event,id) {
		let output = document.getElementById(id);
		output.src = URL.createObjectURL(event.target.files[0]);
		output.onload = function() {
			URL.revokeObjectURL(output.src)
		}
	    document.getElementById("fileImage").files = event.target.files;
	}
	</script>
</body>
</html>