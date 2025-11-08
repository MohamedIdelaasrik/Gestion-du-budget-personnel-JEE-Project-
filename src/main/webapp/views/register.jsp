<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription | Mon Budget</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #2c3e50;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 400px;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .container h2 {
            color: #1abc9c;
            font-weight: 700;
            margin-bottom: 30px;
            font-size: 2em;
        }

        .message-box {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: left;
        }

        .error {
            color: #c0392b;
            background: #fbe6e6;
            border: 1px solid #e74c3c;
        }

        .success {
            color: #27ae60;
            background: #e6f6ed;
            border: 1px solid #2ecc71;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            background-color: #fdfdfd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            outline: none;
            border-color: #1abc9c;
            box-shadow: 0 0 8px rgba(26, 188, 156, 0.3);
        }

        .submit-button {
            background-color: #2ecc71;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            margin-top: 30px;
            width: 100%;
            font-size: 1.1em;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
        }

        .submit-button:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .login-link {
            display: block;
            margin-top: 25px;
            font-size: 0.95em;
            color: #7f8c8d;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
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
    <p class="message-box error">⚠️ <%= errorMessage %></p>
    <%
    } else if (successMessage != null && !successMessage.isEmpty()) {
    %>
    <p class="message-box success">🎉 <%= successMessage %></p>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/register" method="POST">
        <input type="hidden" name="action" value="register">

        <div>
            <input type="text" id="username" name="username" placeholder="Nom d'utilisateur (requis)" required
                   value="<%= request.getAttribute("oldUsername") != null ? request.getAttribute("oldUsername") : "" %>">
        </div>

        <div>
            <input type="email" id="email" name="email" placeholder="Adresse Email (requis)" required
                   value="<%= request.getAttribute("oldEmail") != null ? request.getAttribute("oldEmail") : "" %>">
        </div>

        <div>
            <input type="password" id="password" name="password" placeholder="Mot de passe (minimum 6 caractères)" required>
        </div>

        <button type="submit" class="submit-button">S'inscrire</button>
    </form>

    <p class="login-link">
        Vous avez déjà un compte ?
        <a href="<%= request.getContextPath() %>/login">Se connecter ici</a>
    </p>
</div>
</body>
</html>