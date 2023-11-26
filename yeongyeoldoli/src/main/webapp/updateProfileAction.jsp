<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    request.setCharacterEncoding("UTF-8");
    // 파라미터에서 사용자가 입력한 정보를 받아옵니다.
    String userID = request.getParameter("userID");
    String userEmail = request.getParameter("userEmail");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    // 현재 비밀번호를 확인하여 맞는지 검사합니다.
    UserDAO userDAO = new UserDAO();
    int loginResult = userDAO.login(userID, currentPassword);

    if (loginResult == 1) {
        // 현재 비밀번호가 일치하는 경우, 새로운 비밀번호를 업데이트합니다.
        if (newPassword.equals(confirmNewPassword)) {
            UserDTO user = new UserDTO();
            user.setUserID(userID);
            user.setUserEmail(userEmail);
            user.setUserPassword(newPassword);

            // 이메일 중복 체크
            UserDAO userDao = new UserDAO();
            boolean isEmailInUse = userDao.isEmailAlreadyInUse(userEmail);

            if (isEmailInUse) {
                // 이미 사용 중인 이메일이라면 수정 불가 알림
                out.println("<script>");
                out.println("alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력해주세요.');");
                out.println("history.back();");
                out.println("</script>");
            } else {
                // 업데이트된 정보를 DB에 저장합니다.
                int updateResult = userDAO.updateUser(user);

                if (updateResult == 1) {
                    // 회원 정보 업데이트가 성공한 경우
                    HttpSession sessionToUpdate = request.getSession();
                    sessionToUpdate.setAttribute("userID", userID);
                    sessionToUpdate.setAttribute("userEmail", userEmail);

                    out.println("<script>");
                    out.println("alert('회원 정보가 성공적으로 수정되었습니다.');");
                    out.println("window.location.href='mypageView.jsp';");
                    out.println("</script>");
                } else {
                    // 회원 정보 업데이트에 실패한 경우
                    out.println("<script>");
                    out.println("alert('회원 정보 수정에 실패했습니다. 다시 시도해주세요.');");
                    out.println("history.back();");
                    out.println("</script>");
                }
            }
        } else {
            // 새로운 비밀번호와 확인 비밀번호가 일치하지 않는 경우
            out.println("<script>");
            out.println("alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } else if (loginResult == 0) {
        // 현재 비밀번호가 틀린 경우
        out.println("<script>");
        out.println("alert('현재 비밀번호가 일치하지 않습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // 아이디가 존재하지 않는 경우
        out.println("<script>");
        out.println("alert('존재하지 않는 사용자입니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
