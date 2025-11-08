package com.project.dao;

import com.project.model.Transaction;
import com.project.model.User;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TransactionDao {

    void save(Transaction transaction);

    Optional<Transaction> findById(Long id);

    void update(Transaction transaction);

    void delete(Long id);

    List<Transaction> findByUserAndPeriod(User user, LocalDateTime startDate, LocalDateTime endDate);

    List<Transaction> findAllByUser(User user);
    void invertAmountsByCategoryId(Long categoryId);
}