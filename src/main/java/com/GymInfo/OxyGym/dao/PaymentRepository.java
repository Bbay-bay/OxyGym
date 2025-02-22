package com.GymInfo.OxyGym.dao;



import com.GymInfo.OxyGym.bean.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByUserUsername(String username);
    @Query("SELECT COUNT(DISTINCT p.user) FROM Payment p WHERE p.paymentDate > ?1 AND p.isPaid = true")
    long countDistinctUsersByPaymentDateAfterAndIsPaidTrue(LocalDateTime date);

    @Query("SELECT SUM(p.amount) FROM Payment p WHERE p.paymentDate > ?1 AND p.isPaid = true")
    double sumAmountByPaymentDateAfterAndIsPaidTrue(LocalDateTime date);

    @Query("SELECT COALESCE(SUM(p.amount), 0) FROM Payment p WHERE p.paymentDate BETWEEN :start AND :end AND p.isPaid = true")
    Double sumAmountByPaymentDateBetweenAndIsPaidTrue(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

}

