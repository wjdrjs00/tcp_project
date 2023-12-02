<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="chat.ChatRoomDAO"%>
<%@ page import="chat.ChatRoomDTO"%>
<%@ page import="chat.ChatMessageDAO" %>
<%@ page import="chat.ChatMessageDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map"%>
<%
    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();

    // ChatRoomID를 얻어올 파라미터 값
    String chatRoomID = request.getParameter("chatRoomID");

    // ChatRoomDAO 인스턴스 생성
    ChatRoomDAO chatRoomDAO = new ChatRoomDAO();

    // chatRoomID로 특정 채팅방 정보 가져오기
    ChatRoomDTO chatRoom = chatRoomDAO.getChatRoomByID(chatRoomID);

    // 다른 사용자의 ID 가져오기
    String otherUserID = "";

    // chatRoom 정보가 null이 아니고, 해당 채팅방이 현재 유저의 것이 아니면 다른 유저의 ID를 가져옴
    if (chatRoom != null) {
        if (userID.equals(chatRoom.getUser1ID())) {
            otherUserID = chatRoom.getUser2ID();
        } else {
            otherUserID = chatRoom.getUser1ID();
        }
    }
    
    // ChatMessageDAO 인스턴스 생성
    ChatMessageDAO chatMessageDAO = new ChatMessageDAO();

    // 이전 채팅 기록 가져오기
    int chatRoomIDInt = Integer.parseInt(chatRoomID);
    ArrayList<ChatMessageDTO> chatHistory = chatMessageDAO.getChatHistory(chatRoomIDInt);
    
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Chat Room</title>
    <link rel="stylesheet" href="css/chatRoom.css">
</head>
<body>

<div class="chat_room">
    <div class="chat_header">
        <button onclick="goBack()" class="previous_page_button">이전</button>
        <div class="suser"><%= otherUserID %>님과의 문의방</div>
        <button onclick="#" class="delete_room_button">삭제</button>
    </div>

	
	<div class="message_display" id="messageDisplay" style="overflow-y: scroll; max-height: 430px;">
 	<% for (ChatMessageDTO message : chatHistory) { %>
        <div class="message-bubble <%= message.getUserID().equals(userID) ? "from-me" : "from-other" %>">
            <%= message.getUserID() %> : <%= message.getMessageText().replace("\n", "<br>") %>
        </div>
    <% } %>
    </div>

    <div class="message_input">
        <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
        <input type="submit" value="전송"  id="mg_button" onclick="sendMessage()" />
    </div>
</div>




<script type="text/javascript">
	var urlParams = new URLSearchParams(window.location.search);
	var chatRoomID = urlParams.get('chatRoomID');
	var userID = urlParams.get('userID');
	
    var chatRoomID = <%= chatRoomID %>; // JSP 변수를 JavaScript 변수로 설정
    var userID = '<%= userID %>'; // 문자열은 따옴표로 감싸줘야 합니다.
    var otherUserID = '<%= otherUserID %>'; // 문자열은 따옴표로 감싸줘야 합니다.
    
    var textarea = document.getElementById("messageDisplay");
var webSocket = new WebSocket('ws://localhost:8080/yeongyeoldoli/chat/' + chatRoomID + '/' + userID);
    
    var inputMessage = document.getElementById('messageInput');
   
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/yeongyeoldoli/chatHistory?chatRoomID=' + chatRoomID, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var chatHistory = JSON.parse(xhr.responseText);
                displayChatHistory(chatHistory);
            } else {
                console.error('Chat history request failed');
            }
        }
    };
    xhr.send();

    function displayChatHistory(chatHistory) {
        chatHistory.forEach(function (message) {
            var messageElement = document.createElement('div');
            messageElement.textContent = message.userID + ' : ' + message.messageText;

            // 이전 메시지에 클래스 추가
            messageElement.classList.add('from_other');

            messageDisplay.appendChild(messageElement);
        });

        // 스크롤을 가장 아래로 내림
        messageDisplay.scrollTop = messageDisplay.scrollHeight;
    }
    webSocket.onmessage = function(event) {
        onMessage(event);
    };
	    
    function onMessage(event) {
        var messageText = event.data.trim();
        if (messageText !== '') {
            var messageElement = document.createElement('div');
            messageElement.textContent = userID + ' : ' + messageText;

            // 받은 메시지에 클래스 추가
            messageElement.classList.add('from_other');

            messageDisplay.appendChild(messageElement);
            messageDisplay.scrollTop = messageDisplay.scrollHeight;
        }
    }
    function onOpen(event) {
    }
    function onError(event) {
      alert(event.data);
    }
    
 	// 보낸 메시지에 클래스를 추가하는 부분
    function sendMessage() {
        var messageText = inputMessage.value.trim();
        if (messageText !== '') {
            var messageElement = document.createElement('div');
            messageElement.textContent = messageText;
            // 보낸 메시지에 클래스 추가
            messageElement.classList.add('from_me');
            
            messageDisplay.appendChild(messageElement);
            messageDisplay.scrollTop = messageDisplay.scrollHeight;

            webSocket.send(messageText);
            inputMessage.value = "";
        }
    }
    
    
    inputMessage.addEventListener("keyup", function(event) {
        // Enter 키를 눌렀을 때만 동작하도록 합니다.
        if (event.key === "Enter") {
            // 메시지를 전송합니다.
            sendMessage();
        }
    });
</script>

<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
