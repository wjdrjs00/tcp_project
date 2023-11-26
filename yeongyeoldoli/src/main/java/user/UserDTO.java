package user;

public class UserDTO {
    private String userID;
    private String userPassword;
    private String userEmail;
    private String userPhoneNumber;
    private String userName;
    private String userBirthDate;
    private String userType;
    
    
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}
	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserBirthDate() {
		return userBirthDate;
	}
	public void setUserBirthDate(String userBirthDate) {
		this.userBirthDate = userBirthDate;
	}

	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public UserDTO() {}
	
    public UserDTO(String userID, String userPassword, String userEmail, String userPhoneNumber,
            String userName, String userBirthDate, String userType
            ) {
	 this.userID = userID;
	 this.userPassword = userPassword;
	 this.userEmail = userEmail;
	 this.userPhoneNumber = userPhoneNumber;
	 this.userName = userName;
	 this.userBirthDate = userBirthDate;
	 this.userType = userType;
	}
}
