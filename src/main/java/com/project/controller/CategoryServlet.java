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

        if (action != null && action.equals("/add")) {
            request.getRequestDispatcher("/views/add_category.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        List<Category> categories = categoryService.getAllCategoriesByUser(currentUser);

        request.setAttribute("categoriesList", categories);

        request.getRequestDispatcher("/views/list_categories.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String action = request.getPathInfo();

        Category newCategory = new Category(name, type, currentUser);

        boolean success = false;

        if (action != null && action.equals("/add")) {
            success = categoryService.saveCategory(newCategory);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/categories");
        } else {
            request.setAttribute("errorMessage", "Erreur: Le nom de la catégorie existe déjà ou les données sont invalides.");
            request.getRequestDispatcher("/views/add_category.jsp").forward(request, response);
        }
    }
}