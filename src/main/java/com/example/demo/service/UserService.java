package com.example.demo.service;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public Page<User> listAll(String keyword, int pageNum, int pageSize) {
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.by("id").descending());
        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = keyword.trim();
            return userRepository.findByUsernameContainingIgnoreCaseOrFullNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
                    kw, kw, kw, pageable);
        }
        return userRepository.findAll(pageable);
    }

    public User get(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public void save(User user) {
        if (user.getId() == null) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        } else {
            User existing = userRepository.findById(user.getId()).orElse(null);
            if (existing != null) {
                if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                    user.setPassword(existing.getPassword());
                } else if (!user.getPassword().equals(existing.getPassword())) {
                    user.setPassword(passwordEncoder.encode(user.getPassword()));
                }
            }
        }
        userRepository.save(user);
    }

    public void delete(Long id) {
        userRepository.deleteById(id);
    }
}