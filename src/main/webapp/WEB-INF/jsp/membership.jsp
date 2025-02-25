<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GYM Info Club - Membership</title>
    <script src="https://js.stripe.com/v3/"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            min-height: 100vh;
        }

        .navbar {
            background-color: #C21807;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            box-shadow: 2px 1px 2px #eee;
            position: fixed;
            top: 0;
            width: 100%;
            height: 70px;
            z-index: 1000;
            box-sizing: border-box;
        }

        .navbar img {
            max-height: 60px;
            max-width: 120px;
            object-fit: contain;
            margin-left: 50px;
            margin-right: 50px;
        }

        .navbar div {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-item {
            padding: 10px 10px;
            color: white;
            cursor: pointer;
            position: relative;
            text-decoration: none;
        }

        .navbar-item.has-subnav::after {
            content: '\25BC';
            margin-left: 5px;
            font-size: 12px;
        }

        .navbar-item .subnav {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #C21807;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
            min-width: 160px;
        }

        .navbar-item:hover .subnav {
            display: block;
        }

        .subnav-item {
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            display: block;
            white-space: nowrap;
        }

        .subnav-item:hover {
            background-color: #fff;
            color: #C21807;
        }

        .main-container {
            margin-top: 90px;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: calc(100vh - 90px);
        }

        .membership-container {
            max-width: 800px;
            width: 100%;
            background: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            padding: 30px;
            box-sizing: border-box;
        }

        .membership-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .membership-header h1 {
            color: #C21807;
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .membership-header p {
            color: #666;
            font-size: 1.1em;
        }

        .plans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .plan {
            background: #f8f9fa;
            border: 2px solid #eee;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .plan:hover {
            border-color: #C21807;
            transform: translateY(-5px);
        }

        .plan.selected {
            border-color: #C21807;
            background-color: #fff5f5;
        }

        .plan-icon {
            font-size: 2em;
            margin-bottom: 15px;
        }

        .plan-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .plan-price {
            font-size: 1.8em;
            color: #C21807;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .plan-features {
            list-style: none;
            padding: 0;
            margin: 0 0 20px 0;
            text-align: left;
        }

        .plan-features li {
            padding: 5px 0;
            color: #666;
        }

        .plan-features li::before {
            content: "✓";
            color: #C21807;
            margin-right: 8px;
        }

        .profile-icon {
            background-color: #ffffff;
            color: #C21807;
            border: 2px solid #C21807;
            padding: 12px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 20px;
            margin-right: 50px;
            font-size: 20px;
            text-align: center;
            line-height: 1;
        }

        .profile-icon:hover {
            background-color: #C21807;
            color: #ffffff;
        }

        #profileSubnav {
            background-color: #C21807;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: left;
            z-index: 1;
        }

        .payment-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .payment-modal.show {
            opacity: 1;
            visibility: visible;
        }

        .payment-modal-content {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            text-align: center;
            max-width: 400px;
            width: 90%;
            transform: scale(0.7);
            transition: transform 0.3s ease-in-out;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .payment-modal.show .payment-modal-content {
            transform: scale(1);
        }

        .status-icon {
            margin-bottom: 1.5rem;
        }

        .icon-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            font-size: 2rem;
        }

        .success .icon-circle {
            background-color: #ecfdf5;
        }

        .error .icon-circle {
            background-color: #fef2f2;
        }

        .success-icon {
            color: #059669;
        }

        .error-icon {
            color: #dc2626;
        }

        .status-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #111827;
        }

        .status-message {
            color: #6b7280;
            margin-bottom: 1.5rem;
        }

        .modal-button {
            background-color: #C21807;
            color: white;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .modal-button:hover {
            background-color: #a51406;
        }

        .hidden {
            display: none;
        }

        #card-element {
            padding: 15px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            background: #f9fafb;
            margin: 20px 0;
            transition: border-color 0.3s ease;
        }

        #card-element:hover {
            border-color: #C21807;
        }

        #card-errors {
            color: #dc2626;
            font-size: 0.875rem;
            margin-top: 8px;
        }

        .btn {
            background-color: #C21807;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
            max-width: 300px;
            margin: 20px auto;
            display: block;
        }

        .btn:hover {
            background-color: #a51406;
        }

        .btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
        }



        #current-plan {
            margin-top: 20px;
            text-align: center;
        }

        #current-plan .plan {
            background: #f8f9fa;
            border: 2px solid #C21807;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            max-width: 400px;
            margin: 0 auto;
        }

        #current-plan .plan-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #C21807;
            margin-bottom: 10px;
        }

        #current-plan .plan-price {
            font-size: 2em;
            color: #C21807;
            font-weight: bold;
            margin-bottom: 15px;
        }

        #current-plan .plan-features {
            list-style: none;
            padding: 0;
            margin: 0 0 20px 0;
            text-align: left;
        }

        #current-plan .plan-features li {
            padding: 5px 0;
            color: #666;
        }

        #current-plan .plan-features li::before {
            content: "✓";
            color: #C21807;
            margin-right: 8px;
        }

        #loading-spinner {
            text-align: center;
            margin: 20px 0;
            font-size: 1.2em;
            color: #C21807;
        }

        #loading-spinner .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #C21807;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
        }

        #current-plan {
            margin-top: 20px;
            text-align: center;
        }

        #current-plan .plan {
            background: #f8f9fa;
            border: 2px solid #C21807;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            max-width: 400px;
            margin: 0 auto;
        }

        #current-plan .plan-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #C21807;
            margin-bottom: 10px;
        }

        #current-plan .plan-price {
            font-size: 2em;
            color: #C21807;
            font-weight: bold;
            margin-bottom: 15px;
        }

        #current-plan .plan-features {
            list-style: none;
            padding: 0;
            margin: 0 0 20px 0;
            text-align: left;
        }

        #current-plan .plan-features li {
            padding: 5px 0;
            color: #666;
        }

        #current-plan .plan-features li::before {
            content: "✓";
            color: #C21807;
            margin-right: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<!-- Include the navbar -->
<div class="navbar">
    <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Gym Logo">
    <div>
        <div class="navbar-item">
            <a href="/index" class="navbar-item">Home</a>
        </div>
        <div class="navbar-item has-subnav">
            Slot Booking
            <div class="subnav">
                <a href="/slots2" class="subnav-item">View Slots</a>
                <a href="/booked" class="subnav-item">View Booking</a>
            </div>
        </div>
        <div class="navbar-item">
            <a href="/membership" class="navbar-item">Membership</a>
        </div>
        <div class="navbar-item">
            <a href="/feedback" class="navbar-item">Feedback</a>
        </div>
        <div class="navbar-item">
            <a href="/about" class="navbar-item">About</a>
        </div>
        <div class="navbar-item">
            <a href="/contactUs" class="navbar-item">Contact Us</a>
        </div>
        <div class="navbar-item has-subnav">
            <span class="profile-icon" id="profileIcon">&#128100;</span>
            <div class="subnav" id="profileSubnav">
                <div class="profile-pic">&#128100;</div>
                <div class="profile-name">${currentUser.username}</div>
                <div class="profile-email">${currentUser.email}</div>
                <div class="profile-info">First Name: <span>${currentUser.firstName}</span></div>
                <div class="profile-info">Last Name: <span>${currentUser.lastName}</span></div>
                <div class="profile-info">Type: <span>${currentUser.type}</span></div>
                <a href="/logout" class="subnav-item">Log Out</a>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-container">
    <div class="membership-container">
        <div class="membership-header">
            <h1>Choose Your Membership Plan</h1>
            <p>Transform your life with our flexible membership options</p>
        </div>
        <div class="plans-grid">
            <div class="plan" onclick="selectPlan(30)">
                <div class="plan-icon">
                    <i class="fas fa-dumbbell"></i>
                </div>
                <div class="plan-title">1 Month</div>
                <div class="plan-price">$30</div>
                <ul class="plan-features">
                    <li> Full gym access</li>
                    <li> Basic fitness assessment</li>
                    <li> Locker access</li>
                </ul>
            </div>

            <div class="plan" onclick="selectPlan(80)">
                <div class="plan-icon">
                    <i class="fas fa-fire"></i>
                </div>
                <div class="plan-title">3 Months</div>
                <div class="plan-price">$80</div>
                <ul class="plan-features">
                    <li> All basic features</li>
                    <li> 1 Personal training session</li>
                    <li> Nutrition consultation</li>
                </ul>
            </div>

            <div class="plan" onclick="selectPlan(150)">
                <div class="plan-icon">
                    <i class="fas fa-running"></i>
                </div>
                <div class="plan-title">6 Months</div>
                <div class="plan-price">$150</div>
                <ul class="plan-features">
                    <li> All previous features</li>
                    <li> 3 Personal training sessions</li>
                    <li> Monthly progress tracking</li>
                </ul>
            </div>

            <div class="plan" onclick="selectPlan(280)">
                <div class="plan-icon">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="plan-title">1 Year</div>
                <div class="plan-price">$280</div>
                <ul class="plan-features">
                    <li> All premium features</li>
                    <li> 6 Personal training sessions</li>
                    <li> Priority booking</li>
                </ul>
            </div>
        </div>

        <!-- Payment Elements -->
        <div id="payment-form" class="hidden">
            <div id="card-element"></div>
            <div id="card-errors" class="payment-error"></div>
            <button class="btn" id="payButton">Pay Now</button>
        </div>


        <!-- Payment Status Modal -->
        <div id="paymentStatusModal" class="payment-modal hidden">
            <div class="payment-modal-content">
                <div class="status-icon">
                    <div class="icon-circle">
                        <i class="fas fa-check success-icon"></i>
                        <i class="fas fa-times error-icon"></i>
                    </div>
                </div>
                <h2 id="statusTitle" class="status-title"></h2>
                <p id="statusMessage" class="status-message"></p>
                <button onclick="closePaymentModal()" class="modal-button">OK</button>
            </div>
        </div>

        <!-- Current Plan Section -->
        <div id="current-plan" class="hidden">
            <div class="membership-header">
                <h1>Your Current Membership Plan</h1>
                <p>Thank you for being a valued member!</p>
            </div>
            <div class="plan">
                <div class="plan-icon">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="plan-title" id="current-plan-title"></div>
                <div class="plan-price" id="current-plan-price"></div>
                <ul class="plan-features" id="current-plan-features"></ul>
            </div>
        </div>

        <div id="loading-spinner" class="hidden">
            <span class="spinner"></span> Loading...
        </div>

    </div>
</div>

<!-- Add FontAwesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">



<script>

    let selectedAmount = 0;
    const stripe = Stripe("Replace_with_your_stripe_api_key"); <!--############################################################################-->
    let elements;
    let paymentElement;

    // Main function to check membership status on page load
    async function checkMembershipStatus() {
        const username = "${currentUser.username}";
        const plansGrid = document.querySelector('.plans-grid');
        const paymentForm = document.getElementById('payment-form');
        const currentPlanSection = document.getElementById('current-plan');
        const membershipHeader = document.querySelector('.membership-header');
        const loadingSpinner = document.getElementById('loading-spinner');

        // Show loading spinner
        loadingSpinner.classList.remove('hidden');

        try {
            const response = await fetch(`/api/stripe/user-payment/${username}`);
            if (!response.ok) {
                throw new Error('Failed to fetch payment details');
            }

            const data = await response.json();
            console.log("Fetched payment data:", data);

            if (data.message === "No payment found") {
                // No active membership - show plans and payment form
                plansGrid.style.display = 'grid';
                paymentForm.classList.remove('hidden');
                currentPlanSection.classList.add('hidden');
                membershipHeader.style.display = 'block'; // Show the "Choose Your Membership Plan" header
            } else {
                // Active membership - show current plan details
                plansGrid.style.display = 'none';
                paymentForm.classList.add('hidden');
                membershipHeader.style.display = 'none'; // Hide the "Choose Your Membership Plan" header

                const latestPayment = data[0]; // Get the latest payment
                const paymentDate = new Date(latestPayment.paymentDate);
                const membershipEndDate = calculateMembershipEndDate(paymentDate, latestPayment.amount);

                updateCurrentPlanDisplay(latestPayment, membershipEndDate);
                showMembershipStatusMessage(membershipEndDate);
            }
        } catch (error) {
            console.error("Error checking membership status:", error);
            // Fallback: Show plans and payment form
            plansGrid.style.display = 'grid';
            paymentForm.classList.remove('hidden');
            currentPlanSection.classList.add('hidden');
            membershipHeader.style.display = 'block'; // Show the "Choose Your Membership Plan" header
        } finally {
            // Hide loading spinner
            loadingSpinner.classList.add('hidden');
        }
    }

    function calculateMembershipEndDate(startDate, amount) {
        if (!(startDate instanceof Date) || isNaN(startDate)) {
            console.error('Invalid start date:', startDate);
            startDate = new Date(); // Fallback to current date
        }

        const monthsMap = {
            30: 1,    // 1 month plan
            80: 3,    // 3 months plan
            150: 6,   // 6 months plan
            280: 12   // 1 year plan
        };

        const months = monthsMap[amount] || 0;
        const endDate = new Date(startDate);
        endDate.setMonth(endDate.getMonth() + months);
        return endDate;
    }

    function updateCurrentPlanDisplay(payment, endDate) {
        const currentPlanSection = document.getElementById('current-plan');
        const planTitle = document.getElementById('current-plan-title');
        const planPrice = document.getElementById('current-plan-price');
        const planFeatures = document.getElementById('current-plan-features');

        if (!currentPlanSection || !planTitle || !planPrice || !planFeatures) {
            console.error('Required DOM elements not found');
            return;
        }

        try {
            const amount = parseFloat(payment.amount);
            if (isNaN(amount)) {
                throw new Error('Invalid payment amount');
            }

            // Ensure we have a valid end date
            let membershipEndDate = endDate;
            if (!membershipEndDate || !(membershipEndDate instanceof Date) || isNaN(membershipEndDate)) {
                const startDate = new Date(payment.paymentDate);
                membershipEndDate = calculateMembershipEndDate(startDate, amount);
            }

            // Format the end date with explicit options
            const formattedEndDate = membershipEndDate.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                timeZone: 'UTC'  // Ensure consistent timezone handling
            });

            // Get plan details
            const planDetails = getPlanDetails(amount);

            // Update display elements
            planTitle.textContent = planDetails.title;
            planPrice.textContent = `$${amount}`;

            // Clear and rebuild features list
            planFeatures.innerHTML = '';

            // Add membership expiration date as first feature
            const expirationLi = document.createElement('li');
            expirationLi.textContent = `Membership valid until: ${formattedEndDate}`;
            planFeatures.appendChild(expirationLi);

            // Add remaining features
            planDetails.features.forEach(feature => {
                const li = document.createElement('li');
                li.textContent = feature;
                planFeatures.appendChild(li);
            });

            currentPlanSection.classList.remove('hidden');

            // Also update the status message
            showMembershipStatusMessage(membershipEndDate);

        } catch (error) {
            console.error('Error updating plan display:', error);
            // Add user-friendly error handling here
        }
    }

    function showMembershipStatusMessage(endDate) {
        if (!endDate || !(endDate instanceof Date) || isNaN(endDate)) {
            console.error('Invalid end date provided:', endDate);
            return;
        }

        const today = new Date();
        const daysRemaining = Math.ceil((endDate - today) / (1000 * 60 * 60 * 24));

        // Format the message with the actual number of days
        let title, message;
        if (daysRemaining > 30) {
            title = 'Active Membership';
            message = `Your membership is active with ${daysRemaining} days remaining.`;
        } else if (daysRemaining > 0) {
            title = 'Membership Expiring Soon';
            message = `Your membership will expire in ${daysRemaining} days. Consider renewing soon!`;
        } else {
            title = 'Membership Expired';
            message = 'Your membership has expired. Please renew to continue enjoying our services.';
        }

        // Update modal content
        const modalTitle = document.querySelector('.membership-header h1');
        const modalMessage = document.querySelector('.membership-header p');
        if (modalTitle) modalTitle.textContent = title;
        if (modalMessage) modalMessage.textContent = message;

        showPaymentModal(true, title, message);
    }

    function getPlanDetails(amount) {
        const plans = {
            30: {
                title: "1 Month Plan",
                features: ["Full gym access", "Basic fitness assessment", "Locker access"]
            },
            80: {
                title: "3 Months Plan",
                features: ["All basic features", "1 Personal training session", "Nutrition consultation"]
            },
            150: {
                title: "6 Months Plan",
                features: ["All previous features", "3 Personal training sessions", "Monthly progress tracking"]
            },
            280: {
                title: "1 Year Plan",
                features: ["All premium features", "6 Personal training sessions", "Priority booking"]
            }
        };

        if (!plans[amount]) {
            console.error(`❌ No plan details found for amount: ${amount}`);
            return { title: "Unknown Plan", features: ["No details available"] };
        }

        return plans[amount];
    }


    // Payment modal and related functions
    function showPaymentModal(isSuccess, title, message, redirectUrl = null) {
        const modal = document.getElementById('paymentStatusModal');
        const modalContent = modal.querySelector('.payment-modal-content');
        const titleElement = document.getElementById('statusTitle');
        const messageElement = document.getElementById('statusMessage');
        const iconCircle = modal.querySelector('.icon-circle');

        titleElement.textContent = title;
        messageElement.textContent = message;

        modalContent.classList.remove('success', 'error');
        modalContent.classList.add(isSuccess ? 'success' : 'error');

        iconCircle.innerHTML = '';
        const icon = document.createElement('i');
        icon.className = isSuccess ? 'fas fa-check success-icon' : 'fas fa-times error-icon';
        iconCircle.appendChild(icon);

        modal.classList.remove('hidden');
        setTimeout(() => modal.classList.add('show'), 10);

        modal.dataset.redirectUrl = redirectUrl || '';
    }

    function closePaymentModal() {
        const modal = document.getElementById('paymentStatusModal');
        modal.classList.remove('show');

        setTimeout(() => {
            modal.classList.add('hidden');
            const redirectUrl = modal.dataset.redirectUrl;
            if (redirectUrl) {
                window.location.href = redirectUrl;
            }
        }, 300);
    }

    // Payment form logic continues here...

    function selectPlan(amount) {
        document.querySelectorAll('.plan').forEach(plan => plan.classList.remove('selected'));
        event.currentTarget.classList.add('selected');

        selectedAmount = amount;
        document.getElementById("payment-form").classList.remove("hidden");

        if (!elements) {
            elements = stripe.elements();
            const style = {
                base: {
                    fontSize: '16px',
                    color: '#32325d',
                    '::placeholder': {
                        color: '#aab7c4'
                    }
                },
                invalid: {
                    color: '#fa755a',
                    iconColor: '#fa755a'
                }
            };

            paymentElement = elements.create('card', {style});
            paymentElement.mount('#card-element');
        }
    }

    async function createPaymentIntent(amount) {
        try {
            if (!amount || amount <= 0) {
                throw new Error("Invalid amount. Please select a membership plan.");
            }

            const response = await fetch('/api/stripe/create-payment-intent', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    amount: amount * 100,
                    currency: 'usd'
                })
            });

            if (!response.ok) {
                const errorDetails = await response.json();
                throw new Error(errorDetails.error || 'Failed to create payment intent.');
            }

            const data = await response.json();
            if (!data.clientSecret) {
                throw new Error("Invalid response from server. Please try again.");
            }

            return data;
        } catch (error) {
            console.error("Payment Intent Error:", error.message);
            showPaymentModal(false, 'Error', error.message);
            return null;
        }
    }

    // Initialize membership status check
    document.addEventListener("DOMContentLoaded", () => {
        checkMembershipStatus();
    });

    document.getElementById('payButton').addEventListener('click', async (e) => {
        e.preventDefault();
        const button = e.target;
        button.disabled = true;
        button.innerHTML = '<span class="spinner"></span>Processing...';

        try {
            const paymentIntent = await createPaymentIntent(selectedAmount);
            if (!paymentIntent) {
                throw new Error("Failed to create payment intent");
            }

            const { error } = await stripe.confirmCardPayment(paymentIntent.clientSecret, {
                payment_method: {
                    card: paymentElement,
                }
            });

            if (error) {
                showPaymentModal(false, 'Payment Failed', error.message);
                button.disabled = false;
                button.innerHTML = 'Pay Now';
            } else {
                try {
                    const response = await fetch("/api/stripe/confirm-payment", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({
                            username: "${currentUser.username}",
                            amount: selectedAmount,
                            currency: "usd"
                        })
                    });

                    if (!response.ok) {
                        throw new Error('Payment confirmation failed');
                    }

                    showPaymentModal(
                        true,
                        'Payment Successful!',
                        'Welcome to the Gym Membership.',
                        '/index'
                    );
                } catch (error) {
                    showPaymentModal(
                        false,
                        'Registration Failed',
                        'Payment confirmed but membership registration failed. Please contact support.'
                    );
                }
            }
        } catch (error) {
            showPaymentModal(
                false,
                'Error',
                'An unexpected error occurred. Please try again.'
            );
        } finally {
            button.disabled = false;
            button.innerHTML = 'Pay Now';
        }
    });

</script>
</body>
</html>
