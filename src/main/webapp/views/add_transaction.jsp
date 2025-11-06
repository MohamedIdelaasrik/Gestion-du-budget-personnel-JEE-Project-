<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Transaction</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 500px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        .error { color: red; margin-bottom: 15px; }
        label { display: block; margin-top: 15px; font-weight: bold; }
        input[type="number"], input[type="text"], select { width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; margin-top: 25px; width: 100%; }
        button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Enregistrer une Nouvelle Transaction</h1>

        <c:if test="${not empty requestScope.errorMessage}">
            <p class="error">${requestScope.errorMessage}</p>
        </c:if>


        <form action="<%= request.getContextPath() %>/transactions/add" method="POST">

            <div>
                <label>Type de Transaction:</label>
                <input type="radio" id="income" name="type" value="INCOME" checked>
                <label for="income" style="display: inline-block; margin-left: 10px;">Revenu (Entrée)</label>

                <input type="radio" id="expense" name="type" value="EXPENSE" style="margin-left: 20px;">
                <label for="expense" style="display: inline-block; margin-left: 10px;">Dépense (Sortie)</label>
            </div>

            <div>
                <label for="amount">Montant (F CFA ou devise locale):</label>
                <input type="number" id="amount" name="amount" step="0.01" required min="0.01">
            </div>

            <div>
                <label for="description">Description (Optionnel):</label>
                <input type="text" id="description" name="description" maxlength="255">
            </div>

            <div>
                <label for="categoryId">Catégorie:</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="">-- Choisir une catégorie --</option>
                    <c:forEach items="${requestScope.categories}" var="cat">
                        <option value="${cat.id}">
                            ${cat.name} (${cat.type == 'INCOME' ? 'Revenu' : 'Dépense'})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit">Enregistrer</button>
        </form>

        <p style="margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/dashboard">← Retour au Tableau de Bord</a>
        </p>
    </div>
</body>
</html>