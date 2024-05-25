var request;
function activeAsLink(link) {
	window.location = link;
}

function searchAndPaginate(page) {
	let keyword = document.getElementById('keyword').value;
	var url = "clientHome?page=" + page + "&keyword=" + keyword;

	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	try {
		request.onreadystatechange = getInfoTable;
		request.open("GET", url, true);
		request.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}

function activeAsAjax(url) {

	/*let keyword = element.toLowerCase; // Chuyển đổi keyword thành chữ thường để so sánh không phân biệt hoa thường
		const pathname=window.location.pathname;
		let urlArray = pathname.split('/');
		urlArray.splice(2, 0, "search");

		var url = urlArray.join('/')+"?keyword=" + keyword; */


	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}
	try {
		request.onreadystatechange = getInfoTable;
		request.open("GET", url, true);
		request.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}
var request;
function getInfoTable() {
	if (request.readyState == 4) {
		let htmlSearchResult = request.responseText;
		document.getElementById('searchListArea').innerHTML = htmlSearchResult;
	}
}

function plusValue(elementId, maxQuantity) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity + 1 <= maxQuantity) {
		document.getElementById(elementId).value = quantity + 1;
	} else {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
	}
}

function minusValue(elementId) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity - 1 >= 1) {
		document.getElementById(elementId).value = quantity - 1;
	}
	else {
		alert('Giá trị không được nhỏ hơn: 1');
	}

}

function validateValue(element, elementId, maxQuantity) {
	if (!Number.isInteger(parseInt(element.value))) {
		alert('Giá trị phải là số nguyên');
		document.getElementById(elementId).value = 1;
	} else if (element.value < 1) {
		alert('Giá trị không được nhỏ hơn 1');
		document.getElementById(elementId).value = 1;
	} else if (element.value > maxQuantity) {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
		document.getElementById(elementId).value = maxQuantity;
	}

}

function checkQuantityAndSubmit(elementId, bookId, maxQuantity) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity <= 0) {
		alert('Giá trị không được nhỏ hơn 1');
		return;
	} else if (quantity > maxQuantity) {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
		return;
	} else if (!Number.isInteger(parseInt(quantity))) {
		alert('Giá trị phải là số nguyên')
	}
	else {
		document.getElementById("detailBookForm").submit();
	}
}

function updateQuantityOfCartItem(newQuantity, bookId) {
	//url nay se goi den servlet hien tai(CartServlet) voi tham so kem theo
	var url = 'addToCart?bookId=' + bookId + '&quantityPurchased=' + newQuantity;
	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP")
	}
	try {
		request.onreadystatechange = getInfo;
		request.open("GET", url, true);
		request.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}

function getInfo() {
	if (request.readyState == 4) {
		var val = request.responseText;
	}
}

//ham dc goi ung voi su kien onchange, khi so luong mua thay doi
function validateValueAndUpdateCart(element, elementId, maxQuantity, bookId, price) {
	var newQuantity = element.value;
	if (newQuantity > maxQuantity) {
		alert('Giá trị không được vượt quá ' + maxQuantity);
		document.getElementById(elementId).value = maxQuantity;
	} else if (newQuantity < 1) {
		alert('Giá trị không được nhỏ hơn 1');
	} else if (!Number.isInteger(parseInt(newQuantity))) {
		alert('Giá trị phải là số nguyên');
		document.getElementById(elementId).value = 1;
	} else if (newQuantity > 0) {
		//ajax gửi request đến server để update cart
		updateQuantityOfCartItem(newQuantity, bookId);

		//update subtotal
		document.getElementById("subtotal" + bookId).innerText = toComma(newQuantity * price);
		let subtotalList = document.querySelectorAll('[id^="subtotal"]');
		let total = 0;
		for (let i = 0; i < subtotalList.length; i++) {
			total += parseInt(subtotalList[i].innerText.replace(/,/g, ""));
		}
		document.getElementById("total").innerText = toComma(total);
	}
}

//định dạng số tiền: phân cách hàng nghìn bởi dấu phẩy
function toComma(n) {
	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function minusValueAndUpdateCart(elementId, bookTitle, bookId) {
	var quantity = parseInt(document.getElementById(elementId).value);
	if (quantity - 1 >= 1) {
		document.getElementById(elementId).value = quantity - 1;
		//hàm validate được gọi ứng với sự kiện onchange
		document.getElementById(elementId).onkeyup();
	} else {
		onClickRemoveBook(bookTitle, bookId);

	}
}

function plusValueAndUpdateCart(elementId, maxQuantity) {
	var quantity = parseInt(document.getElementById(elementId).value);
	if (quantity + 1 <= maxQuantity) {
		document.getElementById(elementId).value = quantity + 1;
		//hàm validate được gọi ứng với sự kiện onchange
		document.getElementById(elementId).onkeyup();
	} else {
		alert('Giá trị không được vượt quá ' + maxQuantity);
	}
}

function onClickRemoveBook(bookTitle, bookId) {
	let c = confirm('Bạn chắc chắn muốn xóa cuốn sách ' + bookTitle + ' khỏi giỏ hàng');
	if (c) {
		document.getElementById("removedBookFromCart").value = bookId;
		document.getElementById("removedBookFromCartForm").submit();
	}
}

function validateFormOrder() {
	var deliveryAddress = document.querySelector('input[name="deliveryAddress"]').value;
	var paymentMode = document.querySelector('input[name="paymentMode"]:checked').value;
	var fileInput = document.querySelector('input[name="file"]');
	if (deliveryAddress === "" && paymentMode === "transfer" && fileInput.files.length === 0) {
		alert("Vui lòng nhập địa chỉ nhận sách và chọn ảnh kết quả chuyển khoản.");
		return false;
	}
	else {
		if (deliveryAddress === "") {
			alert("Vui lòng nhập địa chỉ nhận sách.");
			return false;
		}
		if (paymentMode === "transfer" && fileInput.files.length === 0) {
			alert("Vui lòng chọn ảnh kết quả chuyển khoản.");
			return false;
		}
	}
	return true;
}

function validateLoadImage(){
	var fileInput = document.querySelector('input[name="file"]');
	if (fileInput.files.length === 0) {
			alert("Vui lòng chọn ảnh giao hàng thành công hoặc sản phẩm bị trả lại.");
			return false;
			}
		return true;
}

function loadImage(event) {
	let output = document.getElementById('bookImage');
	output.src = URL.createObjectURL(event.target.files[0]);
	output.onload = function() {
		URL.revokeObjectURL(output.src)
	}
}
function onClickDeleteBook(bookTitle, bookId) {
	let c = confirm('Bạn chắc chắn muốn xóa cuốn sách ' + bookTitle + '?');
	if (c) {
		document.getElementById("deleteBookFromAdmin").value = bookId;
		document.getElementById("deleteBookFromAdminForm").submit();
	}
}
function onClickAdminOrderConfirm(orderId, confirmType, action) {
	document.getElementById("orderIdOfAction").value = orderId;
	document.getElementById("confirmTypeOfAction").value = confirmType;
	document.getElementById("adminOrderForm").action = action.substring(0);
	document.getElementById("adminOrderForm").submit();
}
