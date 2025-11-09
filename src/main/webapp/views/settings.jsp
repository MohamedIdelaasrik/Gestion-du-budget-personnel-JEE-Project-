<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Paramètres de Compte | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="container" style="max-width: 600px;">
    <div class="call-to-action">
        <a href="<%= request.getContextPath() %>/dashboard" class="button-link primary" style="padding: 15px 30px; font-size: 1.1em;">
            Revenir au Tableau de Bord
        </a>
    </div>
    <h2>Paramètres du Compte ⚙️</h2>

    <p>Utilisateur actuel : <strong><c:out value="${sessionScope.currentUser.username}"/></strong></p>

    <c:if test="${not empty requestScope.successMessage}">
        <div class="message-box success">${requestScope.successMessage}</div>
    </c:if>
    <c:if test="${not empty requestScope.errorMessage}">
        <div class="message-box error">${requestScope.errorMessage}</div>
    </c:if>

    <div class="form-container">

        <h3>Modifier les Informations</h3>

        <form action="<%= request.getContextPath() %>/settings" method="POST">

            <div class="form-group">
                <label for="username">Nouveau Nom d'Utilisateur</label>
                <input type="text" id="username" name="username"
                       value="<c:out value="${sessionScope.currentUser.username}"/>"
                       required>
            </div>

            <div class="form-group">
                <label for="currentPassword">Mot de Passe Actuel (Obligatoire)</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">Nouveau Mot de Passe (Laisser vide si inchangé)</label>
                <input type="password" id="newPassword" name="newPassword">
            </div>

            <button type="submit" class="submit-button">Mettre à Jour le Compte</button>
        </form>
    </div>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>