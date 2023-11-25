<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원가입</title>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/UserRegister.css">
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
					<li><a href="userLogin.jsp" >로그인</a></li>
					<li><a href="userRegisterAgree.jsp">회원가입</a></li>
					<li><a href="#">ID/PW찾기</a></li>
				</ul>
  		</div>
	</div>
	<nav class="menu_bar">
		<div class="wrap">
			<ul>
				<li><a href="#" >메뉴</a></li>
				<li><a href="LocalSpecialties.jsp" >지역별특산물</a></li>
				<li><a href="SeasonalSpecialties.jsp" >계절별특산물</a></li>
				<li class="dropdown"><a href="#" class="dropbtn">커뮤니티</a>
       				<div class="dropdown-content">
           				<a href="board.jsp">자유게시판</a>
           				<a href="community.jsp">농장게시판</a>
       				</div>
    			</li>
			</ul>
		</div>
	</nav>
</header>


<main class="register-form">
  <h1>회원가입</h1>
  <form method="post" action="userRegisterAction.jsp">
    <input type="text" name="userID" class="form-input" placeholder="아이디" autofocus="autofocus" required>
    <input type="password" name="userPassword" class="form-input" placeholder="비밀번호" required>
    <input type="email" name="userEmail" class="form-input" placeholder="이메일" required><p>
    <input type="text" name="userPhoneNumber" class="form-input" placeholder="휴대전화번호">
    <input type="text" name="userName" class="form-input" placeholder="이름">
    <input type="text" name="userBirthDate" class="form-input" placeholder="생년월일"><p>
    
<!--     <input type="text" id="postcode" placeholder="우편번호" required>
    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
    <input type="text" id="roadAddress" placeholder="도로명주소" required>
    <input type="text" id="jibunAddress" placeholder="지번주소" required>
    <span id="guide" style="color:#999;display:none"></span>
    <input type="text" id="detailAddress" placeholder="상세주소" required>
    <input type="text" id="extraAddress" placeholder="참고항목"><p> -->
      
    <label>
      <input type="radio" name="userType" value="regularUser" required> 일반회원
      <input type="radio" name="userType" value="seller" required> 판매자회원
    </label>
    <button type="submit" class="btn">회원가입</button>
  </form>
</main>


<footer>
    <div class="wrap_ft">
        <p class="address">인천광역시 미추홀구 인하로 100 우)20900</p>
        <p class="contact">
            ☎ 콜센터 : 1111-1111 (평일 09:00~12:00, 13:00~18:00 / 토,일,공휴일은 휴무)</p>
        <p class="copyright">Copyright ⓒ 2023 김대현 All Rights Reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</body>
</html>