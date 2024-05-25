package vnua.fita.bookstore.servlet;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import vnua.fita.bookstore.bean.Book;
import vnua.fita.bookstore.bean.Order;
import vnua.fita.bookstore.formbean.OrderRejectForm;
import vnua.fita.bookstore.model.OrderDAO;
import vnua.fita.bookstore.model.BookDAO;
import vnua.fita.bookstore.model.OrderRejectDAO;
import vnua.fita.bookstore.util.Constant;
import vnua.fita.bookstore.util.MyUtil;

@WebServlet(urlPatterns = { "/shipperHome", "/delivering", "/delivered", "/reject" })

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class ShipperHomeServlet extends HttpServlet {

	private OrderDAO orderDAO;
	private BookDAO bookDAO;

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
		String[] parts = servletPath.split("/");
        String servletUrl = parts[parts.length - 1];
        
		String pathInfo = MyUtil.getPathInfoFromServletPath(servletPath);
		String context = req.getContextPath();
		List<Order> orders = new ArrayList<Order>();
		int noOfPages = 0; // Khai báo biến noOfPages ở đầu phương thức để đảm bảo nó có phạm vi sử dụng đúng
		if ("shipperHome".equals(pathInfo) || "delivering".equals(pathInfo)) {
		    orders = orderDAO.getOrderList(Constant.DELEVERING_ORDER_STATUS, (page - 1) * recordsPerPage,
		            recordsPerPage, keyword, context);
		    req.setAttribute("listType", "ĐANG CHỜ GIAO");
		    int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.DELEVERING_ORDER_STATUS);
		    noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage); // Sử dụng biến noOfPages đã khai báo
		} else if ("delivered".equals(pathInfo)) {
		    orders = orderDAO.getOrderList(Constant.DELEVERED_ORDER_STATUS, (page - 1) * recordsPerPage, recordsPerPage,
		            keyword, context);
		    req.setAttribute("listType", "ĐÃ GIAO");
		    int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.DELEVERED_ORDER_STATUS);
		    noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
		} else if ("reject".equals(pathInfo)) {
		    orders = orderDAO.getOrderList(Constant.REJECT_ORDER_STATUS, (page - 1) * recordsPerPage, recordsPerPage,
		            keyword, context);
		    int noOfRecords = orderDAO.getNoOfRecords(keyword, Constant.REJECT_ORDER_STATUS);
		    req.setAttribute("listType", "KHÁCH TRẢ LẠI");
		    noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
		}

		req.setAttribute("servletUrl", servletUrl);
		req.setAttribute("noOfPages", noOfPages);
		req.setAttribute("currentPage", page);
		req.setAttribute("keyword", keyword);
		req.setAttribute(Constant.ORDER_LIST_OF_CUSTOMER, orders);
		RequestDispatcher rd;
		if(req.getParameter("page") == null) {
			
			  if(keyword != null) {//người dùng bấm tìm kiếm, xử lý theo ajax 
				  rd = this.getServletContext()
			  .getRequestDispatcher("/Views/shipperSearchHomeView.jsp"); } else {
			  rd = this.getServletContext()
					.getRequestDispatcher("/Views/shipperHomeView.jsp");}} else
					{rd = this.getServletContext()
					.getRequestDispatcher("/Views/shipperHomeView.jsp");}
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Xử lý Tiếng việt cho request,reponse
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String orderIdStr = req.getParameter("orderId");
		String confirmTypeStr = req.getParameter("confirmType");
		String rejectReasonStr = req.getParameter("rejectReason");
		String bookStatusStr = req.getParameter("bookStatus");
//		String bookIdStr = req.getParameter("bookId");
//		String rejectReason = req.getParameter("rejectReason");
//		String bookStatusStr = req.getParameter("bookStatus");
//		String note = req.getParameter("note");
//		Part filePath = req.getPart("file");
//		String reasonImg = req.getParameter("reasonImg");
		int rejectReason = Integer.parseInt(rejectReasonStr);
		int bookStatus = Integer.parseInt(bookStatusStr);

//		OrderRejectForm orderRejectForm = new OrderRejectForm(orderIdStr, bookIdStr, rejectReason, bookStatusStr, note, reasonImg);
//		List<String> errors = orderRejectForm.validateCreatOrderRejectForm();
//		
		List<String> errors = new ArrayList<String>();
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
			} else if (Constant.DELEVERED_ORDER_STATUS == confirmType) {
				Part filePart = req.getPart("file");
				String fileName = UUID.randomUUID().toString() + "_" + MyUtil.getTimeLabel()
						+ MyUtil.extracFileExtension(filePart);
				String contextPath = getServletContext().getRealPath("/"); // Lấy đường dẫn thực của ứng dụng web
				String savePath = contextPath + "delivery-img-upload"; // Đường dẫn đến thư mục 'img'

				File fileSaveDir = new File(savePath);
				if (!fileSaveDir.exists()) {
					fileSaveDir.mkdir(); // Tạo thư mục 'img' nếu nó không tồn tại
				}

				String filePath = savePath + File.separator + fileName; // Đường dẫn file cuối cùng để lưu trữ ảnh
				filePart.write(filePath); // Lưu file ảnh

				String imagePath = "delivery-img-upload" + File.separator + fileName;
				updateResult = orderDAO.updateOrder(orderId, confirmType, imagePath);
			} else if (Constant.CONFIRM_REJECT_ORDER_STATUS == confirmType) {
				Part filePart = req.getPart("file");
				String fileName = UUID.randomUUID().toString() + "_" + MyUtil.getTimeLabel()
						+ MyUtil.extracFileExtension(filePart);
				String contextPath = getServletContext().getRealPath("/"); // Lấy đường dẫn thực của ứng dụng web
				String savePath = contextPath + "reject-img-upload"; // Đường dẫn đến thư mục 'img'

				File fileSaveDir = new File(savePath);
				if (!fileSaveDir.exists()) {
					fileSaveDir.mkdir(); // Tạo thư mục 'img' nếu nó không tồn tại
				}

				String filePath = savePath + File.separator + fileName; // Đường dẫn file cuối cùng để lưu trữ ảnh
				filePart.write(filePath); // Lưu file ảnh

				String imagePath = "reject-img-upload" + File.separator + fileName;
				updateResult = orderDAO.updateOrder(orderId, confirmType, rejectReason, bookStatus, imagePath);
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