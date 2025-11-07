package com.project.controller;

import com.project.model.Category;
import com.project.model.Transaction;
import java.time.LocalDateTime;
import com.project.model.User;
import com.project.service.CategoryService;
import java.time.temporal.TemporalAdjusters;
import com.project.service.TransactionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/transactions/*")
public class TransactionServlet extends HttpServlet {

    private TransactionService transactionService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        this.transactionService = new TransactionService();
        this.categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getPathInfo();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (action != null) {
            switch (action) {
                case "/add":
                    showAddForm(request, response);
                    break;
                case "/delete":
                    deleteTransaction(request, response);
                    break;
                default:
                    listTransactions(request, response);
                    break;
            }
        } else {
            listTransactions(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        List<Category> categories = categoryService.getAllCategoriesByUser(currentUser);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/views/add_transaction.jsp").forward(request, response);
    }

    private void listTransactions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        List<Transaction> transactions = transactionService.getTransactionsForPeriod(
                currentUser,
                LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()),
                LocalDateTime.now().with(TemporalAdjusters.lastDayOfMonth())
        );

        request.setAttribute("transactionList", transactions);
        request.getRequestDispatcher("/views/list_transactions.jsp").forward(request, response);
    }

    private void deleteTransaction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        String transactionIdStr = request.getParameter("id");

        try {
            Long transactionId = Long.parseLong(transactionIdStr);

            transactionService.deleteTransaction(transactionId, currentUser);

        } catch (Exception e) {

            request.getSession().setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/transactions");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getPathInfo();
        if (action != null && action.equals("/add")) {
            insertTransaction(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non supportée.");
        }
    }

    private void insertTransaction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        String amountStr = request.getParameter("amount");
        String description = request.getParameter("description");
        String categoryIdStr = request.getParameter("categoryId");
        String type = request.getParameter("type");

        try {
            Double amount = Double.parseDouble(amountStr);
            Long categoryId = Long.parseLong(categoryIdStr);

            Optional<Category> categoryOpt = categoryService.getCategoryById(categoryId);
            if (categoryOpt.isEmpty() || !categoryOpt.get().getUser().getId().equals(currentUser.getId())) {
                throw new IllegalArgumentException("Catégorie invalide ou n'appartient pas à cet utilisateur.");
            }
            Category category = categoryOpt.get();


            if ("EXPENSE".equalsIgnoreCase(type) && amount > 0) {
                amount *= -1;
            } else if ("INCOME".equalsIgnoreCase(type) && amount < 0) {
                amount *= -1;
            }

            Transaction newTransaction = new Transaction();
            newTransaction.setAmount(amount);
            newTransaction.setDescription(description);
            newTransaction.setCategory(category);
            newTransaction.setUser(currentUser);

            transactionService.saveTransaction(newTransaction);

            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement: " + e.getMessage());
            showAddForm(request, response);
        }
    }
}