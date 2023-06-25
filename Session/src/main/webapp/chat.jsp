<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page import="java.math.BigInteger"%>
<%@page import="User.test" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String n = (String) request.getParameter("femail");
String email = (String) session.getAttribute("email");
/* String fremail =(String)request.getParameter("fremail"); */
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
.header img{
	width: 40px;
	height: 40px;
    border-radius: 100%;
    object-fit: fill;
    margin-right: 10px;    
    image-rendering: optimizeSpeed;
}
.chat img{
	width: 35px;
	height: 35px;
    border-radius: 100%;
    object-fit: fill;
    margin-right: 10px;
    image-rendering: optimizeSpeed;
}
</style>
</head>
<body>
	<%!Connection con;

	public void jspInit() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "major_project", "1133440");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}%>
	<%
	test t = new test();
	PreparedStatement pstmt = con.prepareStatement("select * from register where email = ?");
	pstmt.setString(1, n);
	ResultSet rs = pstmt.executeQuery();
	
	if (rs.next()) {
	%>
	<div class="chatBox">
		<div class="header">
			<div class="userinfo">
				<img src="image.jsp?email=<%=n %>"
					alt="Photo">
				<div class="name">
					<b id="fri"><%=rs.getString(1) + " " + rs.getString(2)%></b>
					<p><%
					if(rs.getString("status").equals("online")){
						out.println("Online");
					}else if(rs.getString("status").equals("offline")){
						out.println("offline");
					}
					else{
						String today1 = new Date().toString();
						int h = today1.substring(0,10).compareTo(rs.getString("status").substring(0,10));
						if(h==0){
							int time1 = Integer.parseInt(rs.getString("status").substring(11,13));
							String am ="AM";
							if(time1 > 12){
								time1=time1-12;
								am= "PM";
							}
							out.println(time1+rs.getString("status").substring(13,16)+" "+am);
						}else{
							out.println(rs.getString("status").substring(0,10));
						}
					}
					%></p>
				</div>
			</div>
			<div style="display:flex; align-items:center; flex-direction: row;">				
				<a href="deleteUser.jsp?friemail=<%=n %>">Delete User</a>
				<a href="#msgtop" class="msgtop"><img src="./Icons/uparrow.png" width="20px!important" /></a>
			</div>
		</div>
		<div class="textArea">
			<div class="messages" onscroll="scrollBottom()" id="ta">
				<div id="msgtop"></div>
				<%
				}				
				%>
				<%
				PreparedStatement pstmt2 = con.prepareStatement("select * from inbox where (s_id=? and r_id=?) or (s_id=? and r_id=?) order by time");
				pstmt2.setString(1,email);
				pstmt2.setString(2,n);
				pstmt2.setString(3,n);
				pstmt2.setString(4,email);
				ResultSet rs2= pstmt2.executeQuery();
				PreparedStatement pstmt6 = con.prepareStatement("update inbox set read='r' where (s_id=? and r_id=?) or (s_id=? and r_id=?) and read='u'");
				pstmt6.setString(1,email);
				pstmt6.setString(2,n);
				pstmt6.setString(3,n);
				pstmt6.setString(4,email);
				pstmt6.executeUpdate();
				
				PreparedStatement pstmt3 = con.prepareStatement("select * from relation where (user_email=? and fre_email=?) or (user_email=? and fre_email=?)");
				pstmt3.setString(1,email);
				pstmt3.setString(2,n);
				pstmt3.setString(3,n);
				pstmt3.setString(4,email);
				ResultSet rs3= pstmt3.executeQuery();
				rs3.next();
				
				while (rs2.next()) {
					if (rs2.getString(2).equals(email)) {
				%>
				<div class="chat outgoing">
					<div class="details">
						<p><%
						String m1 = rs2.getString("messages");
						String x1 =rs3.getString("x");
						String p1=rs3.getString("p");
						String demsg = t.decrypted(m1,x1,p1);
						out.println(demsg);
%></p>						
					</div>
				</div>
				<%
				}else{
				%>
				<div class="chat incoming">
					<img src="image.jsp?email=<%=n%>">
					<div class="details">
						<p><%
						String demsg = t.decrypted(rs2.getString("messages"),rs3.getString("x"),rs3.getString("p"));
						out.println(demsg);
%></p>
					</div>
				</div>
				<%}}%>
				
			</div>
		</div>
		<div class="msgBar">
			<input class="sendMsg" type="search" placeholder="Type Your message..." id="sendMsg" onsearch="msg('<%=n%>')" onclick="this.value=''">
			<button class="sendBtn" id="sendBtn" onclick="msg('<%=n%>')">Send</button>
		</div>
	</div>
	<script>
	alert("He;;");
	var element = document.querySelector('#ta');
	element.scrollTop = element.scrollHeight;
	</script>
</body>
</html>