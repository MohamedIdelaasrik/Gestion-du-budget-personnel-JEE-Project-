<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>À Propos | Mon Budget</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="container" style="max-width: 1000px;">
    <h2>À Propos de Gestion Budget 💡</h2>
    <p>Bienvenue sur Gestion Budget, votre outil simple et efficace pour prendre le contrôle de vos finances personnelles. Notre mission est de simplifier la clarté financière.</p>

    <div class="about-card" style="margin-bottom: 25px; background-color: #f7f9fc;">
        <h3 style="color:#1abc9c; border-bottom-color: #eee;">Qui sommes-nous ? 🤝</h3>
        <p>
            <b>Gestion Budget</b> est le fruit du travail de <b>EL AROUF OUSSAMA</b> et <b>IDELAASRI MOHAMED</b>  (Elèves ingénieurs en Développement Logiciel et Applications à l'ENSA d'Agadir). Cette application web est réalisé en binôme dans le cadre du projet du module JEE (Java Enterprise Edition).
            Notre mission était double : fournir un outil de suivi financier intuitif et rapide pour l'utilisateur final, tout en démontrant une implémentation robuste et conforme aux architectures JEE (Servlets, JSP, Modèle MVC, etc.).
            Ce projet est une démonstration de notre capacité à construire des applications web transactionnelles complètes.
            Nous nous engageons à améliorer continuellement l'application en nous basant sur les retours de nos utilisateurs pour que votre expérience de gestion budgétaire soit toujours la meilleure possible.
        </p>
    </div>
    <div class="about-grid">

        <div class="about-card">
            <h3>Notre Mission</h3>
            <p>Rendre la gestion budgétaire facile et visuelle. Nous vous fournissons les données nécessaires pour anticiper et maintenir votre budget en équilibre. La clarté financière doit être accessible à tous.</p>
        </div>

        <div class="about-card">
            <h3>Les Fondamentaux</h3>
            <ul>
                <li>Transparence des données.</li>
                <li>Sécurité de l'accès (connexion sécurisée).</li>
                <li>Design centré sur l'utilisateur.</li>
                <li>Performance et rapidité.</li>
            </ul>
        </div>

        <div class="about-card" style="grid-column: span 2;">
            <h3>Fonctionnalités Clés</h3>
            <ul>
                <li>Tableau de Bord Complet : Solde global, revenus et dépenses du mois en un coup d'œil.</li>
                <li>Suivi par Catégories : Organisation des transactions par catégories personnalisées (Revenu vs. Dépense).</li>
                <li>Courbe de Solde Dynamique : Visualisation de l'évolution du budget jour après jour (grâce à Chart.js).</li>
                <li>Navigation Intuitive : Un système de liens simple pour la gestion.</li>
            </ul>
        </div>

        <div class="call-to-action">
            <a href="<%= request.getContextPath() %>/dashboard" class="button-link primary" style="padding: 15px 30px; font-size: 1.1em;">
                Revenir au Tableau de Bord
            </a>
        </div>

    </div>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>