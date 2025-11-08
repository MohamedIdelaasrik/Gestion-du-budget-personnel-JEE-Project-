package com.project.service;

import com.project.dao.TransactionDaoImpl;
import com.project.model.Transaction;
import com.project.model.User;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Optional;

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


    public double calculateMonthlyBalance(User user) {
        LocalDateTime startOfMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfMonth = LocalDateTime.now().with(TemporalAdjusters.lastDayOfMonth()).withHour(23).withMinute(59).withSecond(59);

        return calculateBalanceForPeriod(user, startOfMonth, endOfMonth);
    }


    public double calculateWeeklyBalance(User user) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfWeek = now.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)).withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfWeek = now.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY)).withHour(23).withMinute(59).withSecond(59);

        return calculateBalanceForPeriod(user, startOfWeek, endOfWeek);
    }


    public double calculateBalanceForPeriod(User user, LocalDateTime startDate, LocalDateTime endDate) {
        List<Transaction> transactions = transactionDao.findByUserAndPeriod(user, startDate, endDate);

        return transactions.stream()
                .mapToDouble(Transaction::getAmount)
                .sum();
    }


    public List<Transaction> getTransactionsForPeriod(User user, LocalDateTime startDate, LocalDateTime endDate) {
        return transactionDao.findByUserAndPeriod(user, startDate, endDate);
    }
}