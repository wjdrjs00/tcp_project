<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    request.setCharacterEncoding("UTF-8");
    // �Ķ���Ϳ��� ����ڰ� �Է��� ������ �޾ƿɴϴ�.
    String userID = request.getParameter("userID");
    String userEmail = request.getParameter("userEmail");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    // ���� ��й�ȣ�� Ȯ���Ͽ� �´��� �˻��մϴ�.
    UserDAO userDAO = new UserDAO();
    int loginResult = userDAO.login(userID, currentPassword);

    if (loginResult == 1) {
        // ���� ��й�ȣ�� ��ġ�ϴ� ���, ���ο� ��й�ȣ�� ������Ʈ�մϴ�.
        if (newPassword.equals(confirmNewPassword)) {
            UserDTO user = new UserDTO();
            user.setUserID(userID);
            user.setUserEmail(userEmail);
            user.setUserPassword(newPassword);

            // �̸��� �ߺ� üũ
            UserDAO userDao = new UserDAO();
            boolean isEmailInUse = userDao.isEmailAlreadyInUse(userEmail);

            if (isEmailInUse) {
                // �̹� ��� ���� �̸����̶�� ���� �Ұ� �˸�
                out.println("<script>");
                out.println("alert('�̹� ��� ���� �̸����Դϴ�. �ٸ� �̸����� �Է����ּ���.');");
                out.println("history.back();");
                out.println("</script>");
            } else {
                // ������Ʈ�� ������ DB�� �����մϴ�.
                int updateResult = userDAO.updateUser(user);

                if (updateResult == 1) {
                    // ȸ�� ���� ������Ʈ�� ������ ���
                    HttpSession sessionToUpdate = request.getSession();
                    sessionToUpdate.setAttribute("userID", userID);
                    sessionToUpdate.setAttribute("userEmail", userEmail);

                    out.println("<script>");
                    out.println("alert('ȸ�� ������ ���������� �����Ǿ����ϴ�.');");
                    out.println("window.location.href='mypageView.jsp';");
                    out.println("</script>");
                } else {
                    // ȸ�� ���� ������Ʈ�� ������ ���
                    out.println("<script>");
                    out.println("alert('ȸ�� ���� ������ �����߽��ϴ�. �ٽ� �õ����ּ���.');");
                    out.println("history.back();");
                    out.println("</script>");
                }
            }
        } else {
            // ���ο� ��й�ȣ�� Ȯ�� ��й�ȣ�� ��ġ���� �ʴ� ���
            out.println("<script>");
            out.println("alert('�� ��й�ȣ�� Ȯ�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } else if (loginResult == 0) {
        // ���� ��й�ȣ�� Ʋ�� ���
        out.println("<script>");
        out.println("alert('���� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // ���̵� �������� �ʴ� ���
        out.println("<script>");
        out.println("alert('�������� �ʴ� ������Դϴ�.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
