package vnua.fita.bookstore.util;

public class Constant {
	public static final String BOOK_ID_INVALID_VALIDATE_MSG="Book id xác thực không hợp lệ"; 
	public static final String BOOK_QUANTITY_IN_STOCK_INVALID_VALIDATE_MSG="Số lượng trong kho xác thực không hợp lệ"; 
	public static final String ADD_TO_CART_ACTION="addToCart"; 
	public static final String ADD_ORDER_ERROR_MSG="Lỗi đơn hàng"; 
	public static final String NOT_ENOUGHT_ORDER_ERROR_MSG="Lỗi không đủ hàng"; 
	public static final String CART_OF_CUSTOMER="cartOfCustomer"; 
	public static final String ORDER_OF_CUSTOMER="orderOfCustomer"; 
	public static final String REMOVE_FROM_CART_ACTION="removeFromCart"; 
	public static final String GET_BOOK_FAIL="Lỗi lấy danh sách sách"; 
	public static final String INCORRECT_ACCOUNT_VALIDATE_MSG="Sai thông tin tài khoản"; 
	public static final byte ADMIN_ROLE=1; 
	public static final byte CUSTOMER_ROLE=0; 
	public static final byte SHIPPER_ROLE=2; 
	public static final String USERNAME_EMPTY_VALIDATE_MSG="Nhập username"; 
	public static final String PASSWORD_EMPTY_VALIDATE_MSG="Nhập password"; 
	public static final String LOGINED_USER="loginedUser";
	public static final String USERNAME_STORE_IN_COOKIE_OF_BOOKSTORE="username";
	public static final String TOKEN_STORE_IN_COOKIE_OF_BOOKSTORE="token";
	public static final String SECRET_STRING="SECRET_STRING";
	public static final String INSERT_BOOK_FAIL="Lỗi thêm mới sách";
	public static final String CASH_PAYMENT_MODE="cash";
	public static final String TRANSFER_PAYMENT_MODE="transfer";
	public static final String VNPAY_PAYMENT_MODE="vnpayment";
	public static final byte WAITING_CONFIRM_ORDER_STATUS=1;
	public static final byte DELEVERING_ORDER_STATUS=2;
	public static final byte DELEVERED_ORDER_STATUS=3;
	public static final byte CANCEL_ORDER_STATUS=4;
	public static final byte REJECT_ORDER_STATUS=5;
	public static final byte NOT_AVAIABLE_ORDER_STATUS=6;
	public static final byte CONFIRM_REJECT_ORDER_STATUS=7;
	public static final byte EXCHANGE_ORDER_STATUS =8;
	public static final String WAITING_APPROVE_ACTION="waiting";
	public static final String DELEVERING_ACTION="delivering";
	public static final String DELEVERED_ACTION="delivered";
	public static final String REJECT_ACTION="reject";
	public static final String CONFIRM_REJECT_ACTION="confirm-reject";
	public static final String EXCHANGE_ACTION="exchange";
	public static final String PAYMENTED_STATUS="Đã trả tiền";
	public static final String UNPAYMENTED_STATUS="Chưa trả tiền";
	public static final String REFUND_STATUS="Hoàn tiền";
	public static final String NO_REFUND_STATUS="Hoàn tiền";
	public static final String DELEVERY_ADDRESS_EMPTY_VALIDATE_MSG="Địa chỉ giao hàng không thể bỏ trống";
	public static final String TRANSFER_IMAGE_EMPTY_MSG="Ảnh giao dịch không thể bỏ trống";
	public static final String ORDER_LIST_OF_CUSTOMER="orderListOfCustomer";
	public static final String ORDER_ID_INVALID_VALIDATE_MSG="Lỗi order id";
	public static final String VALUE_INVALID_VALIDATE_MSG="Lỗi order status";
	public static final String UPDATE_ORDER_SUCCESS="Cập nhật đơn hàng thành công";
	public static final String UPDATE_ORDER_FAIL="Cập nhật đơn hàng thất bại";
	public static final String URL = "jdbc:mysql://localhost:3306/shipper_bookstore";
	public static final String USERNAME = "root";
	public static final String PASSWORD = "1234";
	public static final byte DELIVERED_ORDER_STATUS = 0;
	public static final String CHANGE_PAYMENT_STATUS = "changePaymentStatus";
	public static final String NO_CHANGE_PAYMENT_STATUS ="noChangePaymentStatus";
	
	public static final int NO_CUSTOMERS_FOUND = 1; //= "Không tìm thấy khách hàng";
	public static final int CUSTOMERS_REQUEST_EXCHANGE = 2;//= "Khách yêu cầu đổi hàng";
	public static final int CUSTOMERS_REQUEST_RETURN = 3; //Khách yêu cầu trả hàng
	public static final int INTACT = 1;// "Nguyên vẹn";
	public static final int FAILURE = 2;//"Hỏng hóc";
	
	public static final int RECORDS_PER_PAGE = 8;
}
