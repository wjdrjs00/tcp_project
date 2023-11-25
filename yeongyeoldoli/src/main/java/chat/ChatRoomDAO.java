package chat;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class ChatRoomDAO {

    public int createOrGetChatRoom(ChatRoomDTO chatRoom) {
        int generatedID = 0;
        String checkIfExistsQuery = "SELECT ChatRoomID FROM ChatRoom WHERE (User1ID = ? AND User2ID = ?) OR (User1ID = ? AND User2ID = ?)";
        String createChatRoomQuery = "INSERT INTO ChatRoom(User1ID, User2ID) VALUES (?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmtCheckIfExists = null;
        PreparedStatement pstmtCreateChatRoom = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            
            // Check if the chat room already exists
            pstmtCheckIfExists = conn.prepareStatement(checkIfExistsQuery);
            pstmtCheckIfExists.setString(1, chatRoom.getUser1ID());
            pstmtCheckIfExists.setString(2, chatRoom.getUser2ID());
            pstmtCheckIfExists.setString(3, chatRoom.getUser2ID());
            pstmtCheckIfExists.setString(4, chatRoom.getUser1ID());
            
            rs = pstmtCheckIfExists.executeQuery();
            
            if (rs.next()) {
                // If the chat room already exists, return its ID
                generatedID = rs.getInt("ChatRoomID");
            } else {
                // If the chat room doesn't exist, create a new one
                pstmtCreateChatRoom = conn.prepareStatement(createChatRoomQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                pstmtCreateChatRoom.setString(1, chatRoom.getUser1ID());
                pstmtCreateChatRoom.setString(2, chatRoom.getUser2ID());
                
                pstmtCreateChatRoom.executeUpdate();
                rs = pstmtCreateChatRoom.getGeneratedKeys();
                
                if (rs.next()) {
                    generatedID = rs.getInt(1); // Get the ID of the newly created chat room
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
        }
        
        return generatedID; // Return the chat room ID
    }

    public ArrayList<ChatRoomDTO> getChatRoomsByUserID(String userID) {
        ArrayList<ChatRoomDTO> chatRooms = new ArrayList<>();
        String SQL = "SELECT * FROM ChatRoom WHERE User1ID = ? OR User2ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, userID);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                ChatRoomDTO chatRoom = new ChatRoomDTO();
                chatRoom.setChatRoomID(rs.getInt("ChatRoomID"));
                chatRoom.setUser1ID(rs.getString("User1ID"));
                chatRoom.setUser2ID(rs.getString("User2ID"));
                // 필요한 다른 정보들도 설정 가능

                chatRooms.add(chatRoom);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // close resources
        }
        return chatRooms;
    }
    
    public ChatRoomDTO getChatRoomByID(String chatRoomID) {
        ChatRoomDTO chatRoom = null;
        String SQL = "SELECT * FROM ChatRoom WHERE ChatRoomID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, chatRoomID);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                chatRoom = new ChatRoomDTO();
                chatRoom.setChatRoomID(rs.getInt("ChatRoomID"));
                chatRoom.setUser1ID(rs.getString("User1ID"));
                chatRoom.setUser2ID(rs.getString("User2ID"));
                // 필요한 다른 정보들도 설정 가능
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(conn, pstmt);
        }
        return chatRoom;
    }
    
    public void checkUserPositionInChatRoom(int chatRoomID, String userID) {
        String query = "SELECT ChatRoomID, "
                     + "CASE "
                     + "    WHEN User1ID = ? THEN 'User1ID' "
                     + "    WHEN User2ID = ? THEN 'User2ID' "
                     + "    ELSE 'Not Found' "
                     + "END AS UserID, User1ID, User2ID "
                     + "FROM ChatRoom "
                     + "WHERE ChatRoomID = ? AND (User1ID = ? OR User2ID = ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userID);
            pstmt.setString(2, userID);
            pstmt.setInt(3, chatRoomID);
            pstmt.setString(4, userID);
            pstmt.setString(5, userID);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                int roomID = rs.getInt("ChatRoomID");
                String userIDPosition = rs.getString("UserID");
                String user1ID = rs.getString("User1ID");
                String user2ID = rs.getString("User2ID");
                
                System.out.println("ChatRoomID: " + roomID + ", User's ID: " + userIDPosition + ", User1ID: " + user1ID + ", User2ID: " + user2ID);
            } else {
                System.out.println("No information found for " + userID + " in ChatRoom " + chatRoomID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            DatabaseUtil.close(conn, pstmt);
        }
    }
}
