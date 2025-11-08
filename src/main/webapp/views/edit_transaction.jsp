<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier la Transaction | Mon Budget</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #eef1f5;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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

        .form-container {
            width: 100%;
            max-width: 550px;
            margin: 40px auto;
            padding: 35px 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.12);
        }

        .form-container h2 {
            color: #1a1a1a;
            font-weight: 600;
            margin-top: 0;
            margin-bottom: 25px;
            text-align: center;
            font-size: 1.6em;
        }

        .form-container h1 {
            color: #2c3e50;
            text-align: center;
            font-size: 1.8em;
            margin-bottom: 30px;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
        }

        .error {
            color: #c0392b;
            background: #fbe6e6;
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid #e74c3c;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            font-size: 0.95em;
        }

        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            background-color: #fdfdfd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #1abc9c;
            box-shadow: 0 0 8px rgba(26, 188, 156, 0.3);
        }

        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }

        .submit-button {
            background-color: #f39c12;
            color: #333;
            padding: 12px 20px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            margin-top: 20px;
            width: 100%;
            font-size: 1.1em;
            font-weight: 700;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
        }

        .submit-button:hover {
            background-color: #e67e22;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #7f8c8d;
            text-decoration: none;
            font-size: 0.9em;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: #2c3e50;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="header">
    <h1 class="logo">Mon Budget 💸</h1>
    <div class="user-info">
        Connecté en tant que:
        <strong><c:out value="${sessionScope.currentUser.username}"/></strong> |
        <a href="<%= request.getContextPath() %>/auth?action=logout">Déconnexion</a>
    </div>
</div>

<div class="form-container">
    <h1>Modifier la Transaction #<c:out value="${requestScope.transaction.id}"/> 🛠️</h1>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <form action="<%= request.getContextPath() %>/transactions/update" method="POST">

        <input type="hidden" name="id" value="${requestScope.transaction.id}">

        <div class="form-group">
            <label for="amount">Montant (Entrez la valeur absolue):</label>
            <input type="number"
                   id="amount"
                   name="amount"
                   step="0.01"
                   required min="0.01"
                   placeholder="Ex: 150.50"
                   value="${requestScope.transaction.amount >= 0 ? requestScope.transaction.amount : requestScope.transaction.amount * -1}">
        </div>

        <div class="form-group">
            <label for="description">Description (Optionnel):</label>
            <input type="text"
                   id="description"
                   name="description"
                   maxlength="255"
                   placeholder="Ex: Courses au supermarché"
                   value="<c:out value="${requestScope.transaction.description}"/>">
        </div>

        <div class="form-group">
            <label for="categoryId">Catégorie:</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">-- Choisir une catégorie --</option>
                <c:forEach items="${requestScope.categories}" var="cat">
                    <option value="${cat.id}"
                            <c:if test="${cat.id == requestScope.transaction.category.id}">selected</c:if>>
                        <c:out value="${cat.name}"/> (<c:out value="${cat.type == 'INCOME' ? 'Revenu' : 'Dépense'}"/>)
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="submit-button">Enregistrer les Modifications</button>
    </form>

    <a href="<%= request.getContextPath() %>/transactions" class="back-link">
        ← Annuler et retourner à la liste des transactions
    </a>
</div>

</body>
</html>