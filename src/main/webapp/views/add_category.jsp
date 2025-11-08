<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Catégorie | Mon Budget</title>
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
        select:focus {
            outline: none;
            border-color: #1abc9c;
            box-shadow: 0 0 8px rgba(26, 188, 156, 0.3);
        }

        .submit-button {
            background-color: #1abc9c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            font-size: 1.1em;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
        }

        .submit-button:hover {
            background-color: #16a085;
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
        <strong style="color:#e8ffe8;"><c:out value="${sessionScope.currentUser.username}"/></strong> |
        <a href="<%= request.getContextPath() %>/auth?action=logout">Déconnexion</a>
    </div>
</div>

<div class="form-container">
    <h2>Ajouter une Catégorie 🏷️</h2>

    <c:if test="${not empty requestScope.errorMessage}">
        <p class="error">
            ⚠️ <c:out value="${requestScope.errorMessage}"/>
        </p>
    </c:if>

    <form action="<%= request.getContextPath() %>/categories/add" method="POST">
        <div class="form-group">
            <label for="name">Nom de la Catégorie:</label>
            <input type="text" id="name" name="name" required placeholder="Ex: Courses, Salaire, Loyer...">
        </div>

        <div class="form-group">
            <label for="type">Type:</label>
            <select id="type" name="type" required>
                <option value="EXPENSE">Dépense (Sortie)</option>
                <option value="INCOME">Revenu (Entrée)</option>
            </select>
        </div>

        <button type="submit" class="submit-button">Enregistrer la Catégorie</button>
    </form>

    <a href="<%= request.getContextPath() %>/categories" class="back-link">
        ← Annuler et retourner à la liste
    </a>
</div>

</body>
</html>
