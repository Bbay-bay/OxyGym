package com.GymInfo.OxyGym.dto;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class DashboardDTO implements Serializable {
    // Statistics fields
    private long totalUsers;
    private long activeUsers;
    private long paidMemberships;
    private double monthlyRevenue;

    // Growth rate fields
    private double userGrowthRate;
    private double revenueGrowthRate;

    // Chart data fields
    private List<Map<String, Object>> userGrowthData;
    private List<Map<String, Object>> revenueData;

    // Default constructor
    public DashboardDTO() {}

    // Getters and Setters
    public long getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(long totalUsers) {
        this.totalUsers = totalUsers;
    }

    public long getActiveUsers() {
        return activeUsers;
    }

    public void setActiveUsers(long activeUsers) {
        this.activeUsers = activeUsers;
    }

    public long getPaidMemberships() {
        return paidMemberships;
    }

    public void setPaidMemberships(long paidMemberships) {
        this.paidMemberships = paidMemberships;
    }

    public double getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(double monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public double getUserGrowthRate() {
        return userGrowthRate;
    }

    public void setUserGrowthRate(double userGrowthRate) {
        this.userGrowthRate = userGrowthRate;
    }

    public double getRevenueGrowthRate() {
        return revenueGrowthRate;
    }

    public void setRevenueGrowthRate(double revenueGrowthRate) {
        this.revenueGrowthRate = revenueGrowthRate;
    }

    public List<Map<String, Object>> getUserGrowthData() {
        return userGrowthData;
    }

    public void setUserGrowthData(List<Map<String, Object>> userGrowthData) {
        this.userGrowthData = userGrowthData;
    }

    public List<Map<String, Object>> getRevenueData() {
        return revenueData;
    }

    public void setRevenueData(List<Map<String, Object>> revenueData) {
        this.revenueData = revenueData;
    }
}