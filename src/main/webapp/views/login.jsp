<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion | Mon Budget</title>
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

        .error {
            color: #c0392b;
            background: #fbe6e6;
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid #e74c3c;
            margin-bottom: 25px;
            font-weight: 500;
        }

        label {
            display: block;
            text-align: left;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin: 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            background-color: #fdfdfd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
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
            margin-top: 30px;
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

        .register-link {
            display: block;
            margin-top: 30px;
            font-size: 0.95em;
            color: #7f8c8d;
        }

        .register-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        .register-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Se Connecter 🔑</h2>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <p class="error">⚠️ <%= errorMessage %></p>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/login" method="POST">
        <div>
            <label for="username">Nom d'utilisateur:</label>
            <input type="text" id="username" name="username" required placeholder="Votre nom d'utilisateur">
        </div>
        <div>
            <label for="password">Mot de passe:</label>
            <input type="password" id="password" name="password" required placeholder="********">
        </div>

        <button type="submit" class="submit-button">Se Connecter</button>
    </form>

    <p class="register-link">
        Pas encore de compte? <a href="<%= request.getContextPath() %>/register">S'inscrire ici</a>
    </p>

</div>
</body>
</html>
