package com.GymInfo.OxyGym.bean;


import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "gym_user_id", nullable = false)
    private GymUser user;

    private double amount;
    private String currency;

    @Enumerated(EnumType.STRING)  // ✅ Uses PaymentType instead of PaymentMethod
    private PaymentType method;

    private LocalDateTime paymentDate;
    private boolean isPaid;

    public Payment() {}

    public Payment(GymUser user, double amount, String currency, PaymentType method) { // ✅ Changed parameter type
        this.user = user;
        this.amount = amount;
        this.currency = currency;
        this.paymentDate = LocalDateTime.now();
        this.method = method;
        this.isPaid = true;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public GymUser getUser() {
        return user;
    }

    public void setUser(GymUser user) {
        this.user = user;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public PaymentType getMethod() {
        return method;
    }

    public void setMethod(PaymentType method) {
        this.method = method;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }
}
