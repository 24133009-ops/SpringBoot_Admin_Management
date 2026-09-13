package com.example.demo.controller;

import com.example.demo.entity.Category;
import com.example.demo.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping({"", "/"})
    public String index(Model model,
                        @RequestParam(value = "keyword", required = false) String keyword,
                        @RequestParam(value = "page", required = false) Integer page) {
        int currentPage = (page == null || page < 1) ? 1 : page;
        String searchKeyword = (keyword == null) ? "" : keyword.trim();
        int pageSize = 5;

        Page<Category> categoryPage = categoryService.listAll(searchKeyword, currentPage, pageSize);

        model.addAttribute("listCategories", categoryPage.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", Math.max(categoryPage.getTotalPages(), 1));
        model.addAttribute("totalItems", categoryPage.getTotalElements());
        model.addAttribute("keyword", searchKeyword);

        return "admin/category/list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("category", new Category());
        return "admin/category/form"; // Khớp với đường dẫn file form.jsp
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.get(id);
        if (category == null) {
            return "redirect:/admin/categories";
        }
        model.addAttribute("category", category);
        return "admin/category/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("category") Category category) {
        categoryService.save(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        categoryService.delete(id);
        return "redirect:/admin/categories";
    }
}