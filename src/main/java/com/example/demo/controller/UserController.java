package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String index(Model model,
                        @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
                        @RequestParam(name = "page", required = false, defaultValue = "1") int page) {
        int pageSize = 5;
        Page<User> userPage = userService.listAll(keyword, page, pageSize);

        model.addAttribute("listUsers", userPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalItems", userPage.getTotalElements());
        model.addAttribute("keyword", keyword);
        return "admin/user/list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        User user = new User();
        user.setEnabled(true);
        user.setRole("ROLE_USER");
        model.addAttribute("user", user);
        return "admin/user/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        User user = userService.get(id);
        if (user == null) {
            return "redirect:/admin/users";
        }
        user.setPassword("");
        model.addAttribute("user", user);
        return "admin/user/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("user") User user) {
        userService.save(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        userService.delete(id);
        return "redirect:/admin/users";
    }
}