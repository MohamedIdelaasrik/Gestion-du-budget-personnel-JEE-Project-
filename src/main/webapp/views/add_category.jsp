<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Catégorie</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .container { width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; background-color: white; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        h1 { color: #333; margin-top: 0; }
        .error { color: #d9534f; background-color: #f2dede; border: 1px solid #ebccd1; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input[type="text"], select { width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; margin-top: 20px; width: 100%; }
        button:hover { background-color: #0056b3; }
        a { color: #6c757d; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>
<div class="container">
    <h1>Ajouter une Nouvelle Catégorie</h1>

    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <p class="error"> <%= errorMessage %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/categories/add" method="POST">
        <div>
            <label for="name">Nom de la Catégorie:</label>
            <input type="text" id="name" name="name" required>
        </div>

        <div>
            <label for="type">Type:</label>
            <select id="type" name="type" required>
                <option value="EXPENSE">Dépense (Sortie)</option>
                <option value="INCOME">Revenu (Entrée)</option>
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