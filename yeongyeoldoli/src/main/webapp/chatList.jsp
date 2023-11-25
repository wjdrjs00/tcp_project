<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="chat.ChatRoomDAO"%>
<%@ page import="chat.ChatRoomDTO"%>
<%


    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();
    
    String postUserID = request.getParameter("postUserID");
    
    
    // ChatRoomDAO 인스턴스 생성
    ChatRoomDAO chatRoomDAO = new ChatRoomDAO();
    
    // ChatRoomDTO 객체 생성 및 설정
    ChatRoomDTO chatRoom = new ChatRoomDTO();
    chatRoom.setUser1ID(userID); // 로그인한 사용자
    chatRoom.setUser2ID(postUserID); // 게시글 작성자

    
    // 채팅방 생성
    int generatedChatRoomID = chatRoomDAO.createOrGetChatRoom(chatRoom);

    
    // 현재 로그인한 유저의 채팅방 목록을 가져옴
    ArrayList<ChatRoomDTO> chatRooms = chatRoomDAO.getChatRoomsByUserID(userID);
    
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/chatList.css">
</head>
<body>


<main>
    <div class="wrap">
        <div class="chat_ct">
            <div class="list">
                <h3><%= session.getAttribute("userName") %>님의 문의목록</h3>
                <ul class="chat-room-list">
                    <% for (ChatRoomDTO room : chatRooms) { %>
                        <li class="room-item">
                            <a href="chatRoom.jsp?chatRoomID=<%= room.getChatRoomID() %>&userID=<%= userID %>" class="room-link">
                                <span class="room-name">
                                    <%= (room.getUser1ID().equals(userID)) ? room.getUser2ID() : room.getUser1ID() %>님과의 문의내용
                                </span>
                            </a>
                        </li>
                    <% } %>
                </ul>
                <a href="mypage.jsp">list</a>
            </div>
        </div>
    </div>
</main>



<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function(){
        $(".dropdown").hover(function(){
            $(this).find('.dropdown-content').stop(true, true).delay(200).fadeIn(500);
        }, function(){
            $(this).find('.dropdown-content').stop(true, true).delay(200).fadeOut(500);
        });
    });
</script>
</body>
</html>