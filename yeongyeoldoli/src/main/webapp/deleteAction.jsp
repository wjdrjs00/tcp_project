<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    // 세션에서 현재 로그인한 사용자의 아이디를 가져옵니다.
    String userID = (String) session.getAttribute("userID");

    // 아이디가 있는지 확인 후 회원 탈퇴 진행
    if (userID != null && !userID.isEmpty()) {
        UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteUser(userID);

        if (isDeleted) {
        	
            // 회원 탈퇴가 성공한 경우 세션 무효화 후 로그인 페이지로 이동
            HttpSession sessionToDelete  = request.getSession();
            session.invalidate();
            
            out.println("<script>");
            out.println("alert('회원 탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.');");
            out.println("parent.window.location.href = 'userLogin.jsp';");
            out.println("</script>");
        } else {
            // 회원 탈퇴 실패 시 알림
            out.println("<script>");
            out.println("alert('회원 탈퇴에 실패했습니다. 다시 시도해주세요.');");
            out.println("window.location.href='mypageView.jsp';");
            out.println("</script>");
        }
    } else {
        // 세션이 없는 경우, 즉 로그인되지 않은 상태에서 접근한 경우
        out.println("<script>");
        out.println("alert('로그인 후 이용해주세요.');");
        out.println("parent.window.location.href = 'userLogin.jsp';");
        out.println("</script>");
    }
%>