<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header2.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback | Your Gym Name</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #C21807;
            --primary-hover: #d43d23;
            --text-color: #2d3748;
            --background-color: #f7fafc;
            --card-background: rgba(255, 255, 255, 0.95);
            --border-radius: 12px;
            --box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            color: var(--text-color);
            line-height: 1.5;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .blur-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: inherit;
            filter: blur(8px);
            z-index: 1;
        }

        .container {
            position: relative;
            z-index: 2;
            background: var(--card-background);
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 600px;
            margin-top: 70px;
        }

        h2 {
            color: var(--text-color);
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.2s ease;
            background: white;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(194, 24, 7, 0.1);
        }

        textarea {
            min-height: 150px;
            resize: vertical;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: center;
        }

        button {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        button.submit {
            background-color: var(--primary-color);
            color: white;
        }

        button.submit:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        button.return {
            background-color: #718096;
            color: white;
        }

        button.return:hover {
            background-color: #4a5568;
            transform: translateY(-1px);
        }

        .alert-success {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #48bb78;
            color: white;
            padding: 1rem 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            z-index: 1000;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .alert-success.show {
            opacity: 1;
            visibility: visible;
        }

        @media (max-width: 640px) {
            .container {
                padding: 1.5rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            .button-group {
                flex-direction: column;
            }

            button {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body background="/images/BGimg.jpg">
<c:url value="/feedback" var="submit"/>
<div class="blur-overlay"></div>
<div class="container">
    <h2>Share Your Feedback</h2>
    <form:form id="feedback_form" method="post" action="${submit}" modelAttribute="feedbackRecord">
        <div class="form-group">
            <label for="userName">Your Name</label>
            <form:input path="userName" id="userName" placeholder="Enter your name"/>
        </div>

        <div class="form-group">
            <label for="content">Your Feedback</label>
            <form:textarea path="content" id="content"
                           placeholder="Please share your experience with us..."/>
        </div>

        <div class="button-group">
            <button type="submit" class="submit" onClick="showAlert();">
                <i class="fas fa-paper-plane"></i>
                Submit Feedback
            </button>
            <button type="button" class="return" onclick="window.history.back();">
                <i class="fas fa-arrow-left"></i>
                Go Back
            </button>
        </div>
    </form:form>
</div>

<div id="success-alert" class="alert-success">
    <i class="fas fa-check-circle"></i>
    Feedback submitted successfully!
</div>

<script>
    function showAlert() {
        var alertBox = document.getElementById('success-alert');
        alertBox.classList.add('show');
        setTimeout(function() {
            alertBox.classList.remove('show');
        }, 3000);
    }
</script>
</body>
</html>