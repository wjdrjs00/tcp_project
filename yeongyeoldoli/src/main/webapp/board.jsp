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
    String userType = (String) session.getAttribute("userType");
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
<link rel="stylesheet" href="css/board.css">
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
	<div class="wrap">
		<div class="cm_main">
			<div class="cm_header">
				<h2>농장 게시판</h2>
			</div>
			<div class="board_search">
				<form method="get" action="board.jsp">
			        <select name="searchType">
			          <option value="최신순">최신순</option>
			          <option value="추천순">추천순</option>
			        </select>
			        <input type="text" name="search" placeholder="내용을 입력하세요.">
			        <button type="submit" >검색</button>
		     	</form>
				
				    <div class="bd_create">
				        <button id="writeButton">글쓰기</button>
				    </div>
			</div>
			
			<div class="cm_body">
				<table class="free_table" >
					<thead class="cd_theader">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody class="cd_tbody">
						<% 
			                // BbsDAO 객체 생성
			                BbsDAO bbsDAO = new BbsDAO();
			                
			                // 게시물 목록을 가져옴 
			                ArrayList<BbsDTO> posts = bbsDAO.getList(1);
			                
			                // 가져온 게시물 목록을 반복하여 테이블에 추가
			                for (BbsDTO post : posts) {
			            %>
			            <tr class="postRow" data-bbsIndex="<%= post.getBbsIndex() %>">
			                <td><%= post.getBbsIndex() %></td>
			                <td><%= post.getBbsTitle() %></td>
			                <td><%= post.getUserID() %></td>
			                <td><%= post.getBbsDate() %></td>
			            </tr>
			            <% } // for 루프 종료 %>
					</tbody>
				</table>
			</div>
			<div class="next_btn">
				<ul>
				<li><a>이전</a></li>
				<li><a>다음</a></li>
				</ul>
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

// 페이지 로딩시와 창 크기 변경시에도 호출되도록 이벤트 핸들러 등록
$(window).on("load resize", updateFooterPosition);

</script>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const postRows = document.querySelectorAll('.postRow');
    postRows.forEach(row => {
        row.addEventListener('click', function() {
            const bbsIndex = this.getAttribute('data-bbsIndex');
            const detailURL = "boardView.jsp?bbsIndex="+bbsIndex;
            window.location.href = detailURL
        });
    });
});
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const writeButton = document.getElementById('writeButton');
        <% if (isLoggedIn && userType != null && userType.equals("seller")) { %>
            // 글쓰기 버튼 클릭 시 글쓰기 페이지로 이동
            writeButton.addEventListener('click', function() {
                window.location.href = 'createBoardView.jsp';
            });
        <% } else { %>
            // seller 유저가 아닐 경우 알림 표시
            writeButton.addEventListener('click', function() {
                alert('농장유저만 글쓰기가 가능합니다.');
            });
        <% } %>
    });
    
    
    document.addEventListener('DOMContentLoaded', function() {
        const userType = '<%= session.getAttribute("userType") %>';
        console.log('User Type:', userType);
    });
</script>
</body>
</html>