<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Catégories</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Vos Catégories de Budget</h1>

        <p>
            <a href="<%= request.getContextPath() %>/categories/add">
                <button>+ Ajouter une nouvelle Catégorie</button>
            </a>
            <a href="<%= request.getContextPath() %>/dashboard">
                <button style="background-color: #28a745;">← Tableau de Bord</button>
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
                                <c:when test="${category.type == 'INCOME'}">Revenu</c:when>
                                <c:when test="${category.type == 'EXPENSE'}">Dépense</c:when>
                                <c:otherwise>Non Défini</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath() %>/categories/edit?id=<c:out value="${category.id}"/>">Modifier</a> |
                            <a href="<%= request.getContextPath() %>/categories/delete?id=<c:out value="${category.id}"/>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette catégorie?');">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty requestScope.categoriesList}">
                    <tr>
                        <td colspan="4">Aucune catégorie trouvée. Veuillez en ajouter une.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>