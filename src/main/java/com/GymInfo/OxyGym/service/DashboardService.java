// DashboardService.java
package com.GymInfo.OxyGym.service;

import com.GymInfo.OxyGym.bean.GymUser;
import com.GymInfo.OxyGym.bean.Payment;
import com.GymInfo.OxyGym.dto.DashboardDTO;
import com.GymInfo.OxyGym.dao.GymUserRepository;
import com.GymInfo.OxyGym.dao.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.*;

@Service
public class DashboardService {

    @Autowired
    private GymUserRepository userRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    public DashboardDTO getDashboardData() {
        DashboardDTO dashboard = new DashboardDTO();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime monthAgo = now.minusMonths(1);

        // Get total users
        long totalUsers = userRepository.count();

        // Get active users (verified users)
        long activeUsers = userRepository.countByVerifiedTrue();

        // Get paid memberships (users who made payments this month)
        long paidMemberships = paymentRepository.countDistinctUsersByPaymentDateAfterAndIsPaidTrue(monthAgo);

        // Calculate monthly revenue
        double monthlyRevenue = paymentRepository.sumAmountByPaymentDateAfterAndIsPaidTrue(monthAgo);

        // Calculate growth rates
        double previousMonthRevenue = paymentRepository.sumAmountByPaymentDateBetweenAndIsPaidTrue(
                monthAgo.minusMonths(1), monthAgo);
        double revenueGrowthRate = calculateGrowthRate(previousMonthRevenue, monthlyRevenue);

        long previousMonthUsers = userRepository.countByCreatedDateBefore(monthAgo);
        double userGrowthRate = calculateGrowthRate(previousMonthUsers, totalUsers);

        // Get historical data for charts
        List<Map<String, Object>> userGrowthData = getLast6MonthsUserGrowth();
        List<Map<String, Object>> revenueData = getLast6MonthsRevenue();

        // Set all values
        dashboard.setTotalUsers(totalUsers);
        dashboard.setActiveUsers(activeUsers);
        dashboard.setPaidMemberships(paidMemberships);
        dashboard.setMonthlyRevenue(monthlyRevenue);
        dashboard.setUserGrowthRate(userGrowthRate);
        dashboard.setRevenueGrowthRate(revenueGrowthRate);
        dashboard.setUserGrowthData(userGrowthData);
        dashboard.setRevenueData(revenueData);

        return dashboard;
    }

    private double calculateGrowthRate(double previous, double current) {
        if (previous == 0) return 0;
        return ((current - previous) / previous) * 100;
    }

    private List<Map<String, Object>> getLast6MonthsUserGrowth() {
        List<Map<String, Object>> result = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();

        for (int i = 5; i >= 0; i--) {
            LocalDateTime monthStart = now.minusMonths(i).withDayOfMonth(1).withHour(0).withMinute(0);
            LocalDateTime monthEnd = YearMonth.from(monthStart).atEndOfMonth().atTime(23, 59, 59);

            long userCount = userRepository.countByCreatedDateBetween(monthStart, monthEnd);

            Map<String, Object> monthData = new HashMap<>();
            monthData.put("month", monthStart.getMonth().toString().substring(0, 3));
            monthData.put("count", userCount);
            result.add(monthData);
        }

        return result;
    }

    private List<Map<String, Object>> getLast6MonthsRevenue() {
        List<Map<String, Object>> result = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();

        for (int i = 5; i >= 0; i--) {
            LocalDateTime monthStart = now.minusMonths(i).withDayOfMonth(1).withHour(0).withMinute(0);
            LocalDateTime monthEnd = YearMonth.from(monthStart).atEndOfMonth().atTime(23, 59, 59);

            double revenue = paymentRepository.sumAmountByPaymentDateBetweenAndIsPaidTrue(monthStart, monthEnd);

            Map<String, Object> monthData = new HashMap<>();
            monthData.put("month", monthStart.getMonth().toString().substring(0, 3));
            monthData.put("amount", revenue);
            result.add(monthData);
        }

        return result;
    }
}
