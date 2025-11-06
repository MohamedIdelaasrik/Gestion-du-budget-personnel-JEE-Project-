<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Gestion de Budget</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        .container { width: 350px; margin: 100px auto; padding: 25px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .error { color: #d9534f; background-color: #f2dede; border: 1px solid #ebccd1; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        input[type="text"], input[type="password"] { width: 90%; padding: 10px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #5cb85c; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; margin-top: 10px; }
        button:hover { background-color: #4cae4c; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Connexion</h2>

        <%-- 1. Affichage du message d'erreur --%>
        <%
            // Récupération de l'erreur envoyée par l'AuthServlet
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <p class="error"><%= errorMessage %></p>
        <%
            }
        %>

        <%-- 2. Formulaire de Connexion --%>
        <form action="<%= request.getContextPath() %>/login" method="POST">
            <div>
                <label for="username">Nom d'utilisateur:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div>
                <label for="password">Mot de passe:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit">Se Connecter</button>
        </form>

        <p style="margin-top: 20px;">
            Pas encore de compte? <a href="<%= request.getContextPath() %>/register">S'inscrire</a>
        </p>

    </div>
</body>
</html>