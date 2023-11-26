<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
        }
        a {
            display: block;
            text-decoration: none;
            color: black;
            background-color: #7EDA93;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        a:hover {
            background-color: #4caf50;
        }
    </style>
</head>
<body>
<a href="myBbsList.jsp" target="view">내 게시글 목록</a><p>
<a href="chatList.jsp" target="view">내 문의 목록</a><p>
<a  target="view">주소등록/및 수정</a><p>
<a href="updateProfile.jsp" target="view">회원정보 수정/탈퇴</a><p>

</body>
</html>