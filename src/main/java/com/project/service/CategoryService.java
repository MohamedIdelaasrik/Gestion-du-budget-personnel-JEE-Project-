package com.project.service;

import com.project.dao.CategoryDaoImpl;
import com.project.model.Category;
import com.project.model.User;
import java.util.List;
import java.util.Optional;

public class CategoryService {

    private final CategoryDaoImpl categoryDao;

    public CategoryService() {
        this.categoryDao = new CategoryDaoImpl();
    }

    public boolean saveCategory(Category category) {
        Optional<Category> existingCategory = categoryDao.findByNameAndUser(
                category.getName(), category.getUser());

        if (existingCategory.isPresent()) {
            System.err.println("Le nom de la catégorie existe déjà pour cet utilisateur : " + category.getName());
            return false;
        }

        try {
            categoryDao.save(category);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCategory(Category category) {
        Optional<Category> existing = categoryDao.findByNameAndUser(category.getName(), category.getUser());

        if (existing.isPresent() && !existing.get().getId().equals(category.getId())) {
            System.err.println("Mise à jour échouée : Ce nom est déjà utilisé par une autre catégorie de cet utilisateur.");
            return false;
        }

        try {
            categoryDao.update(category);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // MODIFICATION ICI : Ajout de l'objet User pour la sécurité
    public boolean deleteCategory(Long categoryId, User user) {
        Optional<Category> categoryOpt = categoryDao.findById(categoryId);

        if (categoryOpt.isEmpty()) {
            // Catégorie non trouvée
            return false;
        }

        Category category = categoryOpt.get();

        // **Vérification de la propriété de l'utilisateur (Sécurité)**
        if (!category.getUser().getId().equals(user.getId())) {
            // Tentative de supprimer la catégorie d'un autre utilisateur
            System.err.println("Tentative de suppression non autorisée de la catégorie ID: " + categoryId + " par l'utilisateur: " + user.getId());
            return false;
        }

        try {
            categoryDao.delete(categoryId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Category> getAllCategoriesByUser(User user) {
        return categoryDao.findAllByUser(user);
    }

    public Optional<Category> getCategoryById(Long id) {
        return categoryDao.findById(id);
    }
}