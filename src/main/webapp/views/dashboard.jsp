<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.stream.IntStream" %>

<fmt:setLocale value="fr_FR"/>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord | Mon Budget</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />
<%
    LocalDate today = LocalDate.now();
    int currentDayOfMonth = today.getDayOfMonth();
    LocalDate startOfMonth = today.withDayOfMonth(1);
    int daysInMonth = today.lengthOfMonth();
    DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("d");
    String monthLabels = IntStream.rangeClosed(1, daysInMonth)
            .mapToObj(i -> startOfMonth.withDayOfMonth(i).format(dayFormatter))
            .collect(Collectors.joining("', '", "['", "']"));
%>

<div class="container">
    <h2>Tableau de Bord</h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p style="color: #c0392b; background: #fbe6e6; padding: 10px; border-radius: 4px; border: 1px solid #c0392b;">
            ⚠️ ${requestScope.errorMessage}
        </p>
    </c:if>

    <div class="nav">
        <a href="<%= request.getContextPath() %>/transactions/add" class="primary">➕ Nouvelle Transaction</a>
        <a href="<%= request.getContextPath() %>/categories" class="secondary">Gérer les Catégories 🏷️</a>
        <a href="<%= request.getContextPath() %>/transactions" class="secondary">Historique des Transactions 📜</a>
    </div>

    <div class="kpi-container">
        <div class="kpi-card">
            <h3>Votre Solde Actuel</h3>
            <p class="balance">
                <fmt:formatNumber value="${requestScope.overallBalance}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Revenus Globaux</h3>
            <p class="income">
                <fmt:formatNumber value="${requestScope.globalIncome}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Dépenses Globales</h3>
            <p class="expense">
                <fmt:formatNumber value="${requestScope.globalExpenses * -1}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>

        <div class="kpi-card">
            <h3>Revenus de <c:out value="<%= today.format(DateTimeFormatter.ofPattern(\"MMMM\")) %>"/></h3>
            <p class="income">
                <fmt:formatNumber value="${requestScope.totalMonthlyIncome}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Dépenses de <c:out value="<%= today.format(DateTimeFormatter.ofPattern(\"MMMM\")) %>"/></h3>
            <p class="expense">
                <fmt:formatNumber value="${requestScope.totalMonthlyExpense * -1}" minFractionDigits="2" maxFractionDigits="2"/> DH
            </p>
        </div>
        <div class="kpi-card">
            <h3>Dépense Max (<c:out value="<%= today.format(DateTimeFormatter.ofPattern(\"MMMM\")) %>"/>)</h3>
            <p class="max-expense">
                <c:set var="maxExp" value="${requestScope.maxMonthlyExpense != null ? requestScope.maxMonthlyExpense : 0}"/>
                <fmt:formatNumber value="${maxExp * -1}" minFractionDigits="2" maxFractionDigits="2"/> DH
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
                <td>
                    <fmt:formatDate value="${tx.date}" pattern="dd-MM-yyyy"/>
                </td>
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
                    Pas d'activité récente.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="chart-container">
        <h2>Évolution du Solde (Mois de <c:out value="<%= today.format(DateTimeFormatter.ofPattern(\"MMMM yyyy\")) %>"/>) 📈</h2>
        <canvas id="budgetChart"></canvas>
    </div>

    <script>
        const ctx = document.getElementById('budgetChart');

        const fullMonthLabels = <%= monthLabels %>;
        const fullBalanceData = ${requestScope.dailyBalanceHistoryJson};

        const currentDayIndex = <%= currentDayOfMonth %>;

        const labelsUpToToday = fullMonthLabels.slice(0, currentDayIndex);
        const dataUpToToday = fullBalanceData.slice(0, currentDayIndex);

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labelsUpToToday,
                datasets: [{
                    label: 'Solde (DH)',
                    data: dataUpToToday,
                    borderColor: '#2980b9',
                    backgroundColor: 'rgba(41, 128, 185, 0.1)',
                    tension: 0.3,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Jour du Mois'
                        }
                    },
                    y: {
                        beginAtZero: false,
                        title: {
                            display: true,
                            text: 'Solde (DH)'
                        }
                    }
                }
            }
        });
    </script>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>

