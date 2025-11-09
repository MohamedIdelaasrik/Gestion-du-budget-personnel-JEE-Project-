package com.project.controller;

import com.project.model.Transaction;
import com.project.model.User;
import com.project.service.TransactionService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private TransactionService transactionService;
    private ObjectMapper objectMapper = new ObjectMapper();

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
            LocalDate today = LocalDate.now();
            LocalDateTime startOfMonth = today.with(TemporalAdjusters.firstDayOfMonth()).atStartOfDay();
            LocalDateTime endOfMonth = today.with(TemporalAdjusters.lastDayOfMonth()).atTime(23, 59, 59);

            List<Transaction> monthlyTransactions = transactionService.getTransactionsForPeriod(currentUser, startOfMonth, endOfMonth);

            double totalMonthlyIncome = monthlyTransactions.stream()
                    .filter(t -> t.getAmount() > 0)
                    .mapToDouble(Transaction::getAmount)
                    .sum();

            double totalMonthlyExpense = monthlyTransactions.stream()
                    .filter(t -> t.getAmount() < 0)
                    .mapToDouble(Transaction::getAmount)
                    .sum();

            double maxMonthlyExpense = transactionService.getMaxMonthlyExpense(currentUser, startOfMonth, endOfMonth);

            double overallBalance = transactionService.getOverallBalance(currentUser);
            double globalIncome = transactionService.getGlobalIncome(currentUser);
            double globalExpenses = transactionService.getGlobalExpenses(currentUser);

            List<Double> dailyBalanceHistory = transactionService.getDailyBalanceHistoryForMonth(currentUser, today);
            String dailyBalanceHistoryJson = objectMapper.writeValueAsString(dailyBalanceHistory);

            request.setAttribute("overallBalance", overallBalance);
            request.setAttribute("globalIncome", globalIncome);
            request.setAttribute("globalExpenses", globalExpenses);
            request.setAttribute("totalMonthlyIncome", totalMonthlyIncome);
            request.setAttribute("totalMonthlyExpense", totalMonthlyExpense);
            request.setAttribute("maxMonthlyExpense", maxMonthlyExpense);

            request.setAttribute("recentTransactions", monthlyTransactions);
            request.setAttribute("dailyBalanceHistoryJson", dailyBalanceHistoryJson);

            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des données du tableau de bord.");
            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
        }
    }
}
