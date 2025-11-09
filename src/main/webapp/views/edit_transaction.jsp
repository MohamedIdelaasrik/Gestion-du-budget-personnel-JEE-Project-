<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier la Transaction | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="form-container">
    <h1>Modifier la Transaction #<c:out value="${requestScope.transaction.id}"/> 🛠️</h1>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <form action="<%= request.getContextPath() %>/transactions/update" method="POST">

        <input type="hidden" name="id" value="${requestScope.transaction.id}">

        <div class="form-group">
            <label for="amount">Montant (Entrez la valeur absolue):</label>
            <input type="number"
                   id="amount"
                   name="amount"
                   step="0.01"
                   required min="0.01"
                   placeholder="Ex: 150.50"
                   value="${requestScope.transaction.amount >= 0 ? requestScope.transaction.amount : requestScope.transaction.amount * -1}">
        </div>

        <div class="form-group">
            <label for="description">Description (Optionnel):</label>
            <input type="text"
                   id="description"
                   name="description"
                   maxlength="255"
                   placeholder="Ex: Courses au supermarché"
                   value="<c:out value="${requestScope.transaction.description}"/>">
        </div>

        <div class="form-group">
            <label for="categoryId">Catégorie:</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">-- Choisir une catégorie --</option>
                <c:forEach items="${requestScope.categories}" var="cat">
                    <option value="${cat.id}"
                            <c:if test="${cat.id == requestScope.transaction.category.id}">selected</c:if>>
                        <c:out value="${cat.name}"/> (<c:out value="${cat.type == 'INCOME' ? 'Revenu' : 'Dépense'}"/>)
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="submit-button">Enregistrer les Modifications</button>
    </form>

    <a href="<%= request.getContextPath() %>/transactions" class="back-link">
        ← Annuler et retourner à la liste des transactions
    </a>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>