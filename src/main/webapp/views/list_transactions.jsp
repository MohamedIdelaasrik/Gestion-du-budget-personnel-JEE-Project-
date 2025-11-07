<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="fr_FR" scope="session"/>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Historique des Transactions</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .container { width: 95%; max-width: 1000px; margin: 30px auto; background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        h1 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .income { color: #28a745; font-weight: bold; }
        .expense { color: #dc3545; font-weight: bold; }
        .button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin-right: 10px; }
        .button.secondary { background-color: #6c757d; }
        .session-error { color: #d9534f; background-color: #f2dede; border: 1px solid #ebccd1; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Historique des Transactions (Mois en cours)</h1>

    <c:if test="${not empty sessionScope.errorMessage}">
        <p class="session-error"> ${sessionScope.errorMessage}</p>

        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <p>
        <a href="<%= request.getContextPath() %>/transactions/add" class="button">
            ➕ Ajouter une Transaction
        </a>
        <a href="<%= request.getContextPath() %>/dashboard" class="button secondary">
            ← Tableau de Bord
        </a>
    </p>

    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Catégorie</th>
            <th>Montant</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.transactionList}" var="tx">
            <tr>
                <td>
                    <fmt:formatDate value="${tx.date}" pattern="dd-MM-yyyy HH:mm"/>
                </td>
                <td><c:out value="${tx.description.length() > 50 ? tx.description.substring(0, 50) : tx.description}"/></td>
                <td>
                    <c:out value="${tx.category.name}"/>
                </td>
                <td>
                    <c:set var="amount" value="${tx.amount}"/>
                    <span class="${amount >= 0 ? 'income' : 'expense'}">
                                <fmt:formatNumber value="${amount >= 0 ? amount : amount * -1}"
                                                  minFractionDigits="2"
                                                  maxFractionDigits="2"/>
                                DH
                                <c:if test="${amount < 0}"> (Dépense 🔻)</c:if>
                                <c:if test="${amount >= 0}"> (Revenu 🟢)</c:if>
                            </span>
                </td>
                <td>
                    <span style="color: gray;">Modifier (Non implémenté)</span> |
                    <a href="<%= request.getContextPath() %>/transactions/delete?id=<c:out value="${tx.id}"/>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette transaction?');" style="color: #dc3545;">Supprimer</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.transactionList}">
            <tr>
                <td colspan="5" style="text-align: center; color: gray;">
                    Aucune transaction trouvée pour la période en cours.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>