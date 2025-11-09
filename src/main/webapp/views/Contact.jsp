<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Contact | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
    <style>
        textarea.input-field {
            width: 100%;
            padding: 12px 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            background-color: #fdfdfd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        textarea.input-field:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 8px rgba(26, 188, 156, 0.3);
        }
    </style>
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="container" style="max-width: 750px;">

    <div class="call-to-action">
        <a href="<%= request.getContextPath() %>/dashboard" class="button-link primary" style="padding: 15px 30px; font-size: 1.1em;">
            Revenir au Tableau de Bord
        </a>
    </div>

    <h2>Nous Contacter 💬</h2>
    <p>Avez-vous des questions, des commentaires ou des suggestions d'amélioration ? Remplissez le formulaire ci-dessous.</p>

    <div class="form-container" style="padding: 30px;">
        <form action="#" method="POST">
            <div class="form-group">
                <label for="name">Votre Nom</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Votre Email</label>
                <input type="text" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="subject">Sujet</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="message">Message</label>
                <textarea id="message" name="message" rows="5" class="input-field" required></textarea>
            </div>

            <button type="submit" class="submit-button">Envoyer le Message</button>
        </form>
    </div>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>