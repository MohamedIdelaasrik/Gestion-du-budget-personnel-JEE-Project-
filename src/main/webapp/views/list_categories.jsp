<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gérer les Catégories | Mon Budget</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #eef1f5;
            color: #333;
        }
        h1, h2 {
            color: #1a1a1a;
            font-weight: 600;
        }

        .header {
            background: linear-gradient(90deg, #2c3e50, #1abc9c);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom-left-radius: 12px;
            border-bottom-right-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .header .logo {
            color: #2ecc71;
            margin: 0;
            font-size: 1.8em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }
        .header .user-info {
            color: white;
            font-size: 0.9em;
        }
        .header .user-info strong {
            color: #e8ffe8;
        }
        .header .user-info a {
            color: #ffeb99;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        .header .user-info a:hover {
            color: #fff;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 30px auto;
        }

        .action-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }

        .button-link {
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .button-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-link.primary {
            background-color: #1abc9c;
            color: white;
        }
        .button-link.secondary {
            background-color: #bdc3c7;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }
        th, td {
            border: none;
            border-bottom: 1px solid #ecf0f1;
            padding: 15px 12px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            color: #555;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        tbody tr:last-child td {
            border-bottom: none;
        }
        tbody tr:hover {
            background-color: #fcfcfc;
        }

        .type-income {
            color: #27ae60;
            font-weight: 700;
            background: #e6f6ed;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .type-expense {
            color: #c0392b;
            font-weight: 700;
            background: #fbe6e6;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .action-links a {
            color: #3498db;
            text-decoration: none;
            margin-right: 15px;
            transition: color 0.3s;
            font-weight: 500;
        }
        .action-links a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
        .action-links .delete-link {
            color: #e74c3c;
        }
        .action-links .delete-link:hover {
            color: #c0392b;
        }
    </style>
</head>
<body>

<div class="header">
    <h1 class="logo">Mon Budget 💸</h1>
    <div class="user-info">
        Connecté en tant que:
        <strong style="color:#e8ffe8;"><c:out value="${sessionScope.currentUser.username}"/></strong> |
        <a href="<%= request.getContextPath() %>/auth?action=logout">Déconnexion</a>
    </div>
</div>

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
</body>
</html>
