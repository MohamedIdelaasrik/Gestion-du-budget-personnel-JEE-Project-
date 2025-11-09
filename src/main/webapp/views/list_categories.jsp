<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gérer les Catégories | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="container">
    <h2>Gérer Vos Catégories de Budget 🏷️</h2>

    <div class="action-bar">
        <a href="<%= request.getContextPath() %>/categories/add" class="button-link primary">
            ➕ Ajouter une Nouvelle Catégorie
        </a>
        <a href="<%= request.getContextPath() %>/dashboard" class="button-link secondary">
            ← Tableau de Bord
        </a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Type</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.categoriesList}" var="category">
            <tr>
                <td><c:out value="${category.id}"/></td>
                <td><c:out value="${category.name}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${category.type == 'INCOME'}"><span class="type-income">Revenu</span></c:when>
                        <c:when test="${category.type == 'EXPENSE'}"><span class="type-expense">Dépense</span></c:when>
                        <c:otherwise>Non Défini</c:otherwise>
                    </c:choose>
                </td>
                <td class="action-links">
                    <a href="<%= request.getContextPath() %>/categories/edit?id=<c:out value="${category.id}"/>">
                        Modifier
                    </a>
                    <a href="<%= request.getContextPath() %>/categories/delete?id=<c:out value="${category.id}"/>"
                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette catégorie? Cette action est irréversible et pourrait affecter vos transactions.');"
                       class="delete-link">
                        Supprimer
                    </a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.categoriesList}">
            <tr>
                <td colspan="4" style="text-align: center; color: #7f8c8d; padding: 20px;">
                    Aucune catégorie trouvée. Veuillez en ajouter une pour organiser votre budget.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>
