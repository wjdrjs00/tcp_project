<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션 확인하여 로그인 상태 파악
    String userID = (String) session.getAttribute("userID");
    boolean isLoggedIn = userID != null && !userID.isEmpty();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/createBoardView.css">
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
		<h2>게시글 작성</h2>
		<form action="createAction.jsp" method="post">
			<div class="btn_post">
				<input type="submit" value="등록하기">
			</div>
			<div class="cbv_head">
				<!-- 제목 입력 -->
				<div id="in_title">
					<input type="text" class="utitle" id="utitle" name="bbsTitle" maxlength="50" placeholder="제목" required>
	    			<div id="charCount">0/50</div>
				</div>
				
				<div class="cbv_main">
					<!-- 내용입력 -->
					<div id="in_content">
		   				<textarea name="bbsContent" id="ucontent" rows="5" placeholder="내용을 입력하세요." maxlength="300" required></textarea>
		    			<div id="contentCharCount">0/300</div>
					</div>
				</div>
			</div>
		</form>
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
});
</script>

<script>
const titleInput = document.getElementById('utitle');
const charCount = document.getElementById('charCount');

titleInput.addEventListener('input', function() {
    const currentLength = titleInput.value.length;
    charCount.textContent = currentLength + '/50';
    
    if (currentLength > 50) {
        // 여기에 필요한 처리를 추가하세요 (예: 입력 금지, 경고 메시지 표시 등)
        // titleInput.value = titleInput.value.substring(0, 50); // 50자를 초과한 입력 방지
    }
});

const contentInput = document.getElementById('ucontent');
const contentCharCount = document.getElementById('contentCharCount');

contentInput.addEventListener('input', function() {
    const currentLength = contentInput.value.length;
    contentCharCount.textContent = currentLength + '/300';
    
    if (currentLength > 300) {
        // 여기에 필요한 처리를 추가하세요 (예: 입력 금지, 경고 메시지 표시 등)
        // contentInput.value = contentInput.value.substring(0, 300); // 300자를 초과한 입력 방지
    }
});
</script>S
</body>
</html>