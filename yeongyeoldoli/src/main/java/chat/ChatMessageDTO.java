package chat;

import java.sql.Timestamp;

public class ChatMessageDTO {
    private int messageID;
    private int chatRoomID;
    private String userID;
    private String otherUserID;
    private String messageText;
    private Timestamp timestamp;
    
    
    public int getMessageID() {
		return messageID;
	}

	public void setMessageID(int messageID) {
		this.messageID = messageID;
	}

	public int getChatRoomID() {
		return chatRoomID;
	}

	public void setChatRoomID(int chatRoomID) {
		this.chatRoomID = chatRoomID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getOtherUserID() {
		return otherUserID;
	}

	public void setOtherUserID(String otherUserID) {
		this.otherUserID = otherUserID;
	}

	public String getMessageText() {
		return messageText;
	}

	public void setMessageText(String messageText) {
		this.messageText = messageText;
	}

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public ChatMessageDTO() {
        // 기본 생성자
    }

    public ChatMessageDTO(int messageID, int chatRoomID, String userID, String otherUserID, String messageText, Timestamp timestamp) {
        this.messageID = messageID;
        this.chatRoomID = chatRoomID;
        this.userID = userID;
        this.otherUserID = otherUserID;
        this.messageText = messageText;
        this.timestamp = timestamp;
    }

}