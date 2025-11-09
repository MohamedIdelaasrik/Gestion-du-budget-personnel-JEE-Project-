<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<%
    String contextPath = request.getContextPath();
%>
<div class="header gradient">
    <h1 class="logo">Gestion Budget 💸</h1>
    <div class="user-info">
        Connecté en tant que: &nbsp;
        <a href="<%= contextPath %>/settings" class="user-profile-link">👤
            <strong><c:out value="${sessionScope.currentUser.username}"/></strong></a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="<%= contextPath %>/login?action=logout">Déconnexion ↩️</a></strong>
    </div>
</div>
