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
import java.util.Optional;

@WebServlet("/login")
public class AuthServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Optional<User> authenticatedUser = userService.authenticate(username, password);

        if (authenticatedUser.isPresent()) {

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", authenticatedUser.get());

            response.sendRedirect(request.getContextPath() + "/dashboard");

        } else {

            request.setAttribute("errorMessage", "Le mot de passe/ Le nom d'utilisateur est incorrecte");

            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}