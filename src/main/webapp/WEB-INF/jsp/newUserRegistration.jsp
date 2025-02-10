<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 <title>OxyGym - Sign Up</title>
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
   margin-bottom: 2rem;
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
   min-height: 600px;
   z-index: 2;
  }

  .form-container {
   position: absolute;
   top: 0;
   height: 100%;
   transition: all 0.6s ease-in-out;
   padding: 2rem;
  }

  .sign-up-container {
   right: 0;
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
   margin-bottom: 1rem;
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
   margin-bottom: 1rem;
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

  #message {
   color: #dc3545;
   font-size: 0.875rem;
   margin-top: 0.5rem;
   margin-bottom: 1rem;
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

  .welcome-container {
   position: absolute;
   top: 0;
   left: 0;
   width: 50%;
   height: 100%;
   overflow: hidden;
   z-index: 100;
   background: #C21807;
   color: white;
   display: flex;
   align-items: center;
   justify-content: center;
   padding: 2rem;
  }

  .welcome-content {
   text-align: center;
  }

  .welcome-content h1 {
   font-size: 2.5rem;
   font-weight: 600;
   margin-bottom: 2rem;
  }

  .welcome-content p {
   font-size: 1.1rem;
   line-height: 1.6;
   margin-bottom: 3rem;
   opacity: 0.9;
  }

  button.sign-in {
   background: transparent;
   border: 2px solid white;
   margin-top: 1rem;
  }

  button.sign-in:hover {
   background: rgba(255, 255, 255, 0.1);
  }
 </style>
</head>
<body background="/images/BGimg.jpg">
<div class="blur-overlay"></div>
<div class="container">
 <div class="welcome-container">
  <div class="welcome-content">
   <h1>Welcome Back!</h1>
   <p>Already have an account? Sign in to continue your fitness journey with us</p>
   <button class="sign-in" onclick="window.location.href='${pageContext.request.contextPath}/loginpage'">Sign In</button>
  </div>
 </div>
 <div class="form-container sign-up-container">
  <form id="registration_form" method="post" action="${pageContext.request.contextPath}/register">
   <div class="logo">
    <span>Oxy</span><span>Gym</span>
   </div>

   <div class="input-group">
    <input type="text" name="firstName" placeholder="First Name" required/>
   </div>

   <div class="input-group">
    <input type="text" name="lastName" placeholder="Last Name" required/>
   </div>

   <div class="input-group">
    <input type="email" name="email" placeholder="Email" required/>
   </div>

   <div class="input-group">
    <input type="text" name="username" placeholder="Username" required/>
   </div>

   <div class="password-container">
    <input type="password" id="pass1" name="password" placeholder="Password" required/>
    <i class="fas fa-eye toggle-password" id="togglePassword1"></i>
   </div>

   <div class="password-container">
    <input type="password" id="pass2" placeholder="Confirm Password" required/>
    <i class="fas fa-eye toggle-password" id="togglePassword2"></i>
   </div>

   <div id="message"></div>

   <input type="hidden" name="type" value="Member">
   <button type="submit" onclick="return passwordCheck();">Sign Up</button>
  </form>
 </div>
</div>
<script>
 function passwordCheck() {
  var pass1 = document.getElementById("pass1").value;
  var pass2 = document.getElementById("pass2").value;
  var message = document.getElementById("message");
  message.innerHTML = "";

  if (pass1 === "") {
   message.innerHTML = "Please fill in the password!";
   return false;
  }
  if (pass1.length < 4 || pass1.length > 8) {
   message.innerHTML = "Password length must be between 4 to 8 characters";
   return false;
  }
  if (!pass1.match(/[a-z]/g) || !pass1.match(/[A-Z]/g) || !pass1.match(/[0-9]/g)) {
   message.innerHTML = "Password must contain at least one lowercase letter, one uppercase letter and one digit";
   return false;
  }
  if (pass1 !== pass2) {
   message.innerHTML = "Passwords do not match";
   return false;
  }
  return true;
 }

 document.querySelectorAll('.toggle-password').forEach(item => {
  item.addEventListener('click', event => {
   const input = event.target.previousElementSibling;
   const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
   input.setAttribute('type', type);
   event.target.classList.toggle('fa-eye-slash');
  });
 });
</script>
</body>
</html>