package chat;

import java.io.IOException; 
import java.util.*;
import javax.websocket.*;
import javax.websocket.server.*;

@ServerEndpoint("/chat/{chatRoomID}/{userID}")
public class ChatServer {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        if (message.equals("getChatHistory")) {
            String chatRoomID = (String) session.getUserProperties().get("chatRoomID");

            // 이전 대화 내용을 데이터베이스에서 가져옴
            List<ChatMessageDTO> chatHistory = getChatHistoryFromDatabase(chatRoomID);

            // 가져온 이전 대화 내용을 클라이언트로 전송
            for (ChatMessageDTO chatMessage : chatHistory) {
                session.getBasicRemote().sendText(chatMessage.getUserID() + " : " + chatMessage.getMessageText());
            }
        } else {
            // 기존의 메시지 처리 로직을 유지합니다.
            System.out.println("onMessage 호출");
            System.out.println(message);
            synchronized (clients) {
                // Iterate over the connected sessions
                // and find the appropriate user to relay the message
                for (Session client : clients) {
                    if (!client.equals(session)) {
                        String chatRoomID = (String) client.getUserProperties().get("chatRoomID");
                        String senderUserID = (String) session.getUserProperties().get("userID");
                        String receiverUserID = (String) client.getUserProperties().get("userID");

                        if (chatRoomID != null && senderUserID != null && receiverUserID != null &&
                                chatRoomID.equals((String) session.getUserProperties().get("chatRoomID"))) {
                            // Check if the message is from one user to the other in the same chat room
                            if (senderUserID.equals((String) client.getUserProperties().get("userID")) ||
                                    receiverUserID.equals((String) client.getUserProperties().get("userID"))) {
                                client.getBasicRemote().sendText(message);
                            }
                        }
                    }
                }
            }

            // 데이터베이스에 메시지 저장
            String senderUserID = (String) session.getUserProperties().get("userID");
            String chatRoomID = (String) session.getUserProperties().get("chatRoomID");

            // 채팅방 정보를 가져옴
            ChatRoomDAO chatRoomDAO = new ChatRoomDAO();
            ChatRoomDTO chatRoom = chatRoomDAO.getChatRoomByID(chatRoomID);

            String receiverUserID;
            if (chatRoom.getUser1ID().equals(senderUserID)) {
                receiverUserID = chatRoom.getUser2ID();
            } else {
                receiverUserID = chatRoom.getUser1ID();
            }

            // 데이터베이스에 메시지 저장
            saveMessageToDatabase(chatRoomID, senderUserID, receiverUserID, message);
        }
    }

    

    @OnOpen
    public void onOpen(Session session, @PathParam("chatRoomID") String chatRoomID, @PathParam("userID") String userID) {
        System.out.println("WebSocket opened: chatRoomID=" + chatRoomID + ", userID=" + userID);

        // 데이터베이스에서 채팅방 정보 가져오기
        ChatRoomDAO chatRoomDAO = new ChatRoomDAO();
        ChatRoomDTO chatRoom = chatRoomDAO.getChatRoomByID(chatRoomID);

        if (chatRoom != null) {
            // 채팅방이 존재하는 경우
            // 해당 채팅방에 현재 사용자가 속해있는지 확인
            boolean userInRoom = chatRoom.getUser1ID().equals(userID) || chatRoom.getUser2ID().equals(userID);

            if (userInRoom) {
                // 현재 사용자가 채팅방에 속해 있는 경우
                // 연결된 세션에 세션 추가
                session.getUserProperties().put("chatRoomID", chatRoomID);
                session.getUserProperties().put("userID", userID);
                clients.add(session);

                // 채팅방 정보를 콘솔에 출력
                System.out.println("Chat Room Info:");
                System.out.println("ChatRoomID: " + chatRoom.getChatRoomID());
                System.out.println("User1ID: " + chatRoom.getUser1ID());
                System.out.println("User2ID: " + chatRoom.getUser2ID());
            } else {
                // 사용자가 채팅방에 속해 있지 않은 경우
                // 에러 처리 또는 연결 거부 등을 수행할 수 있습니다.
                try {
                    session.close(new CloseReason(
                            CloseReason.CloseCodes.CANNOT_ACCEPT, "You are not a part of this chat room"));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // 채팅방이 존재하지 않는 경우
            // 에러 처리 또는 연결 거부 등을 수행할 수 있습니다.
            try {
                session.close(new CloseReason(
                        CloseReason.CloseCodes.CANNOT_ACCEPT, "Chat room does not exist"));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("onClose 호출");
        // Remove session from the connected sessions set
        clients.remove(session);
    }

    @OnError
    public void onError(Session session, Throwable t) {
        t.printStackTrace();
        clients.remove(session);
    }



    private List<ChatMessageDTO> getChatHistoryFromDatabase(String chatRoomID) {
        ChatMessageDAO messageDAO = new ChatMessageDAO();
        return messageDAO.getChatHistory(Integer.parseInt(chatRoomID));
    }

    private void saveMessageToDatabase(String chatRoomID, String userID, String otherUserID, String message) {
        ChatMessageDTO messageDTO = new ChatMessageDTO();
        messageDTO.setChatRoomID(Integer.parseInt(chatRoomID));
        messageDTO.setUserID(userID);
        messageDTO.setOtherUserID(otherUserID);
        messageDTO.setMessageText(message);

        ChatMessageDAO messageDAO = new ChatMessageDAO();
        boolean saved = messageDAO.saveMessage(messageDTO);

        if (saved) {
            // 성공적으로 저장됨
            // 원하는 처리를 추가하세요
        } else {
            // 저장 실패
            // 에러 처리 등을 추가하세요
        }
    }
}
    
    
