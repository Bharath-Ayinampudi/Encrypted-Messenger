<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="website icon" type="png" href="./Icons/chat.png">
        <title>Welcome to Encrypted Messenger</title>
    </head>
    <body>
        <div class="container">
            <div class="left">
                <header>Welcome to Encrypted Messenger</header>
                <div class="adv">
                    <span>Secure</span>
                    <span class="dot"></span>
                    <span>Fast</span>
                    <span class="dot"></span>
                    <span>Reliable</span>
                </div>
                <img src="./Icons/chat.png" alt="Logo">
            </div>
            <div class="right">
                <input type="hidden" id="status1" value="<%= request.getAttribute("status1") %>">
                <div class="wrapper hide1" id="hide1">
                    <section class="form login">
                        <header>Login</header>
                        <form action="login" method="post" id="loginForm">
                            <div class="error-txt" id="errTxt1">This is an error Message!</div>
                            <div class="field input">
                                <label>Email Address</label>
                                <input type="text" placeholder="Enter your email" name="lemail" id="lemail"/>
                            </div>
                            <div class="field input">
                                <label>Password</label>
                                <input type="password" placeholder="Enter your password" name="lpwd" id="lpwd"/>
                                <i class="fas fa-eye" id="togglePassword"><img src="./Icons/eye.png" alt="Show Password"/></i>
                            </div>
                            <div class="field input">
                                <a href="Forgot.jsp">Forgot password?</a>
                            </div>
                            <div class="field button">
                                <button class="loginBtn">Continue to chat</button>
                            </div>
                        </form>
                        <div class="link"> Not yet register? <a onclick="hide2()">Register now</a> </div>
                    </section>
                </div>

                <input type="hidden" id="status2" value="<%= request.getAttribute("status2") %>">
                <div class="wrapper hide2" id="hide2">
                    <section class="form signup">
                        <header>Register</header>
                        <form action="reg" method="post" id="registerForm" enctype="multipart/form-data">
                            <div class="error-txt" id="errTxt2">This is an error Message!</div>
                            <div class="name-details">
                                <div class="field input">
                                    <label>First Name</label>
                                    <input type="text" placeholder="First Name" name="fname" id="fname"/>
                                </div>
                                <div class="field input">
                                    <label>Last Name</label>
                                    <input type="text" placeholder="Last Name" name="lname"/>
                                </div>
                            </div>
                            <div class="field input">
                                <label>Email Address</label>
                                <input type="text" placeholder="Enter your email" name="remail" id="remail"/>
                            </div>
                            <div class="field input">
                                <label>New Password</label>
                                <input type="password" placeholder="Enter new password" name="rpwd" id="rpwd"/>
                                <i class="fas fa-eye" id="rtogglePassword"><img src="./Icons/eye.png" alt="Show Password"/></i>
                            </div>
                            <div class="field input">
                                <label>Confirm Password</label>
                                <input type="password" placeholder="Enter Confirm password" id="rcpwd"/>
                                <i class="fas fa-eye" id="rctogglePassword"><img src="./Icons/eye.png" alt="Show Password"/></i>
                            </div>
                            <div class="field image">
                                <label>Select Image</label>
                                <input type="file" accept="image/png, image/jpg, image/jpeg" name="profileImage"/>
                            </div>
                            <div class="field button">
                                <button class="registerBtn">Register</button>
                            </div>
                        </form>
                        <div class="link"> Already register? <a onclick="hide1()">Login now</a> </div>
                    </section>
                </div>
            </div>
        </div>
        <script src="./index.js"></script>
    </body>
</html>
