<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>연결도리</title>
</head>
<body>
<%
	session.invalidate();
%>
<script>
	alert("로그아웃되었습니다.");
	location.href = 'index.jsp';
</script>
</body>
</html>