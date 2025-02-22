<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Contact Us</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/images/BGimg.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            font-family: 'Montserrat', sans-serif;
            height: 100vh;
            margin: -20px 0 50px;
            position: relative;
            overflow: hidden;
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

        .container {
            position: relative;
            z-index: 2;
            width: 100%;
            max-width: 600px;
            margin-top: 100px; /* Space for header */
        }

        .contact-info {
            margin: 20px auto;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        .info-item {
            margin: 25px 0;
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }

        .info-item:hover {
            transform: translateX(10px);
        }

        .info-item i {
            width: 40px;
            height: 40px;
            background: #333;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 1.2em;
        }

        .info-content {
            flex: 1;
        }

        .info-content h3 {
            margin: 0;
            color: #333;
            font-size: 1.1em;
            font-weight: 600;
        }

        .info-content p {
            margin: 5px 0 0;
            color: #666;
            font-size: 1em;
        }

        .section-title {
            text-align: center;
            color: #333;
            font-size: 1.8em;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .social-media {
            text-align: center;
            margin-top: 30px;
            padding: 20px 0;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .social-media a {
            color: #333;
            text-decoration: none;
            margin: 0 15px;
            font-size: 1.5em;
            transition: color 0.3s ease;
        }

        .social-media a:hover {
            color: #666;
        }

        @media (max-width: 768px) {
            .container {
                margin: 80px 20px 20px;
            }

            .contact-info {
                padding: 20px;
            }

            .info-item {
                flex-direction: row;
                text-align: left;
            }
        }
    </style>
</head>
<body>
<%@ include file="header2.jsp" %>
<div class="blur-overlay"></div>
<div class="container">
    <div class="contact-info">
        <h2 class="section-title">Contact Information</h2>

        <div class="info-item">
            <i class="fas fa-map-marker-alt"></i>
            <div class="info-content">
                <h3>Location</h3>
                <p>Mesnana, Tanger, Morocco</p>
            </div>
        </div>

        <div class="info-item">
            <i class="fas fa-envelope"></i>
            <div class="info-content">
                <h3>Email</h3>
                <p>Oxygym@gmail.com</p>
            </div>
        </div>

        <div class="info-item">
            <i class="fas fa-phone-alt"></i>
            <div class="info-content">
                <h3>Phone</h3>
                <p>(212) 648-4790</p>
            </div>
        </div>

        <div class="info-item">
            <i class="fab fa-instagram"></i>
            <div class="info-content">
                <h3>Social Media</h3>
                <p>@Oxy_Gym</p>
            </div>
        </div>

        <div class="social-media">
            <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" title="Facebook"><i class="fab fa-facebook"></i></a>
            <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
        </div>
    </div>
</div>
</body>
</html>