package bbs;

public class BbsDTO {
	private int bbsIndex;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailble;
	
	public int getBbsIndex() {
		return bbsIndex;
	}
	public void setBbsIndex(int bbsIndex) {
		this.bbsIndex = bbsIndex;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailble() {
		return bbsAvailble;
	}
	public void setBbsAvailble(int bbsAvailble) {
		this.bbsAvailble = bbsAvailble;
	}
	
	public BbsDTO() {
	
	}
	
	public BbsDTO(int bbsIndex, String bbsTitle, String userID, String bbsDate, String bbsContent, int bbsAvailble) {
		super();
		this.bbsIndex = bbsIndex;
		this.bbsTitle = bbsTitle;
		this.userID = userID;
		this.bbsDate = bbsDate;
		this.bbsContent = bbsContent;
		this.bbsAvailble = bbsAvailble;
	}
	
	
	
}