<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    // ���ǿ��� ���� �α����� ������� ���̵� �����ɴϴ�.
    String userID = (String) session.getAttribute("userID");

    // ���̵� �ִ��� Ȯ�� �� ȸ�� Ż�� ����
    if (userID != null && !userID.isEmpty()) {
        UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteUser(userID);

        if (isDeleted) {
        	
            // ȸ�� Ż�� ������ ��� ���� ��ȿȭ �� �α��� �������� �̵�
            HttpSession sessionToDelete  = request.getSession();
            session.invalidate();
            
            out.println("<script>");
            out.println("alert('ȸ�� Ż�� �Ϸ�Ǿ����ϴ�. �̿����ּż� �����մϴ�.');");
            out.println("parent.window.location.href = 'userLogin.jsp';");
            out.println("</script>");
        } else {
            // ȸ�� Ż�� ���� �� �˸�
            out.println("<script>");
            out.println("alert('ȸ�� Ż�� �����߽��ϴ�. �ٽ� �õ����ּ���.');");
            out.println("window.location.href='mypageView.jsp';");
            out.println("</script>");
        }
    } else {
        // ������ ���� ���, �� �α��ε��� ���� ���¿��� ������ ���
        out.println("<script>");
        out.println("alert('�α��� �� �̿����ּ���.');");
        out.println("parent.window.location.href = 'userLogin.jsp';");
        out.println("</script>");
    }
%>