package chat;

import java.sql.Connection;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import util.DatabaseUtil;

public class ChatMessageDAO {

	public boolean saveMessage(ChatMessageDTO message) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            String query = "INSERT INTO ChatMessages (ChatRoomID, UserID, OtherUserID, MessageText) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, message.getChatRoomID());
            pstmt.setString(2, message.getUserID());
            pstmt.setString(3, message.getOtherUserID());
            pstmt.setString(4, message.getMessageText());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseUtil.close(conn, pstmt);
        }
    }

    public ArrayList<ChatMessageDTO> getChatHistory(int chatRoomID) {
        ArrayList<ChatMessageDTO> chatHistory = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            String query = "SELECT * FROM ChatMessages WHERE ChatRoomID = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, chatRoomID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int messageID = rs.getInt("MessageID");
                int fetchedChatRoomID = rs.getInt("ChatRoomID");
                String userID = rs.getString("UserID");
                String otherUserID = rs.getString("OtherUserID");
                String messageText = rs.getString("MessageText");
                Timestamp timestamp = rs.getTimestamp("Timestamp");
                ChatMessageDTO message = new ChatMessageDTO(messageID, fetchedChatRoomID, userID, otherUserID, messageText, timestamp);
                chatHistory.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(conn, pstmt);
        }
        return chatHistory;
    }
    
    
}
