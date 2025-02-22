<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GYM Info Club</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #C21807;
            --text-light: #ffffff;
            --text-dark: #333333;
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
            overflow-x: hidden;
            background-color: #f8f9fa;
        }

        .navbar {
            background-color: var(--primary-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            position: fixed;
            top: 0;
            width: 100%;
            height: 70px;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(194, 24, 7, 0.2);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            max-height: 50px;
            max-width: 120px;
            object-fit: contain;
            margin-left: 30px;
            transition: transform var(--transition-speed) ease;
        }

        .navbar-brand img:hover {
            transform: scale(1.05);
        }

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-item {
            padding: 25px 20px;
            color: var(--text-light);
            cursor: pointer;
            position: relative;
            text-decoration: none;
            font-weight: 500;
            transition: background-color var(--transition-speed) ease;
            letter-spacing: 0.3px;
        }

        .navbar-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .navbar-item.has-subnav {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .navbar-item.has-subnav::after {
            content: '\25BC';
            font-size: 10px;
            opacity: 0.8;
            transition: transform var(--transition-speed) ease;
        }

        .navbar-item.has-subnav:hover::after {
            transform: rotate(-180deg);
        }

        .subnav {
            position: absolute;
            top: 100%;
            left: 0;
            display: none;
            border-radius: 8px;
            margin-top: 1px;
            min-width: 180px;
            background-color: var(--text-light);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(194, 24, 7, 0.1);
            overflow: hidden;
        }

        .navbar-item:hover .subnav {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        .subnav-item {
            color: var(--primary-color);
            padding: 12px 20px;
            text-decoration: none;
            display: block;
            white-space: nowrap;
            transition: all var(--transition-speed) ease;
            font-size: 0.95em;
        }

        .subnav-item:hover {
            background-color: var(--primary-color);
            color: var(--text-light);
            padding-left: 25px;
        }

        .profile-icon {
            background-color: rgba(255, 255, 255, 0.9);
            color: var(--primary-color);
            border: 2px solid rgba(255, 255, 255, 0.9);
            padding: 10px 12px;
            border-radius: 50%;
            cursor: pointer;
            transition: all var(--transition-speed) ease;
            margin-left: 20px;
            margin-right: 30px;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-icon:hover {
            background-color: var(--primary-color);
            color: var(--text-light);
            border-color: var(--text-light);
            transform: scale(1.05);
        }

        #profileSubnav {
            background-color: var(--text-light);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 300px;
            right: 0;
            left: auto;
            margin-top: 1px;
            border: 1px solid rgba(194, 24, 7, 0.1);
        }

        .profile-header {
            text-align: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            margin-bottom: 15px;
        }

        .profile-pic {
            font-size: 45px;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .profile-name {
            font-weight: 600;
            font-size: 16px;
            color: var(--text-dark);
            margin-bottom: 4px;
        }

        .profile-email {
            font-size: 14px;
            color: #666;
        }

        .profile-info {
            padding: 8px 0;
            font-size: 14px;
            color: #555;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .profile-info span {
            color: var(--primary-color);
            font-weight: 500;
        }

        .logout-btn {
            display: block;
            background-color: var(--primary-color);
            color: var(--text-light);
            text-align: center;
            padding: 12px;
            border-radius: 6px;
            margin-top: 15px;
            text-decoration: none;
            transition: all var(--transition-speed) ease;
        }

        .logout-btn:hover {
            background-color: #a01505;
            transform: translateY(-1px);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 0 10px;
            }

            .navbar-brand img {
                margin-left: 10px;
            }

            .navbar-item {
                padding: 20px 15px;
            }

            .profile-icon {
                margin-right: 10px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-brand">
        <img src="/images/logo.jpg" alt="Gym Logo">
    </div>
    <div class="navbar-nav">
        <a href="/index" class="navbar-item">Home</a>

        <div class="navbar-item has-subnav">
            Item
            <div class="subnav">
                <a href="/gymitem" class="subnav-item">Add Item</a>
                <a href="/gymitems" class="subnav-item">Manage Items</a>
            </div>
        </div>

        <div class="navbar-item has-subnav">
            Slot
            <div class="subnav">
                <a href="/slot" class="subnav-item">Add Slot</a>
                <a href="/slots" class="subnav-item">Manage Slots</a>
                <a href="/booked" class="subnav-item">View Booking</a>
                <a href="/eslot" class="subnav-item">View Empty Slot</a>
                <a href="/bslot" class="subnav-item">View Booked Slot</a>
            </div>
        </div>

        <a href="/users" class="navbar-item">Users</a>
        <a href="/feedback-report" class="navbar-item">Feedback</a>

        <div class="navbar-item has-subnav">
            <span class="profile-icon">&#128100;</span>
            <div class="subnav" id="profileSubnav">
                <div class="profile-header">
                    <div class="profile-pic">&#128100;</div>
                    <div class="profile-name">${currentUser.username}</div>
                    <div class="profile-email">${currentUser.email}</div>
                </div>
                <div class="profile-info">
                    <span>First Name:</span>
                    <span>${currentUser.firstName}</span>
                </div>
                <div class="profile-info">
                    <span>Last Name:</span>
                    <span>${currentUser.lastName}</span>
                </div>
                <div class="profile-info">
                    <span>Type:</span>
                    <span>${currentUser.type}</span>
                </div>
                <a href="/logout" class="logout-btn">Log Out</a>
            </div>
        </div>
    </div>
</nav>
</body>
</html>