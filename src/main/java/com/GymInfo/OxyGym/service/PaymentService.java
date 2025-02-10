package com.GymInfo.OxyGym.service;

import com.GymInfo.OxyGym.bean.Payment;
import com.GymInfo.OxyGym.bean.GymUser;
import com.GymInfo.OxyGym.bean.PaymentType; // ✅ Updated import
import com.GymInfo.OxyGym.dao.PaymentRepository;
import com.GymInfo.OxyGym.dao.GymUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private GymUserRepository userRepository;

    public Payment processMembershipPayment(String username, double amount, String currency, PaymentType method) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be empty");
        }
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than 0");
        }
        if (currency == null || currency.trim().isEmpty()) {
            throw new IllegalArgumentException("Currency cannot be empty");
        }

        GymUser user = userRepository.findById(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        Payment payment = new Payment(user, amount, currency, method);
        return paymentRepository.save(payment);
    }

    public List<Payment> getUserPayments(String username) {
        return paymentRepository.findByUserUsername(username);
    }
}
