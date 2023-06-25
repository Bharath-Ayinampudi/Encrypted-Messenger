<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="index.css">
    <link rel="website icon" type="png" href="./Icons/chat.png">
    <title>Forgot Password</title>
</head>

<body>
    <div class="container">
        <div class="left">
            <header>Welcome to Encrypted Messenger</header>
            <div class="adv">
                <span>Secure</span><span class="dot"></span><span>Fast</span><span
                    class="dot"></span><span>Reliable</span>
            </div>
            <img src="./Icons/chat.png" alt="Logo">
        </div>
        <div class="right">
            <input type="hidden" id="status1" value="<%= request.getAttribute("status1") %>">
            <div class="wrapper hide1" id="hide1">
                <section class="form login">
                    <header>Forgot Password</header>
                    
                    <form action="ForgotServlet" method="post" id="loginForm">
                        <div class="error-txt" id="errTxt1">This is an error Message!</div>
                        
                        <%
                    String msg =(String) session.getAttribute("msg");
                    String msg1 =(String) session.getAttribute("msg1");
                    if(!(msg==null) && msg1==null){
                    	
                    %>
                        <div class="field input">
                        
                            <label>OTP</label>
                            <input type="text" placeholder="Enter OTP" required name="otp" id="otp" />
                            <span style="margin-top:7px;"><%=msg %></span>
                        </div>
                        <div class="field button">
                            <button class="loginBtn">Verify</button>
                        </div>
                        <%}else if(!(msg1==null)){
                        	%>
                        <div class="field input">
                            <label>Change Password</label>
                            <input type="password" placeholder="Enter new password:" name="npwd" id="npwd" />
                        </div>
                        <div class="field input">
                            <label>Confirm Password</label>
                            <input type="password" placeholder="Confirm Password" name=cpwd id="cpwd" />
                        </div>
                        <div class="field button">
                            <button class="loginBtn">Change Password</button>
                            <!-- <input type="submit" value="Continue to chat" class="loginBtn"> -->
                        </div>
                        <% }
                    else{
                        
                        %>
                        <div class="field input">
                            <label>Email Address</label>
                            <input type="text" placeholder="Enter your email" name="lemail" id="lemail" />
                        </div>
                        <div class="field button">
                            <button class="loginBtn">Send OTP</button>
                            <!-- <input type="submit" value="Continue to chat" class="loginBtn"> -->
                        </div>
                        <%} %>
                    </form>
                </section>
            </div>            
        </div>
    </div>

    <script src="./index.js"></script>
</body>

</html>