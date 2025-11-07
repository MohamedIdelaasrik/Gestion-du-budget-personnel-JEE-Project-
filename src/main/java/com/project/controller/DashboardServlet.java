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
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private TransactionService transactionService;

    @Override
    public void init() throws ServletException {
        this.transactionService = new TransactionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            double monthlyBalance = transactionService.calculateMonthlyBalance(currentUser);
            double weeklyBalance = transactionService.calculateWeeklyBalance(currentUser);

            LocalDateTime startOfMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).toLocalDate().atStartOfDay();
            LocalDateTime endOfMonth = LocalDateTime.now().with(TemporalAdjusters.lastDayOfMonth()).toLocalDate().atTime(23, 59, 59);

            List<Transaction> transactions = transactionService.getTransactionsForPeriod(currentUser, startOfMonth, endOfMonth);

            double totalIncome = transactions.stream()
                    .filter(t -> t.getAmount() > 0)
                    .mapToDouble(Transaction::getAmount)
                    .sum();

            double totalExpense = transactions.stream()
                    .filter(t -> t.getAmount() < 0)
                    .mapToDouble(Transaction::getAmount)
                    .sum();

            request.setAttribute("currentUser", currentUser);
            request.setAttribute("monthlyBalance", monthlyBalance);
            request.setAttribute("weeklyBalance", weeklyBalance);
            request.setAttribute("totalIncome", totalIncome);
            request.setAttribute("totalExpense", Math.abs(totalExpense));
            request.setAttribute("recentTransactions", transactions);

            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des données du tableau de bord.");
            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
        }
    }
}