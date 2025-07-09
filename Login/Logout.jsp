<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>

<% 
    session.invalidate();
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    response.sendRedirect("../Login/Login.jsp");
%>
