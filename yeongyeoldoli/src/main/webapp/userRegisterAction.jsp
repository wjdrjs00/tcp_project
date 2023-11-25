<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
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
	
	String userPassword = null;
	String userEmail = null;
    String userPhoneNumber = null;
    String userName = null;
    String userBirthDate = null;
    String userType = null;
    
	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = (String) request.getParameter("userEmail");
	}
	if(request.getParameter("userPhoneNumber") != null) {
		userPhoneNumber = (String) request.getParameter("userPhoneNumber");
	}
	if(request.getParameter("userName") != null) {
		userName = (String) request.getParameter("userName");
	}
	if(request.getParameter("userBirthDate") != null) {
		userBirthDate = (String) request.getParameter("userBirthDate");
	}
	if(request.getParameter("userType") != null) {
		userType = (String) request.getParameter("userType");
	}
	
	if (userID == null || userPassword == null || userEmail == null 
			|| userPhoneNumber == null || userName == null 
			|| userBirthDate == null || userType == null ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID,userPassword,userEmail,userPhoneNumber,userName,userBirthDate,userType));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		 session.setAttribute("userID", userID);
		    out.println("<script>");
		    out.println("alert('회원가입이 완료되었습니다. 홈페이지로 이동합니다.');");
		    out.println("location.href = 'index.jsp';"); // 홈페이지 URL로 수정해주세요.
		    out.println("</script>");
		return;
	}
%>