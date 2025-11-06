<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Catégorie</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .error { color: red; margin-bottom: 15px; }
        label { display: block; margin-top: 10px; }
        input[type="text"], select { width: 100%; padding: 8px; margin-top: 5px; box-sizing: border-box; }
        button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; margin-top: 20px; }
        a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Ajouter une Nouvelle Catégorie</h1>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/categories/add" method="POST">
            <div>
                <label for="name">Nom de la Catégorie:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div>
                <label for="type">Type:</label>
                <select id="type" name="type" required>
                    <option value="INCOME">Revenu (Entrée)</option>
                    <option value="EXPENSE">Dépense (Sortie)</option>
                </select>
            </div>

            <button type="submit">Enregistrer la Catégorie</button>
        </form>

        <p style="margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/categories">← Retour à la liste</a>
        </p>
    </div>
</body>
</html>