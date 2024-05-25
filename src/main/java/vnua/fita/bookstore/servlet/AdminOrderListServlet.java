package vnua.fita.bookstore.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vnua.fita.bookstore.bean.Order;
import vnua.fita.bookstore.model.OrderDAO;
import vnua.fita.bookstore.util.Constant;
import vnua.fita.bookstore.util.MyUtil;

@WebServlet(urlPatterns = { "/adminOrderList/waiting", "/adminOrderList/delivering", "/adminOrderList/delivered",
		"/adminOrderList/reject", "/adminOrderList/confirm-reject" })
public class AdminOrderListServlet extends HttpServlet {
	private OrderDAO orderDAO;

	public void init() {
		String jdbcURL = getServletContext().getInitParameter("jdbcURL");
		String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
		String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
		orderDAO = new OrderDAO(jdbcURL, jdbcUsername, jdbcPassword);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int page = 1;
		int recordsPerPage = Constant.RECORDS_PER_PAGE;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}

		String keyword = req.getParameter("keyword");

		String servletPath = req.getServletPath();
		String servletUrl = servletPath.substring(1);
		String[] parts = servletPath.split("/");
        String dbservletUrl = parts[parts.length - 1];
        
		String pathInfo = MyUtil.getPathInfoFromServletPath(servletPath);
		String context = req.getContextPath();
		List<Order> orders = new ArrayList<Order>();

		int noOfPages = 0; // Khai báo biến noOfPages ở đầu phương thức để đảm bảo nó có phạm vi sử dụng
							// đúng

		if (Constant.WAITING_APPROVE_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.WAITING_CONFIRM_ORDER_STATUS, (page - 1) * recordsPerPage,
					recordsPerPage, keyword, context);
			req.setAttribute("listType", "CHỜ XÁC NHẬN");
			int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.WAITING_CONFIRM_ORDER_STATUS);
			noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		} else if (Constant.DELEVERING_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.DELEVERING_ORDER_STATUS, (page - 1) * recordsPerPage,
					recordsPerPage, keyword, context);
			req.setAttribute("listType", "ĐANG CHỜ GIAO");
			int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.DELEVERING_ORDER_STATUS);
			noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		} else if (Constant.DELEVERED_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.DELEVERED_ORDER_STATUS, (page - 1) * recordsPerPage, recordsPerPage,
					keyword, context);
			req.setAttribute("listType", "ĐÃ GIAO");
			int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.DELEVERED_ORDER_STATUS);
			noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		} else if (Constant.REJECT_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.REJECT_ORDER_STATUS, (page - 1) * recordsPerPage, recordsPerPage,
					keyword, context);
			req.setAttribute("listType", "KHÁCH TRẢ LẠI");
			int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.REJECT_ORDER_STATUS);
			noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		} else if (Constant.CONFIRM_REJECT_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.CONFIRM_REJECT_ORDER_STATUS, (page - 1) * recordsPerPage,
					recordsPerPage, keyword, context);
			req.setAttribute("listType", "CHỜ XÁC NHẬN HỦY HÀNG");
			int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.CONFIRM_REJECT_ORDER_STATUS);
			noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		}

		req.setAttribute("noOfPages", noOfPages);
		req.setAttribute("currentPage", page);
		req.setAttribute("keyword", keyword);
		req.setAttribute("servletUrl", servletUrl);
		req.setAttribute("dbservletUrl", dbservletUrl);
		req.setAttribute(Constant.ORDER_LIST_OF_CUSTOMER, orders);

		RequestDispatcher rd;
		if (req.getParameter("page") == null) {
			if (keyword != null) {// người dùng bấm tìm kiếm, xử lý theo ajax
				rd = this.getServletContext().getRequestDispatcher("/Views/adminSearchOrderListView.jsp");
			} else {
				rd = this.getServletContext().getRequestDispatcher("/Views/adminOrderListView.jsp");
			}
		} else {
			rd = this.getServletContext().getRequestDispatcher("/Views/adminOrderListView.jsp");
		}
		rd.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<String> errors = new ArrayList<String>();
		String orderIdStr = req.getParameter("orderId");
		String confirmTypeStr = req.getParameter("confirmType");
		String changePayment = req.getParameter("changePayment");
		int orderId = -1;
		try {
			orderId = Integer.parseInt(orderIdStr);
		} catch (Exception e) {
			// TODO: handle exception
			errors.add(Constant.ORDER_ID_INVALID_VALIDATE_MSG);
		}
		byte confirmType = -1;
		try {
			confirmType = Byte.parseByte(confirmTypeStr);
		} catch (Exception e) {
			// TODO: handle exception
			errors.add(Constant.VALUE_INVALID_VALIDATE_MSG);
		}
		if (errors.isEmpty()) {
			boolean updateResult = false;
			if (Constant.DELEVERING_ORDER_STATUS == confirmType) {
				updateResult = orderDAO.updateOrderNo(orderId, confirmType);
				/*
				 * if(changePayment!=null) {
				 * if(changePayment.equals(Constant.CHANGE_PAYMENT_STATUS))
				 * 
				 * }
				 */
			} else if (Constant.DELEVERED_ORDER_STATUS == confirmType) {
				updateResult = orderDAO.updateOrder(orderId, confirmType);
			} else if (Constant.REJECT_ORDER_STATUS == confirmType) {
				updateResult = orderDAO.updateOrder(orderId, confirmType);
			}
			if (updateResult) {
				req.setAttribute("message", Constant.UPDATE_ORDER_SUCCESS);
			} else {
				errors.add(Constant.UPDATE_ORDER_FAIL);
			}
			if (!errors.isEmpty()) {
				req.setAttribute("errors", String.join(", ", errors));
			}
			doGet(req, resp);
		}
	}
}
