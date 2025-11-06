<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Catégories</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .container { width: 90%; max-width: 800px; margin: 30px auto; background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        h1 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin-right: 10px; }
        .button.success { background-color: #28a745; }
        .button:hover { opacity: 0.9; }
        .type-income { color: #28a745; font-weight: bold; }
        .type-expense { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h1>Vos Catégories de Budget</h1>

    <p>
        <a href="<%= request.getContextPath() %>/categories/add" class="button">
            ➕ Ajouter une nouvelle Catégorie
        </a>
        <a href="<%= request.getContextPath() %>/dashboard" class="button success">
            ← Tableau de Bord
        </a>
    </p>

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
                <td>
                        <%-- Ces liens nécessitent les méthodes doGet/doPost pour /edit et /delete dans CategoryServlet --%>
                    <a href="<%= request.getContextPath() %>/categories/edit?id=<c:out value="${category.id}"/>">Modifier</a> |
                    <a href="<%= request.getContextPath() %>/categories/delete?id=<c:out value="${category.id}"/>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette catégorie?');" style="color: #dc3545;">Supprimer</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.categoriesList}">
            <tr>
                <td colspan="4" style="text-align: center; color: gray;">Aucune catégorie trouvée.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>