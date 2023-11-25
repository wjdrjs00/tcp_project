<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/userLogin.css">
</head>
<body>
 <%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>

<header>
	<div class="wrap">
		<div class="my_header">
			<div class="my_logo_header">
				<a class="my_logo" href="index.jsp">
     			 <img src="images/YD26.png" width="50" height="50">연결도리
  				</a>
  			</div>
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
<section>
	<div class="wrap">
    <div class="login_from">
        <form action="userLoginAction.jsp" method="post">
            <input type="text" name="userID" placeholder="아이디">
            <input type="password" name="userPassword" placeholder="비밀번호">
            <button type="submit" class="login_btn">로그인</button>
        </form>
        <div class="login_links">
            <a href="#">아이디 찾기</a>
            <a href="#">비밀번호 찾기</a>
            <a href="userRegisterAgree.jsp">회원가입</a>
        </div>
    </div>
</div>
</section>
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
});
</script>
</body>
</html>