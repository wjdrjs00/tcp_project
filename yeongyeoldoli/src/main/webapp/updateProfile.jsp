<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%
    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();
    String userPassword = (String) session.getAttribute("userPassword");
    String userEmail = (String) session.getAttribute("userEmail");
    
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
</head>
<body>


<main class="edit-profile-form">
    <h1>회원정보 수정</h1>
    <form method="post" action="updateProfileAction.jsp">
        <!-- 기존 정보 표시 -->
        <label for="userID">아이디 :</label>
        <input type="text" id="userID" name="userID" class="form-input" value="<%= userID %>" readonly><br>

        <label for="userEmail">이메일 :</label>
        <input type="email" id="userEmail" name="userEmail" class="form-input" value="<%= userEmail %>" required><br>

        <!-- 비밀번호 변경 -->
        <label for="currentPassword">현재 비밀번호 :</label>
        <input type="password" id="currentPassword" name="currentPassword" class="form-input" placeholder="현재 비밀번호를 입력하세요" required><br>

        <label for="newPassword">새 비밀번호 :</label>
        <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="새로운 비밀번호를 입력하세요" required><br>

        <label for="confirmNewPassword">새 비밀번호 확인 :</label>
        <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-input" placeholder="새 비밀번호를 다시 입력하세요" required><br>

        <button type="submit" class="btn">정보 수정</button>
        <button type="button" class="btn" onclick="confirmDelete()">회원 탈퇴</button>
    </form>
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

<script>
    function confirmDelete() {
        if (confirm("정말로 회원 탈퇴하시겠습니까?")) {
            window.location.href = "deleteAction.jsp"; // 탈퇴 액션을 수행할 페이지로 이동
        }
    }
</script>
</body>
</html>