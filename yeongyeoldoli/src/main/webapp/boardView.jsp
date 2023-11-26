<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.BbsDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();
    
    int bbsIndex = 1; // 기본값 설정 (예시)
    String bbsIndexParam = request.getParameter("bbsIndex");
    
    if(bbsIndexParam != null && !bbsIndexParam.isEmpty()) {
        bbsIndex = Integer.parseInt(bbsIndexParam);
    }

    // BbsDAO 인스턴스 생성
    BbsDAO bbsDAO = new BbsDAO();
    // 게시글 정보 가져오기
    BbsDTO bbsDTO = bbsDAO.getBbsDTO(bbsIndex);
    
   if (!isLoggedIn) {
   	%>
   	        <script>
   	            // 사용자에게 알림을 표시합니다.
   	            alert("로그인 후 이용 가능합니다.");
   	            // 로그인 페이지로 리디렉션합니다.
   	            window.location.href = "userLogin.jsp";
   	        </script>
   	<%
   	    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/boardView.css">
</head>
<body>
<header>
	<div class="wrap">
		<div class="my_header">
			<div class="my_logo_header">
				<a class="my_logo" href="index.jsp">
     			 <img src="images/YD26.png" width="50" height="50">연결도리
  				</a>
  			</div>
				<ul class="hd_ul">
					<% if (isLoggedIn) { %>
			            <!-- 로그인 후 -->
			            <li><%= session.getAttribute("userName") %>님</li>
			            <li><a href="mypage.jsp">마이페이지</a></li>
			            <li><a href="userLogout.jsp">로그아웃</a></li>
			        <% } else { %>
			            <!-- 로그인 전 -->
			            <li><a href="userLogin.jsp">로그인</a></li>
			            <li><a href="userRegisterAgree.jsp">회원가입</a></li>
			            <li><a href="#">ID/PW찾기</a></li>
			        <% } %>
				</ul>
  		</div>
	</div>
	<nav class="menu_bar">
		<div class="wrap">
			<ul>
				<li><a href="#" >메뉴</a></li>
				<li class="dropdown"><a href="#" class="dropbtn">특산물</a>
       				<div class="dropdown-content">
           				<a href="#">지역별특산물</a>
           				<a href="#">계절별특산물</a>
       				</div>
    			</li>
				<li class="dropdown"><a href="#" class="dropbtn">커뮤니티</a>
       				<div class="dropdown-content">
           				<a href="board.jsp">농장게시판</a>
           				<a href="#">못난이게시판</a>
           				<a href="#">자유게시판</a>
       				</div>
    			</li>
    			<li><a href="#" >연결도리소개</a></li>
			</ul>
		</div>
	</nav>
</header>

<main>
    <div class="farm_intro">
        <div class="image_text_container">
            <div class="image_container">
                <img src="images/apple1.jpg">
            </div>
            <div class="view_text_container">
                <h2><%= bbsDTO.getBbsTitle() %></h2><p>
                <p>작성자: <%= bbsDTO.getUserID() %></p>
  				<p>작성일: <%= bbsDTO.getBbsDate() %></p>
                <p><%= bbsDTO.getBbsContent() %></p>
                <p>
                    더 알고 싶다면 <a href="#">여기</a>를 클릭해주세요!
                </p>
                <button class="contact-button" onclick="redirectToBoard()">게시글목록</button>
                <button class="contact-button" onclick="openChatWindow()">문의하기</button>
					<% if (isLoggedIn && userID.equals(bbsDTO.getUserID())) { %>
					    <form action="bbsDeleteAction.jsp" method="post" id="deleteForm">
					        <input type="hidden" name="bbsIndex" value="<%= bbsDTO.getBbsIndex() %>">
					        <button type="button" class="contact-button" onclick="deletePost()">게시글 삭제</button>
					    </form>
					<% } %>
            </div>
        </div>
    </div>
</main>

<footer>
	<div class="wrap">
	인천광역시 미추홀구 인하로 100 우)20900<p>
	☎ 콜센터 : 1111-1111 (평일 09:00~12:00, 13:00~18:00 / 토,일,공휴일은 휴무)<p>
	Copyright ⓒ 2023 김대현 All Rights Reserved.
	</div>
</footer>

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

<script type="text/javascript">
function updateFooterPosition() {
    var bodyHeight = $("body").height();
    var windowHeight = $(window).height();
    var hasScroll = bodyHeight > windowHeight;

    if (hasScroll) {
        // 스크롤이 있는 경우
        $("body > main").css({
            marginBottom: $("body > footer").outerHeight() + "px"
        });
        $("body > footer").css({
            position: "relative",
            bottom: "auto"
        });
    } else {
        // 스크롤이 없는 경우
        $("body > main").css({
            marginBottom: 0
        });
        $("body > footer").css({
            position: "sticky",
            bottom: 0
        });
    }
}
</script>
<script>
function openChatWindow() {
    // 현재 게시글 작성자의 userID 가져오기
    var postUserID = '<%= bbsDTO.getUserID() %>';
    
    // chatList.jsp로 이동하면서 postUserID를 파라미터로 전달
    window.location.href = 'chatList.jsp?postUserID=' + postUserID;
}

function deletePost() {
    if (confirm("게시글을 삭제하시겠습니까?")) {
        document.getElementById("deleteForm").submit();
    }
}
</script>


<script>
function redirectToBoard() {
    window.location.href = 'board.jsp';
}
</script>


</body>
</html>