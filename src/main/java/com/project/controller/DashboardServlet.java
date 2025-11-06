package com.project.controller;

import com.project.model.Transaction;
import com.project.model.User;
import com.project.service.TransactionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final TransactionService transactionService = new TransactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Calcul des soldes
        double monthlyBalance = transactionService.calculateMonthlyBalance(user);
        double weeklyBalance = transactionService.calculateWeeklyBalance(user);

        // Transactions récentes (dernier mois)
        LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfMonth = LocalDateTime.now().withDayOfMonth(LocalDateTime.now().toLocalDate().lengthOfMonth())
                .withHour(23).withMinute(59).withSecond(59);

        List<Transaction> recentTransactions = transactionService.getTransactionsForPeriod(user, startOfMonth, endOfMonth);

        // Attributs pour la JSP
        request.setAttribute("monthlyBalance", monthlyBalance);
        request.setAttribute("weeklyBalance", weeklyBalance);
        request.setAttribute("recentTransactions", recentTransactions);

        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}
