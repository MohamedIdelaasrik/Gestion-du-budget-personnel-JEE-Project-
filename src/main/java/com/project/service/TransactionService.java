package com.project.service;

import com.project.dao.TransactionDaoImpl;
import com.project.model.Transaction;
import com.project.model.User;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;

public class TransactionService {

    private final TransactionDaoImpl transactionDao;

    public TransactionService() {
        this.transactionDao = new TransactionDaoImpl();
    }

    public void saveTransaction(Transaction transaction) {
        if (transaction.getAmount() == null || transaction.getAmount() == 0.0) {
            throw new IllegalArgumentException("Le montant de la transaction ne peut pas être zéro.");
        }
        transactionDao.save(transaction);
    }

    public void deleteTransaction(Long transactionId, User user) throws IllegalArgumentException {
        Optional<Transaction> transactionOpt = transactionDao.findById(transactionId);

        if (transactionOpt.isEmpty()) {
            throw new IllegalArgumentException("Transaction non trouvée.");
        }

        Transaction transaction = transactionOpt.get();

        if (!transaction.getUser().getId().equals(user.getId())) {
            throw new IllegalArgumentException("Accès non autorisé: Cette transaction ne vous appartient pas.");
        }

        try {
            transactionDao.delete(transactionId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la suppression de la transaction en base de données.", e);
        }
    }

    public void updateTransaction(Transaction transaction) {
        if (transaction.getAmount() == null || transaction.getAmount() == 0.0) {
            throw new IllegalArgumentException("Le montant de la transaction ne peut pas être zéro.");
        }
        transactionDao.update(transaction);
    }

    public void invertAmountsByCategoryId(Long categoryId) {
        transactionDao.invertAmountsByCategoryId(categoryId);
    }

    public Optional<Transaction> getTransactionById(Long id) {
        return transactionDao.findById(id);
    }

    public List<Transaction> getTransactionsForPeriod(User user, LocalDateTime startDate, LocalDateTime endDate) {
        return transactionDao.findByUserAndPeriod(user, startDate, endDate);
    }

    public double getOverallBalance(User user) {
        return transactionDao.findAllByUser(user).stream()
                .mapToDouble(Transaction::getAmount)
                .sum();
    }

    public double getGlobalIncome(User user) {
        return transactionDao.getGlobalIncome(user);
    }

    public double getGlobalExpenses(User user) {
        return transactionDao.getGlobalExpenses(user);
    }

    public double getMaxMonthlyExpense(User user, LocalDateTime startDate, LocalDateTime endDate) {
        return transactionDao.getMaxMonthlyExpense(user, startDate, endDate);
    }

    public List<Double> getDailyBalanceHistoryForMonth(User user, LocalDate date) {
        LocalDateTime startOfMonth = date.withDayOfMonth(1).atStartOfDay();
        int daysInMonth = date.lengthOfMonth();

        double startingBalance = transactionDao.getBalanceBeforeDate(user, startOfMonth);

        List<Transaction> monthlyTransactions = getTransactionsForPeriod(user, startOfMonth, date.atTime(23, 59, 59));

        Map<Integer, Double> dailyTotals = monthlyTransactions.stream()
                .collect(Collectors.groupingBy(
                        tx -> tx.getTransactionDate().getDayOfMonth(),
                        Collectors.summingDouble(Transaction::getAmount)
                ));

        List<Double> dailyBalances = new ArrayList<>();
        double currentBalance = startingBalance;

        for (int day = 1; day <= daysInMonth; day++) {
            currentBalance += dailyTotals.getOrDefault(day, 0.0);
            dailyBalances.add(currentBalance);
        }
        return dailyBalances;
    }
}