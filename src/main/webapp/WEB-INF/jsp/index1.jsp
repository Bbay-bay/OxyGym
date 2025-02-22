<!-- index1.jsp -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ include file="header1.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="ISO-8859-1">
  <title>GYM Dashboard</title>
  <!-- Include Chart.js for visualizations -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f8f8f8;
    }

    .dashboard-container {
      padding: 20px;
      padding-top: 80px; /* Add this line instead of margin-top */
      margin: 20px;
    }

    .stats-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-5px);
    }

    .stat-card h3 {
      color: #666;
      margin: 0 0 10px 0;
      font-size: 1.1em;
    }

    .stat-card .number {
      color: #C21807;
      font-size: 2em;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .stat-card .trend {
      color: #28a745;
      font-size: 0.9em;
    }

    .charts-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .chart-card {
      background: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .chart-card h3 {
      color: #333;
      margin: 0 0 20px 0;
    }

    canvas {
      width: 100% !important;
      height: 300px !important;
    }

    .quick-actions {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      margin-top: 30px;
    }

    .action-button {
      background-color: #C21807;
      color: white;
      border: none;
      padding: 15px;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .action-button:hover {
      background-color: #a51406;
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <!-- Statistics Cards -->
  <div class="stats-cards">
    <div class="stat-card">
      <h3>Total Users</h3>
      <div class="number">
        <fmt:formatNumber value="${dashboard.totalUsers}" pattern="#,###"/>
      </div>
      <div class="trend">
        <c:if test="${dashboard.userGrowthRate > 0}">&#8593;</c:if>
        <c:if test="${dashboard.userGrowthRate < 0}">&#8595;</c:if>
        <fmt:formatNumber value="${dashboard.userGrowthRate}" pattern="#.#"/>% this month
      </div>
    </div>
    <div class="stat-card">
      <h3>Active Accounts</h3>
      <div class="number">
        <fmt:formatNumber value="${dashboard.activeUsers}" pattern="#,###"/>
      </div>
      <div class="trend">
        <c:if test="${dashboard.userGrowthRate > 0}">&#8593;</c:if>
        <fmt:formatNumber value="${dashboard.userGrowthRate}" pattern="#.#"/>% this month
      </div>
    </div>
    <div class="stat-card">
      <h3>Paid Memberships</h3>
      <div class="number">
        <fmt:formatNumber value="${dashboard.paidMemberships}" pattern="#,###"/>
      </div>
      <div class="trend">
        <c:if test="${dashboard.revenueGrowthRate > 0}">&#8593;</c:if>
        <fmt:formatNumber value="${dashboard.revenueGrowthRate}" pattern="#.#"/>% this month
      </div>
    </div>
    <div class="stat-card">
      <h3>Monthly Revenue</h3>
      <div class="number">$
        <fmt:formatNumber value="${dashboard.monthlyRevenue}" pattern="#,###.##"/>
      </div>
      <div class="trend">
        <c:if test="${dashboard.revenueGrowthRate > 0}">&#8593;</c:if>
        <fmt:formatNumber value="${dashboard.revenueGrowthRate}" pattern="#.#"/>% this month
      </div>
    </div>
  </div>

  <!-- Charts Container -->
  <div class="charts-container">
    <div class="chart-card">
      <h3>User Growth Over Time</h3>
      <canvas id="userGrowthChart"></canvas>
    </div>
    <div class="chart-card">
      <h3>Monthly Revenue</h3>
      <canvas id="revenueChart"></canvas>
    </div>
  </div>
</div>

<script>
  var userGrowthData = [
    <c:forEach items="${dashboard.userGrowthData}" var="data" varStatus="status">
    {
      "month": "${data.month}",
      "count": ${data.count}
    }${!status.last ? ',' : ''}
    </c:forEach>
  ];

  var revenueData = [
    <c:forEach items="${dashboard.revenueData}" var="data" varStatus="status">
    {
      "month": "${data.month}",
      "amount": ${data.amount}
    }${!status.last ? ',' : ''}
    </c:forEach>
  ];

  console.log("? User Growth Data:", userGrowthData);
  console.log("? Revenue Data:", revenueData);

  // Check if data exists before rendering
  if (userGrowthData && userGrowthData.length > 0) {
    const userGrowthChart = new Chart(document.getElementById('userGrowthChart').getContext('2d'), {
      type: 'line',
      data: {
        labels: userGrowthData.map(data => data.month),
        datasets: [{
          label: 'Total Users',
          data: userGrowthData.map(data => data.count),
          borderColor: '#C21807',
          backgroundColor: 'rgba(194, 24, 7, 0.1)',
          fill: true,
          tension: 0.4,
          pointRadius: 6,
          pointHoverRadius: 8,
          pointBackgroundColor: '#C21807'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'top',
          },
          tooltip: {
            mode: 'index',
            intersect: false,
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 1,
              precision: 0
            },
            grid: {
              drawBorder: false
            }
          },
          x: {
            grid: {
              display: false
            }
          }
        }
      }
    });
  } else {
    console.warn("? No user growth data available!");
  }

  if (revenueData && revenueData.length > 0) {
    const revenueChart = new Chart(document.getElementById('revenueChart').getContext('2d'), {
      type: 'bar',
      data: {
        labels: revenueData.map(data => data.month),
        datasets: [{
          label: 'Monthly Revenue ($)',
          data: revenueData.map(data => data.amount),
          backgroundColor: 'rgba(255, 215, 0, 0.6)',
          borderColor: '#FFD700',
          borderWidth: 1,
          borderRadius: 5,
          hoverBackgroundColor: 'rgba(255, 215, 0, 0.8)'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'top',
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                return '$ ' + context.raw.toFixed(2);
              }
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              callback: function(value) {
                return '$' + value.toFixed(2);
              }
            },
            grid: {
              drawBorder: false
            }
          },
          x: {
            grid: {
              display: false
            }
          }
        }
      }
    });
  } else {
    console.warn("? No revenue data available!");
  }
</script>

</body>
</html>