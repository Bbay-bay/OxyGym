package com.GymInfo.OxyGym.controller;

import com.GymInfo.OxyGym.bean.Payment;
import com.GymInfo.OxyGym.bean.PaymentType;
import com.GymInfo.OxyGym.service.PaymentService;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/stripe")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

    private static final String STRIPE_SECRET_KEY = "sk_test_51QpWQoLPlhJt7p2osuBIHB9XmQrK6raD7lZE2OlyL8CfOBxoPt3se75pnzhyURAxDmDvb42Y6NF03QENd8tAWs3q00eVajDQ5w"; // Replace with your Stripe secret key

    @PostMapping("/create-payment-intent")
    public Map<String, String> createPaymentIntent(@RequestBody Map<String, String> payload) {
        long amount = Long.parseLong(payload.get("amount")); // Extract amount from JSON
        String currency = payload.get("currency");

        Map<String, String> response = new HashMap<>();
        try {
            com.stripe.Stripe.apiKey = STRIPE_SECRET_KEY;

            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                    .setAmount(amount * 100L) // Convert to cents
                    .setCurrency(currency)
                    .build();

            PaymentIntent intent = PaymentIntent.create(params);
            response.put("clientSecret", intent.getClientSecret());
        } catch (StripeException e) {
            response.put("error", e.getMessage());
        }
        return response;
    }


    @PostMapping("/confirm-payment")
    public Payment confirmPayment(@RequestBody Map<String, Object> payload) {
        logger.info("Received payment confirmation request: {}", payload);
        try {
            String username = (String) payload.get("username");
            double amount = ((Number) payload.get("amount")).doubleValue();
            String currency = (String) payload.get("currency");

            Payment payment = paymentService.processMembershipPayment(username, amount, currency, PaymentType.ONLINE);
            logger.info("Payment processed successfully: {}", payment.getId());
            return payment;
        } catch (Exception e) {
            logger.error("Error processing payment: ", e);
            throw e;
        }
    }

    @GetMapping("/user-payment/{username}")
    public ResponseEntity<?> getUserPaymentDetails(@PathVariable String username) {
        try {
            List<Payment> payments = paymentService.getUserPayments(username);
            if (payments.isEmpty()) {
                return ResponseEntity.ok(Collections.singletonMap("message", "No payment found for user: " + username));
            }
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            logger.error("Error fetching payment details for user: " + username, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching payment details");
        }
    }


}
