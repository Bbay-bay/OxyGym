<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>OxyGym - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            position: relative;
        }

        .blur-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: inherit;
            filter: blur(8px);
            z-index: 1;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 4rem;
        }

        .logo span:first-child {
            color: #C21807;
        }

        .logo span:last-child {
            color: #2d3436;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            width: 868px;
            max-width: 95%;
            min-height: 500px;
            z-index: 2;
        }

        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
            padding: 2rem;
        }

        .sign-in-container {
            left: 0;
            width: 50%;
            z-index: 2;
            background: white;
        }

        form {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 3rem;
            height: 100%;
            text-align: center;
        }

        .input-group {
            position: relative;
            width: 100%;
            margin-bottom: 1.5rem;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            background-color: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #C21807;
            background-color: #fff;
        }

        .password-container {
            position: relative;
            width: 100%;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            transition: color 0.3s ease;
        }

        .error-message, .success-message {
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            width: 100%;
            margin: 10px 0;
            animation: fadeIn 0.5s ease;
            display: none;
        }

        .error-message {
            background-color: #fff5f5;
            color: #c53030;
            border: 1px solid #feb2b2;
        }

        .error-message.show, .success-message.show {
            display: block;
        }

        button {
            border-radius: 30px;
            border: none;
            background: #C21807;
            color: white;
            font-size: 14px;
            font-weight: 500;
            padding: 14px 50px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(194, 24, 7, 0.2);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(194, 24, 7, 0.3);
        }

        .overlay-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            z-index: 100;
        }

        .overlay {
            background: #C21807;
            color: white;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .overlay-panel {
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 40px;
            text-align: center;
            top: 0;
            height: 100%;
            width: 50%;
            transform: translateX(0);
            transition: transform 0.6s ease-in-out;
        }

        .overlay-panel h1 {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 2rem;
        }

        .overlay-panel p {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 3rem;
            opacity: 0.9;
        }

        .overlay-right {
            right: 0;
            transform: translateX(0);
        }

        button.sign-up {
            background: transparent;
            border: 2px solid white;
            margin-top: 1rem;
        }

        button.sign-up:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body background="/images/BGimg.jpg">
<div class="blur-overlay"></div>
<div class="container">
    <div class="form-container sign-in-container">
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="logo">
                <span>Oxy</span><span>Gym</span>
            </div>

            <div class="input-group">
                <input type="text" name="username" placeholder="Username" required/>
            </div>

            <div class="input-group">
                <div class="password-container">
                    <input type="password" name="password" id="password" placeholder="Password" required/>
                    <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                </div>
            </div>

            <div id="unverifiedError" class="error-message">
                Your email is not verified. Please check your inbox and verify your account.
            </div>

            <div id="invalidCredentials" class="error-message">
                Invalid username or password. Please try again.
            </div>

            <div id="successMessage" class="success-message"></div>

            <button type="submit">Sign In</button>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-right">
                <h1>Welcome to OxyGym!</h1>
                <p>Enter your personal details and start your fitness journey with us</p>
                <button class="sign-up" onclick="window.location.href='${pageContext.request.contextPath}/register'">Sign Up</button>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById('togglePassword').addEventListener('click', function () {
        const passwordField = document.getElementById('password');
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
    });

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.has('unverified')) {
            document.getElementById('unverifiedError').classList.add('show');
        }

        if (urlParams.has('error') && !urlParams.has('unverified')) {
            document.getElementById('invalidCredentials').classList.add('show');
        }

        const message = '${message}';
        if (message) {
            const successDiv = document.getElementById('successMessage');
            successDiv.textContent = message;
            successDiv.classList.add('show');
        }
    };
</script>
</body>
</html>