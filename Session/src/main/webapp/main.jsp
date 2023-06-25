<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%
Connection con;
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
response.setHeader("Expires", "0"); //Proxies 
String user = (String) session.getAttribute("name");
String email = (String) session.getAttribute("email");
if (user == null) {
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="main.css">
<link rel="website icon" type="png" href="./Icons/chat.png">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>

<title>Encrypted Messenger</title>
<style>
.editProfile {
	width: 80%;
	padding: 20px;
	background-color: white;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 20;
	display: none;
	border-radius: 20px;
	box-shadow: 0px 0px 50px gray;
	justify-content: center;
}
.editProfile .close {
	position: absolute;
	right: 25px;
	top: 5px;
	font-size: 30px;
	color: black;
	font-weight: 800;
}
.editProfile .close:hover {
	color: red;
}
.editProfile form {
	width: 90%;
	/* background-color: red; */
}
.editProfile form input {
	width: 70%;
	padding: 5px;
	border-radius: 5px;
	outline: none;
	border: 1px solid green;
}
.editProfile form .edit-profile {
	width: 100%;
	display: flex;
	align-items: center;
	flex-direction: column;
}
.editProfile form .edit-profile div {
	width: 100%;
	display: flex;
	justify-content: space-between;
	margin: 10px 0;
}
.editProfile form .btn button {
	padding: 7px 50px;
	margin-top: 5px;
	border-radius: 10px;
	border: none;
	outline: none;
}
.editProfile form .btn button:hover {
	box-shadow: 0px 0px 5px gray;
}
</style>
</head>
<body onload="friend()">
	<div class="container">
		<div class="menu">
			<div class="logo" title="Home">
				<a href="main.jsp"><img src="./Icons/chat.png" alt="Logo"></a>
			</div>
			<div class="menu-list">
				<ul>
					<li title="Chat List" id="chat" onclick="friend()"><a><img src="./Icons/menuChat.png" alt="Chat List"></a></li>
					<li title="Add People" id="people"><a><img src="./Icons/menuPeople.png" alt="Add People"></a></li>
				</ul>
				<ul>

					<li title="Logout"><a href="logout"><img src="./Icons/logout.png" alt="Logout"></a></li>
					<li class="profileicon" title="<%=user%>"><a class="profile"><img src="image.jsp?email=<%=email%>" alt="Profile"></a></li>
				</ul>
			</div>
		</div>
		<div class="sidebar">
			<div class="chat-sidebar" id="chat-sidebar">
				<div class="header">
					<h2>Chat List</h2>
					<div>
						<img src="./Icons/chat.png" width="40px"> 
						<input type="search" placeholder="Search" id="search-bar" onkeyup="search()">
					</div>
				</div>
				<div class="contacts" id="contacts"></div>
			</div>
			<div class="people-sidebar" id="people-sidebar">
				<div class="header">
					<h2>Add People</h2>
					<div>
						<img src="./Icons/chat.png" width="40px"> 
						<input type="search" placeholder="Enter your friend email address" class="peopleSearch" id="pemail">
					</div>
				</div>
				<div class="contacts" id="peopleContacts" ></div>
			</div>
		</div>
		<div class="contains" id="contains">
			<div class="containsWelcome">
				<div class="error-txt" id="errTxt1"></div>
				<h1>Welcome to Encrypted Messenger</h1>
				<img alt="Logo" src="./Icons/chat.png" width="20%">
			</div>
		</div>
	</div>
	<%
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "major_project", "1133440");
		PreparedStatement pstmt = con.prepareStatement("select * from register where email=?");
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
	%>

	<div class="editProfile">
		<a href="#!" class="close"><b>x</b></a>
		<form class="editForm" method="post" action="#!">
			<h2>Edit Profile Details</h2>
			<div style="text-align: center; margin: 5px 0;">
				<span id="msg" style="color: red; font-weight: 800;"></span>
			</div>
			<div class="edit-profile">
				<div class="edit-image" style="width: 150px; height: 150px; border-radius: 50%; background-color: green;">
					<img style="width: 150px; height: 150px; border-radius: 50%;" src="image.jsp?email=<%=email%>" alt="Profile">
				</div>
				<b style="text-transform: capitalize"><%=rs.getString("fname") + " " + rs.getString("lname")%></b>
				<div class="edit-fname">
					<label>Change the first-name:</label> 
					<input type="text" name="cfname" value="<%=rs.getString("fname")%>" placeholder="First Name" id="cfname">
				</div>
				<div class="edit-lname">
					<label>Change the last-name:</label> 
					<input type="text" name="clname" placeholder="Last Name" value="<%=rs.getString("lname")%>" id="clname">
				</div>
				<div class="edit-email">
					<label>Change the email:</label> 
					<input type="email" name="cemail" placeholder="Email" value="<%=rs.getString("email")%>" id="cemail">
				</div>
				<div class="edit-password">
					<label>Change the password:</label> 
					<input type="text" name="cpword" placeholder="Enter password" id="cpword">
				</div>
				<div class="edit-cpassword">
					<label>Confirm password:</label> 
					<input type="text" name="crpword" placeholder="Confirm password" id="crpword">
				</div>
				<div class="edit-profilePic">
					<label>Change profile photo:</label> 
					<input type="file" accept="image/*" id="cpic">
				</div>
			</div>
			<div class="btn" style="text-align: center;">
				<button type="submit">Save</button>
			</div>
		</form>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>

	</div>

	<script src="./main.js"></script>
	<script>
		var profileicon = document.querySelector(".profileicon");
		profileicon.addEventListener('click' ,function(){
			var editProfile = document.querySelector(".editProfile");
			editProfile.style.display = "flex";
		});
		var close = document.querySelector(".close");
		close.addEventListener('click' ,function(){
			var editProfile = document.querySelector(".editProfile");
			editProfile.style.display = "none";
		});		
		const editForm = document.querySelector(".editForm");
		editForm.addEventListener('submit',(e)=>{
			e.preventDefault();
			var cfname = document.getElementById("cfname").value;
			var clname = document.getElementById("clname").value;
			var cemail = document.getElementById("cemail").value;
			var cpword = document.getElementById("cpword").value;
			var crpword = document.getElementById("crpword").value;
			const xhr = new XMLHttpRequest();
			xhr.onload=function(){
				let res = this.responseText;
				res = res.trim();
				if(res == "success"){
					document.getElementById("msg").style.color="green";
					document.getElementById("msg").innerHTML = "Updated Successfully";
				}else if(res == "passwordNotMatch"){
					document.getElementById("msg").innerHTML = "Password does not match";
				}else{
					document.getElementById("msg").innerHTML = "Something went wrong!";
				}
			}
			xhr.open("GET","update.jsp?cfname="+cfname+"&clname="+clname+"&cemail="+cemail+"&cpword="+cpword+"&crpword="+crpword);
			xhr.send();
			
		});
	</script>
	<script>
	function search(){
	var search = document.getElementById("search-bar").value;	
	var filter = search.toUpperCase();
	var list = document.querySelectorAll("#list1 li");	
	list.forEach((el)=>{
		const text = el.textContent.toUpperCase();
		el.style.display = text.includes(filter)?"":"none";
	});		
	}
	</script>
	<script> 
$(document).ready(function(){
setInterval(function(){
      friend();
}, 1000);
});

</script>
</body>
</html>