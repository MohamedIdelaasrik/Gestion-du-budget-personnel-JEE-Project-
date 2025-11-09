<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier Catégorie | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="form-container">
    <h2>Modifier la Catégorie ✏️</h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <c:set var="category" value="${requestScope.category}"/>

    <form action="<%= request.getContextPath() %>/categories/update" method="POST">

        <input type="hidden" name="id" value="${category.id}">

        <div class="form-group">
            <label for="name">Nom de la Catégorie:</label>
            <input type="text" id="name" name="name" value="${category.name}" required>
        </div>

        <div class="form-group">
            <label for="type">Type:</label>
            <select id="type" name="type" required>
                <option value="EXPENSE" ${category.type == 'EXPENSE' ? 'selected' : ''}>Dépense (Sortie)</option>
                <option value="INCOME" ${category.type == 'INCOME' ? 'selected' : ''}>Revenu (Entrée)</option>
            </select>
        </div>

        <button type="submit" class="submit-button">Mettre à Jour la Catégorie</button>
    </form>

    <a href="<%= request.getContextPath() %>/categories" class="back-link">
        ← Annuler et retourner à la liste
    </a>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>