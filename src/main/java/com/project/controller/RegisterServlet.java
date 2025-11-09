package com.project.controller;

import com.project.model.User;
import com.project.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPassword(password);

            userService.registerUser(newUser);

            request.getSession().setAttribute("successMessage", "Inscription réussie ! Veuillez vous connecter.");
            response.sendRedirect(request.getContextPath() + "/login");

        } catch (IllegalArgumentException e) {
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur interne est survenue lors de l'inscription.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}