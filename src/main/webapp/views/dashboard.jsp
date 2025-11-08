<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="fr_FR"/>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord | Mon Budget</title>
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
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .header h1 { margin: 0; font-size: 1.8em; }
        .header .user-info { font-size: 0.9em; }
        .header .user-info a {
            color: #ffcc00;
            text-decoration: none;
            transition: color 0.3s;
        }
        .header .user-info a:hover {
            color: #fff;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        .nav {
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
        }
        .nav a {
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
        }
        .nav a:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .nav a.primary {
            background-color: #1abc9c;
            color: white;
        }
        .nav a.secondary {
            background-color: #bdc3c7;
            color: #333;
        }

        .kpi-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
        }
        .kpi-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            text-align: center;
            flex-basis: 22%;
            min-width: 200px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0,0,0,0.15);
        }
        .kpi-card h3 {
            margin: 0 0 10px 0;
            color: #7f8c8d;
            font-size: 1em;
            letter-spacing: 0.5px;
        }
        .kpi-card p {
            margin: 0;
            font-size: 1.8em;
            font-weight: 700;
        }

        .kpi-card p.balance { color: #2980b9; }
        .kpi-card p.income { color: #27ae60; }
        .kpi-card p.expense { color: #c0392b; }
        .kpi-card p.week { color: #f39c12; }

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

        .tx-income { color: #27ae60; font-weight: 600; }
        .tx-expense { color: #c0392b; font-weight: 600; }

        tbody tr:hover {
            background-color: #fcfcfc;
        }
    </style>
</head>
<body>

<div style="background:linear-gradient(90deg,#2c3e50,#1abc9c);padding:15px 30px;display:flex;justify-content:space-between;align-items:center;border-bottom-left-radius:12px;border-bottom-right-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,0.15);">
    <h1 style="color:#2ecc71;margin:0;text-shadow:0 1px 2px rgba(0,0,0,0.3);">Mon Budget 💸</h1>
    <div style="color:white;font-size:0.9em;">
        Connecté en tant que:
        <strong style="color:#e8ffe8;"><c:out value="👤${sessionScope.currentUser.username} "/></strong>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="<%= request.getContextPath() %>/login?action=logout" style="color:#ffeb99;text-decoration:none;font-weight:600;">Déconnexion</a>
    </div>
</div>


<div class="container">
    <h2>Tableau de Bord Mensuel </h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p style="color: #c0392b; background: #fbe6e6; padding: 10px; border-radius: 4px; border: 1px solid #c0392b;">
            ⚠️ ${requestScope.errorMessage}
        </p>
    </c:if>

    <div class="nav">
        <a href="<%= request.getContextPath() %>/transactions/add" class="primary">
            ➕ Nouvelle Transaction
        </a>
        <a href="<%= request.getContextPath() %>/categories" class="secondary">
            Gérer les Catégories 🏷️
        </a>
        <a href="<%= request.getContextPath() %>/transactions" class="secondary">
            Historique des Transactions 📜
        </a>
    </div>

    <div class="kpi-container">
        <div class="kpi-card">
            <h3>Solde (Mois)</h3>
            <p class="balance">
                <fmt:formatNumber value="${requestScope.monthlyBalance}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Revenus (Mois)</h3>
            <p class="income">
                <fmt:formatNumber value="${requestScope.totalIncome}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Dépenses (Mois)</h3>
            <p class="expense">
                <fmt:formatNumber value="${requestScope.totalExpense * -1}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Solde (Semaine)</h3>
            <p class="week">
                <fmt:formatNumber value="${requestScope.weeklyBalance}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
    </div>

    <h2>Transactions Récentes ⏱️</h2>
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
                <td><fmt:formatDate value="${tx.date}" pattern="dd-MM-yyyy"/></td>
                <td><c:out value="${tx.category.name}"/></td>
                <td><c:out value="${tx.description.length() > 50 ? tx.description.substring(0, 50).concat('...') : tx.description}"/></td>
                <td class="${tx.amount > 0 ? 'tx-income' : 'tx-expense'}">
                    <fmt:formatNumber value="${tx.amount}" minFractionDigits="2" maxFractionDigits="2"/> DH
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty requestScope.recentTransactions}">
            <tr>
                <td colspan="4" style="text-align: center; color: #7f8c8d; padding: 20px;">
                    Pas d'activité récente. Commencez par enregistrer une transaction !
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
