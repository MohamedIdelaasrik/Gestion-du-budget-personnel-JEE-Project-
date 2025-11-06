<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="fr"/>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; }
        .header .user-info { font-size: 0.9em; }
        .header .user-info a { color: #f9a825; text-decoration: none; }
        .container { width: 90%; max-width: 1200px; margin: 20px auto; }
        .nav { margin-bottom: 20px; }
        .nav a { background-color: #007bff; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px; margin-right: 10px; }
        .nav a.secondary { background-color: #6c757d; }

        .kpi-container { display: flex; justify-content: space-around; flex-wrap: wrap; gap: 20px; margin-bottom: 30px; }
        .kpi-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center; flex-basis: 200px; }
        .kpi-card h3 { margin: 0 0 10px 0; color: #555; }
        .kpi-card p { margin: 0; font-size: 1.5em; font-weight: bold; }
        .kpi-card p.balance { color: #007bff; }
        .kpi-card p.income { color: #28a745; }
        .kpi-card p.expense { color: #dc3545; }
        .kpi-card p.week { color: #17a2b8; }

        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f8f8f8; }
        .tx-income { color: #28a745; font-weight: bold; }
        .tx-expense { color: #dc3545; }
    </style>
</head>
<body>

<div class="header">
    <h1>Mon Budget</h1>
    <div class="user-info">
        Connecté en tant que:
        <strong><c:out value="${sessionScope.currentUser.username}"/></strong> |
        <a href="<%= request.getContextPath() %>/auth?action=logout">Déconnexion</a>
    </div>
</div>

<div class="container">
    <h2>Tableau de Bord Mensuel</h2>

    <div class="nav">
        <a href="<%= request.getContextPath() %>/transactions/add">+ Nouvelle Transaction</a>
        <a href="<%= request.getContextPath() %>/categories" class="secondary">Gérer les Catégories</a>
        <a href="<%= request.getContextPath() %>/transactions" class="secondary">Historique des Transactions</a>
    </div>


    <div class="kpi-container">
        <div class="kpi-card">
            <h3>Solde (Mois)</h3>
            <p class="balance">
                <fmt:formatNumber value="${requestScope.monthlyBalance}" type="currency" currencySymbol="F CFA"/>
            </p>
        </div>
        <div class="kpi-card">
            <h3>Revenus (Mois)</h3>
            <p class="income">
                <fmt:formatNumber value="${requestScope.totalIncome}" type="currency" currencySymbol="F CFA"/>
            </p>
        </div>
        <div class="kpi-card">
            <h3>Dépenses (Mois)</h3>
            <p class="expense">
                <fmt:formatNumber value="${requestScope.totalExpense}" type="currency" currencySymbol="F CFA"/>
            </p>
        </div>
        <div class="kpi-card">
            <h3>Solde (Semaine)</h3>
            <p class="week">
                <fmt:formatNumber value="${requestScope.weeklyBalance}" type="currency" currencySymbol="F CFA"/>
            </p>
        </div>
    </div>

    <h2>Transactions Récentes</h2>
    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Catégorie</th>
            <th>Description</th>
            <th>Montant</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.recentTransactions}" var="tx">
            <tr>
                <td>
                    <fmt:formatDate value="${tx.transactionDate.toLocalDate()}" dateStyle="medium" />
                </td>
                <td><c:out value="${tx.category.name}"/></td>
                <td><c:out value="${tx.description}"/></td>

                <td class="${tx.amount > 0 ? 'tx-income' : 'tx-expense'}">
                    <fmt:formatNumber value="${tx.amount}" type="currency" currencySymbol="F CFA"/>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.recentTransactions}">
            <tr>
                <td colspan="4" style="text-align: center;">Aucune transaction enregistrée récemment.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>