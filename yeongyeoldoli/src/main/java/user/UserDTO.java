package user;

public class UserDTO {
    private String userID;
    private String userPassword;
    private String userEmail;
    private String userPhoneNumber;
    private String userName;
    private String userBirthDate;
    private String userType;
    
	/*
	 * private String postcode; private String roadAddress; private String
	 * jibunAddress; private String detailAddress; private String extraAddress;
	 */
    
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

	/*
	 * public String getPostcode() { return postcode; } public void
	 * setPostcode(String postcode) { this.postcode = postcode; } public String
	 * getRoadAddress() { return roadAddress; } public void setRoadAddress(String
	 * roadAddress) { this.roadAddress = roadAddress; } public String
	 * getJibunAddress() { return jibunAddress; } public void setJibunAddress(String
	 * jibunAddress) { this.jibunAddress = jibunAddress; } public String
	 * getDetailAddress() { return detailAddress; } public void
	 * setDetailAddress(String detailAddress) { this.detailAddress = detailAddress;
	 * } public String getExtraAddress() { return extraAddress; } public void
	 * setExtraAddress(String extraAddress) { this.extraAddress = extraAddress; }
	 */
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public UserDTO() {}
	
    public UserDTO(String userID, String userPassword, String userEmail, String userPhoneNumber,
            String userName, String userBirthDate, String userType
            //String postcode, String roadAddress,
            //String jibunAddress, String detailAddress, String extraAddress, String userType
            ) {
	 this.userID = userID;
	 this.userPassword = userPassword;
	 this.userEmail = userEmail;
	 this.userPhoneNumber = userPhoneNumber;
	 this.userName = userName;
	 this.userBirthDate = userBirthDate;
		/*
		 * this.postcode = postcode; this.roadAddress = roadAddress; this.jibunAddress =
		 * jibunAddress; this.detailAddress = detailAddress; this.extraAddress =
		 * extraAddress;
		 */
	 this.userType = userType;
	}
}
