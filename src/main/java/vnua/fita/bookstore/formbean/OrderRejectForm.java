package vnua.fita.bookstore.formbean;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

public class OrderRejectForm {

	private String bookId;
	private String orderId;
	private String rejectReason;
	private String bookStatus;
	private String reasonImg;
	private String note;
	private Part filePath;
	
	public OrderRejectForm(String orderId, String bookId,String rejectReason, String bookStatus, String note, String reasonImg){
	super();
	this.orderId = orderId;
	this.bookId = bookId;
	this.rejectReason = rejectReason;
	this.bookStatus = bookStatus;
	this.note = note;
	this.reasonImg = reasonImg;
	}
	
	public OrderRejectForm(){
		
	}

	
	public String getBookId() {
		return bookId;
	}


	public void setBookId(String bookId) {
		this.bookId = bookId;
	}


	public String getOrderId() {
		return orderId;
	}


	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}


	public String getRejectReason() {
		return rejectReason;
	}


	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}


	public String getBookStatus() {
		return bookStatus;
	}


	public void setBookStatus(String bookStatus) {
		this.bookStatus = bookStatus;
	}


	public String getReasonImg() {
		return reasonImg;
	}


	public void setReasonImg(String reasonImg) {
		this.reasonImg = reasonImg;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}


	public Part getFilePath() {
		return filePath;
	}


	public void setFilePath(Part filePath) {
		this.filePath = filePath;
	}


	public List<String> validateCreatOrderRejectForm() {
			List<String> errors = new ArrayList<String>();
			if(filePath == null) {
				errors.add("Không có file tải lên");
			}
			if(rejectReason == null) {
				errors.add("Lý do trả hàng không được trống");
			}
			
			if(bookStatus == null ) {
				errors.add("Trạng thái sách không được để trống");
				}
			return errors;
		
	}
}

