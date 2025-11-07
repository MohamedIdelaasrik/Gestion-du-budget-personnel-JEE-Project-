<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - Gestion de Budget</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background-color: #f0f2f5; }
        .container { width: 350px; margin: 80px auto; padding: 25px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); background-color: white; }
        h2 { margin-top: 0; }
        .error { color: #d9534f; background-color: #f2dede; border: 1px solid #ebccd1; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: left; }
        .success { color: #28a745; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: left; }
        input[type="text"], input[type="password"], input[type="email"] { /* Ajout de input[type="email"] */
            width: 100%; padding: 10px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;
        }
        button { background-color: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; margin-top: 10px; }
        button:hover { background-color: #218838; }
        a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
<div class="container">
    <h2>Créer un Compte</h2>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) request.getAttribute("successMessage");

        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <p class="error"><%= errorMessage %></p>
    <%
    } else if (successMessage != null && !successMessage.isEmpty()) {
    %>
    <p class="success"><%= successMessage %></p>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/register" method="POST">
        <input type="hidden" name="action" value="register">

        <div>
            <input type="text" id="username" name="username" placeholder="Nom d'utilisateur" required>
        </div>

        <%-- NOUVEAU CHAMP EMAIL --%>
        <div>
            <input type="email" id="email" name="email" placeholder="Email" required>
        </div>

        <div>
            <input type="password" id="password" name="password" placeholder="Mot de passe" required>
        </div>

        <button type="submit">S'inscrire</button>
    </form>

    <p style="margin-top: 15px;">
        Vous avez déjà un compte ?
        <a href="<%= request.getContextPath() %>/login">Se connecter ici</a>
    </p>
</div>
</body>
</html>