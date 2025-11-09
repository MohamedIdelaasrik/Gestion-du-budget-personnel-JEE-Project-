package com.project.dao;

import com.project.model.User;
import java.util.List;
import java.util.Optional;

public interface UserDao {

    void save(User user);
    void update(User user);
    void delete(Long id);

    Optional<User> findByUsername(String username);
    Optional<User> findById(Long id);
    Optional<User> findByEmail(String email);
    List<User> findAll();
}