package com.GymInfo.OxyGym.service;

import java.util.List;
import java.util.Optional;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import com.GymInfo.OxyGym.bean.GymUser;
import com.GymInfo.OxyGym.dao.GymUserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Service
public class GymUserService implements UserDetailsService {
   @Autowired
   private GymUserRepository repository;
   private String type;
   private GymUser users;

    public void save(GymUser user) {
        if (user.getType() == null || user.getType().trim().isEmpty()) {
            user.setType("Member");
        }
        System.out.println("✅ Saving user: " + user.getUsername() + " | Type: " + user.getType() + " | Verified: " + user.isVerified());
        repository.save(user);
    }

    public String getType() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            System.out.println("🚨 Authentication is NULL or not authenticated!");
            return null;
        }

        if (!(authentication.getPrincipal() instanceof UserDetails)) {
            System.out.println("🚨 Authentication principal is not a UserDetails instance!");
            return null;
        }

        String username = authentication.getName();
        System.out.println("✅ Authenticated user: " + username);

        GymUser user = findByUsername(username);
        if (user == null) {
            System.out.println("🚨 No user found for username: " + username);
            return null;
        }

        System.out.println("✅ UserType found: " + user.getType());
        return user.getType();
    }


    public void delete(String username) {
	    repository.deleteById(username);
   }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        users = repository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        // Check if user is verified
        if (!users.isVerified()) {
            throw new UsernameNotFoundException("Please verify your email before logging in.");
        }

        type = users.getType();
        return users;
    }


   public GymUser findByUsername(String username) {
       return repository.findByUsername(username).orElse(null);
   }
   
   public GymUser getUser()  {
	   return users;
   }
   
   public List<String> getAllMembers() {
	   return repository.findAllMemberUsers();
   }
   
   public List<GymUser> getAllUsers() {
	   return repository.findAll();
   }

    public GymUser findByVerificationToken(String token) {
        return repository.findByVerificationToken(token).orElse(null);
    }

    @Transactional
    public GymUser verifyUserToken(String token) {
        if (token == null || token.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid verification token");
        }

        GymUser user = repository.findByVerificationToken(token)
                .orElseThrow(() -> new IllegalArgumentException("Invalid verification token! Please check your email."));

        if (user.isVerified()) {
            throw new IllegalArgumentException("Your account is already verified! You can log in.");
        }

        user.setVerified(true);
        user.setVerificationToken(null);
        return repository.save(user);
    }

}