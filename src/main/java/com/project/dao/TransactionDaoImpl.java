package com.project.dao;

import com.project.model.Transaction;
import com.project.model.User;
import com.project.util.HibernateUtil;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class TransactionDaoImpl implements TransactionDao {

    @Override
    public void save(Transaction transaction) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(transaction);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public Optional<Transaction> findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.find(Transaction.class, id);
            return Optional.ofNullable(transaction);
        } catch (Exception e) {
            e.printStackTrace();
            return Optional.empty();
        }
    }

    @Override
    public void update(Transaction transaction) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(transaction);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Long id) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            Transaction transaction = session.find(Transaction.class, id);

            if (transaction != null) {
                session.remove(transaction);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public List<Transaction> findByUserAndPeriod(User user, LocalDateTime startDate, LocalDateTime endDate) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Transaction> query = session.createQuery(
                    "FROM Transaction t WHERE t.user = :user AND t.transactionDate >= :start AND t.transactionDate <= :end ORDER BY t.transactionDate DESC",
                    Transaction.class);

            query.setParameter("user", user);
            query.setParameter("start", startDate);
            query.setParameter("end", endDate);

            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public List<Transaction> findAllByUser(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Transaction> query = session.createQuery(
                    "FROM Transaction t WHERE t.user = :user ORDER BY t.transactionDate DESC",
                    Transaction.class);
            query.setParameter("user", user);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
    public void invertAmountsByCategoryId(Long categoryId) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            String hql = "UPDATE Transaction t SET t.amount = -t.amount WHERE t.category.id = :categoryId";

            session.createQuery(hql)
                    .setParameter("categoryId", categoryId)
                    .executeUpdate();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}