package com.project.service;

import com.project.dao.UserDaoImpl;
import com.project.model.User;
import java.util.Optional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class UserService {

    private final UserDaoImpl userDao;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserService() {
        this.userDao = new UserDaoImpl();
        this.passwordEncoder = new BCryptPasswordEncoder();
    }


    public boolean registerUser(User user) {
        if (userDao.findByUsername(user.getUsername()).isPresent()) {
            System.err.println("Username already exists: " + user.getUsername());
            return false;
        }

        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);

        try {
            userDao.save(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public Optional<User> authenticate(String username, String rawPassword) {
        Optional<User> userOptional = userDao.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            if (passwordEncoder.matches(rawPassword, user.getPassword())) {
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }
}