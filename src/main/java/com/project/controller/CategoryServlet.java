package com.project.controller;

import com.project.model.Category;
import com.project.model.User;
import com.project.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/categories/*")
public class CategoryServlet extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        this.categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getPathInfo();
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (action != null) {
            switch (action) {
                case "/add":
                    request.getRequestDispatcher("/views/add_category.jsp").forward(request, response);
                    return;
                case "/edit":
                    showEditForm(request, response, currentUser);
                    return;
                case "/delete":
                    deleteCategory(request, response, currentUser);
                    return;
            }
        }

        List<Category> categories = categoryService.getAllCategoriesByUser(currentUser);
        request.setAttribute("categoriesList", categories);
        request.getRequestDispatcher("/views/list_categories.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String action = request.getPathInfo();
        String idStr = request.getParameter("id");

        boolean success = false;
        String forwardPath = "/views/add_category.jsp";

        try {
            if (action != null && action.equals("/add")) {
                Category newCategory = new Category(name, type, currentUser);
                success = categoryService.saveCategory(newCategory);

            } else if (action != null && action.equals("/update")) {
                forwardPath = "/views/edit_category.jsp";
                Long id = Long.parseLong(idStr);

                Optional<Category> existingCategoryOpt = categoryService.getCategoryById(id)
                        .filter(c -> c.getUser().getId().equals(currentUser.getId()));

                if (existingCategoryOpt.isPresent()) {
                    Category categoryToUpdate = existingCategoryOpt.get();
                    categoryToUpdate.setName(name);
                    categoryToUpdate.setType(type);
                    success = categoryService.updateCategory(categoryToUpdate);

                    if (!success) {
                        request.setAttribute("category", categoryToUpdate);
                    }
                } else {
                    throw new IllegalArgumentException("Catégorie non trouvée ou non autorisée.");
                }
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/categories");
            } else {
                request.setAttribute("errorMessage", "Erreur: Le nom de la catégorie existe déjà ou les données sont invalides.");
                request.getRequestDispatcher(forwardPath).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du traitement: " + e.getMessage());

            if (idStr != null) {
                try {
                    Optional<Category> categoryOpt = categoryService.getCategoryById(Long.parseLong(idStr));
                    categoryOpt.ifPresent(category -> request.setAttribute("category", category));
                } catch (NumberFormatException ignored) { }
            }

            request.getRequestDispatcher(forwardPath).forward(request, response);
        }
    }


    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/categories");
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            Category category = categoryService.getCategoryById(id)
                    .filter(c -> c.getUser().getId().equals(user.getId()))
                    .orElseThrow(() -> new IllegalArgumentException("Catégorie non trouvée ou accès non autorisé."));

            request.setAttribute("category", category);
            request.getRequestDispatcher("/views/edit_category.jsp").forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Erreur: Catégorie invalide ou non trouvée.");
            response.sendRedirect(request.getContextPath() + "/categories");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/categories");
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            categoryService.deleteCategory(id,user);

            response.sendRedirect(request.getContextPath() + "/categories");

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Erreur lors de la suppression de la catégorie.");
            response.sendRedirect(request.getContextPath() + "/categories");
        }
    }
}