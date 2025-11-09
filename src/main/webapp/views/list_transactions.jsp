<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="fr_FR" scope="session"/>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Historique des Transactions | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<div class="container">
    <h2>Historique des Transactions (Mois en cours) 📜</h2>

    <c:if test="${not empty sessionScope.errorMessage}">
        <p class="session-error">
            ⚠️ <c:out value="${sessionScope.errorMessage}"/>
        </p>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <div class="action-bar">
        <a href="<%= request.getContextPath() %>/transactions/add" class="button-link primary">
            ➕ Ajouter une Transaction
        </a>
        <a href="<%= request.getContextPath() %>/dashboard" class="button-link secondary">
            ← Tableau de Bord
        </a>
    </div>

    <table>
        <thead>
        <tr>
            <th style="width: 15%;">Date</th>
            <th>Description</th>
            <th style="width: 15%;">Catégorie</th>
            <th style="width: 15%; text-align: right;">Montant</th>
            <th style="width: 15%;">Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.transactionList}" var="tx">
            <tr>
                <td>
                    <fmt:formatDate value="${tx.date}" pattern="dd-MM-yyyy HH:mm"/>
                </td>
                <td><c:out value="${tx.description.length() > 60 ? tx.description.substring(0, 60).concat('...') : tx.description}"/></td>
                <td>
                    <c:out value="${tx.category.name}"/>
                </td>
                <td style="text-align: right;">
                    <c:set var="amount" value="${tx.amount}"/>
                    <span class="${amount >= 0 ? 'tx-income' : 'tx-expense'}">
                        <fmt:formatNumber value="${amount >= 0 ? amount : amount * -1}"
                                          minFractionDigits="2"
                                          maxFractionDigits="2"/>
                        DH
                    </span>
                </td>
                <td class="action-links">
                    <a href="<%= request.getContextPath() %>/transactions/edit?id=<c:out value="${tx.id}"/>">
                        Modifier
                    </a>
                    <a href="<%= request.getContextPath() %>/transactions/delete?id=<c:out value="${tx.id}"/>"
                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette transaction?');"
                       class="delete-link">
                        Supprimer
                    </a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.transactionList}">
            <tr>
                <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 20px;">
                    Aucune transaction trouvée pour la période en cours. Enregistrez-en une !
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>
