package com.project.dao;

import com.project.model.Category;
import com.project.model.User;
import java.util.List;
import java.util.Optional;

public interface CategoryDao {

    void save(Category category);

    Optional<Category> findById(Long id);
    void update(Category category);
    void delete(Long id);
    List<Category> findAllByUser(User user);

    Optional<Category> findByNameAndUser(String name, User user);
}