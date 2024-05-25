package vnua.fita.bookstore.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vnua.fita.bookstore.bean.Book;
import vnua.fita.bookstore.model.BookDAO;
import vnua.fita.bookstore.util.Constant;


/**
 * Servlet implementation class ClientHomeServlet
 */
@WebServlet(urlPatterns = { "/clientHome"})
public class ClientHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookDAO bookDAO;

	public ClientHomeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init() {
		String jdbcURL = getServletContext().getInitParameter("jdbcURL");
		String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
		String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
//		bookDAO = new BookDAO("jdbc:mysql://localhost:3306/bookstore", "root", "123456");
		bookDAO = new BookDAO(jdbcURL, jdbcUsername, jdbcPassword);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		String errors = null;
//		List<Book> list = null;
//		
//		String keyword = request.getParameter("keyword"); //lấy keyword nếu có
//		if(keyword != null && !keyword.isEmpty()) { //người dùng bấm tìm kiếm
//			list = bookDAO.listAllBooks(keyword);
//		}else {
//			list = bookDAO.listAllBooks();
//		}
//		if (list.isEmpty()) {
//			errors = "Không thể lấy dữ liệu";
//		}
//
//		//Lưu thông tin vào request attribute trước khi forward sang Views
//		request.setAttribute("errors", errors);
//		request.setAttribute("bookList", list);
//		
//		RequestDispatcher rd = this.getServletContext()
//				.getRequestDispatcher("/Views/clientHomeView.jsp");
//		rd.forward(request, response);

		String servletPath = request.getServletPath();
		String[] parts = servletPath.split("/");
        String servletUrl = parts[parts.length - 1];
        
		List<Book> list = null;
		int page = 1;
		int recordsPerPage = Constant.RECORDS_PER_PAGE;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		String keyword = request.getParameter("keyword");

		list = bookDAO.listAllBooks((page - 1) * recordsPerPage, recordsPerPage, keyword);
		int noOfRecords = bookDAO.getNoOfRecords(keyword);
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

		// Lưu thông tin vào request attribute trước khi forward sang views
		request.setAttribute("servletUrl", servletUrl);
		request.setAttribute("bookList", list);
		request.setAttribute("noOfPages", noOfPages);
		request.setAttribute("currentPage", page);
		request.setAttribute("keyword", keyword);

		RequestDispatcher rd;
		
		if(request.getParameter("page") == null) {
		
		  if(keyword != null) {//người dùng bấm tìm kiếm, xử lý theo ajax 
			  rd = this.getServletContext()
		  .getRequestDispatcher("/Views/clientSearchHomeView.jsp"); } else {
		  rd = this.getServletContext()
				.getRequestDispatcher("/Views/clientHomeView.jsp");}} else
				{rd = this.getServletContext()
				.getRequestDispatcher("/Views/clientHomeView.jsp");}
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
