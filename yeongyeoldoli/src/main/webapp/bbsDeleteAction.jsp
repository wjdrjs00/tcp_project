<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>

<%
    String bbsIndex = request.getParameter("bbsIndex");
    
    if (bbsIndex != null && !bbsIndex.isEmpty()) {
        int index = Integer.parseInt(bbsIndex);
        
        // BbsDAO를 사용하여 해당 게시글 삭제
        BbsDAO bbsDAO = new BbsDAO();
        int rowsAffected = bbsDAO.delete(index);
        
        if (rowsAffected > 0) {
            // 삭제 성공 시 메시지 출력 또는 리다이렉션
            out.println("<script>alert('게시글이 삭제되었습니다.'); window.location.href = 'board.jsp';</script>");
        } else {
            // 삭제 실패 시 메시지 출력 또는 리다이렉션
            out.println("<script>alert('게시글 삭제에 실패했습니다.'); window.history.back();</script>");
        }
    } else {
        // 유효한 bbsIndex가 전달되지 않은 경우 처리
        out.println("<script>alert('유효하지 않은 요청입니다.'); window.history.back();</script>");
    }
%>