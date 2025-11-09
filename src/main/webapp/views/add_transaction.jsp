<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Transaction | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="form-container">
    <h2>Enregistrer une Transaction ➕</h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <form action="<%= request.getContextPath() %>/transactions/add" method="POST">

        <div class="form-group">
            <label for="amount">Montant (Nombre positif):</label>
            <input type="number" id="amount" name="amount" step="0.01" required min="0.01" placeholder="Ex: 150.50">
        </div>

        <div class="form-group">
            <label for="description">Description (Optionnel):</label>
            <input type="text" id="description" name="description" maxlength="255" placeholder="Ex: Courses au supermarché">
        </div>

        <div class="form-group">
            <label for="categoryId">Catégorie (Détermine si c'est un Revenu ou une Dépense):</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">-- Choisir une catégorie --</option>
                <c:forEach items="${requestScope.categories}" var="cat">
                    <option value="${cat.id}">
                        <c:out value="${cat.name}"/> (<c:out value="${cat.type == 'INCOME' ? 'Revenu' : 'Dépense'}"/>)
                    </option>
                </c:forEach>
                <c:if test="${empty requestScope.categories}">
                    <option value="" disabled>Aucune catégorie disponible. Ajoutez-en d'abord.</option>
                </c:if>
            </select>
        </div>

        <button type="submit" class="submit-button">Enregistrer</button>
    </form>

    <a href="<%= request.getContextPath() %>/dashboard" class="back-link">
        ← Annuler et retourner au Tableau de Bord
    </a>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>
