package com.GymInfo.OxyGym.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.GymInfo.OxyGym.bean.GymUser;


public interface GymUserRepository extends JpaRepository<GymUser, String> {
 Optional<GymUser> findByUsername(String username);
 Optional<GymUser> findByVerificationToken(String verificationToken);
 @Query("SELECT username from GymUser where type='Member'")
 public List<String> findAllMemberUsers();

 long countByVerifiedTrue();
 long countByCreatedDateBefore(LocalDateTime date);
 long countByCreatedDateBetween(LocalDateTime start, LocalDateTime end);
}