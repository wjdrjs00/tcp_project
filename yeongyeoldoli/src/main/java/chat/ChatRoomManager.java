// ChatRoomManager.java
package chat;

import java.util.HashMap; 
import java.util.Map;

public class ChatRoomManager {
    private static int roomIdCounter = 1;
    private static Map<Integer, ChatRoom> chatRooms = new HashMap<>();

    public static ChatRoom createChatRoom() {
        int newRoomId = roomIdCounter++;
        ChatRoom newChatRoom = new ChatRoom(newRoomId);
        chatRooms.put(newRoomId, newChatRoom);
        return newChatRoom;
    }

    public static ChatRoom getChatRoom(int roomId) {
        return chatRooms.get(roomId);
    }

    public static void removeChatRoom(int roomId) {
        chatRooms.remove(roomId);
    }
}
