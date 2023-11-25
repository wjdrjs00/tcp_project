<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.BbsDTO"%>
<%
    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();
    
    
    // DAO 인스턴스 생성
    BbsDAO bbsDAO = new BbsDAO();

    // 해당 사용자가 작성한 게시글을 가져옵니다.
    ArrayList<BbsDTO> userPosts = bbsDAO.getUserPosts(userID);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/.css">
</head>
<body>

<main>
    <div class="wrap">
        <div class="">
            <div class="">
                <h3><%= session.getAttribute("userName") %>님의 게시글목록</h3>
                <ul class="bbs-list">
                    <% 
                        // 가져온 게시물 목록을 출력합니다.
                        for (BbsDTO post : userPosts) {
                    %>
                    <li><%= post.getBbsTitle() %></li>
                    <!-- 게시물의 제목을 출력하고 싶은 부분에 post.getBbsTitle() 대신 원하는 정보를 넣어주세요. -->
                    <% } %>
                </ul>
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