package com.project.controller;

import com.project.model.User;
import com.project.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/views/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        String newUsername = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        if (!userService.checkPassword(currentUser.getUsername(), currentPassword)) {
            request.setAttribute("errorMessage", "Le mot de passe actuel est incorrect. Aucune modification n'a été effectuée.");
            request.getRequestDispatcher("/views/settings.jsp").forward(request, response);
            return;
        }

        try {
            boolean usernameChanged = !currentUser.getUsername().equals(newUsername);
            boolean passwordChanged = (newPassword != null && !newPassword.trim().isEmpty());

            if (usernameChanged || passwordChanged) {

                userService.updateUser(
                        currentUser.getId(),
                        newUsername,
                        passwordChanged ? newPassword : null
                );

                currentUser.setUsername(newUsername);

                request.setAttribute("successMessage", "Vos informations de compte ont été mises à jour avec succès !");

            } else {
                request.setAttribute("errorMessage", "Aucune modification détectée.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la mise à jour du compte : " + e.getMessage());
        }

        request.getRequestDispatcher("/views/settings.jsp").forward(request, response);
    }
}
