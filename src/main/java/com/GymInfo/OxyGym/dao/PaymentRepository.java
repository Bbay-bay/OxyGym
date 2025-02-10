package com.GymInfo.OxyGym.dao;



import com.GymInfo.OxyGym.bean.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByUserUsername(String username);
}

