<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Catégorie | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="form-container">
    <h2>Ajouter une Catégorie 🏷️</h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <form action="<%= request.getContextPath() %>/categories/add" method="POST">
        <div class="form-group">
            <label for="name">Nom de la Catégorie:</label>
            <input type="text" id="name" name="name" required placeholder="Ex: Courses, Salaire, Loyer...">
        </div>

        <div class="form-group">
            <label for="type">Type:</label>
            <select id="type" name="type" required>
                <option value="EXPENSE">Dépense (Sortie)</option>
                <option value="INCOME">Revenu (Entrée)</option>
            </select>
        </div>

        <button type="submit" class="submit-button">Enregistrer la Catégorie</button>
    </form>

    <a href="<%= request.getContextPath() %>/categories" class="back-link">
        ← Annuler et retourner à la liste
    </a>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>
