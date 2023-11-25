package chat;

public class ChatRoomDTO {
    private int chatRoomID;
    private String user1ID;
    private String user2ID;
    
	public int getChatRoomID() {
		return chatRoomID;
	}
	public void setChatRoomID(int chatRoomID) {
		this.chatRoomID = chatRoomID;
	}
	public String getUser1ID() {
		return user1ID;
	}
	public void setUser1ID(String user1id) {
		user1ID = user1id;
	}
	public String getUser2ID() {
		return user2ID;
	}
	public void setUser2ID(String user2id) {
		user2ID = user2id;
	}
	
	public ChatRoomDTO() {}
	
	
	public ChatRoomDTO(int chatRoomID, String user1id, String user2id) {
		super();
		this.chatRoomID = chatRoomID;
		user1ID = user1id;
		user2ID = user2id;
	}
}