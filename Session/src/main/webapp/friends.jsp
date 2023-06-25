<%@page import="java.util.Date"%>
<%@page import="User.test"%>
<%@page import="java.math.BigInteger"%>
<%String email = (String) session.getAttribute("email");%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- <META http-equiv="REFRESH" content="5; url=http://localhost:8090/Session/main.jsp"> -->
<title>Friends</title>
<style>
.sidebar .contacts img{
	width: 40px;
	height: 40px;
    border-radius: 100%;
    object-fit: fill;
    margin-right: 10px;
    padding-right: 0;
    image-rendering: optimizeSpeed;
}
</style>
</head>
<body>
	<%@page import="java.sql.*"%>
	<%@page import="jakarta.servlet.http.*"%>
	<%!
	Connection con;
	public void jspInit() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "major_project", "1133440");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	%>
	<ul id="list1">
		<%
		PreparedStatement pstmt = con.prepareStatement("select * from relation where user_email=? or fre_email=?");
		PreparedStatement pstmt3 = con.prepareStatement("select * from register where email=?");
		PreparedStatement pstmt4 = con.prepareStatement("select * from inbox where (s_id=? and r_id=?) or (s_id=? and r_id=?) order by time desc fetch first 1 row only");
		PreparedStatement pstmt6 = con.prepareStatement("select * from inbox where s_id=? and r_id=?");
		PreparedStatement pstmt1 = con.prepareStatement("select * from register where email=?");
		
		
		test t = new test();
		try {
			pstmt.setString(1, email);
			pstmt.setString(2, email);
			ResultSet rs = pstmt.executeQuery();
			/* PreparedStatement pstmt5 = con.prepareStatement("select * from relation where (user_email=? and fre_email=?) or (user_email=? and fre_email=?)");
			pstmt5.setString(1,email);
			pstmt5.setString(2,name2);
			pstmt5.setString(3,name2);
			pstmt5.setString(4,email);
			ResultSet rs5= pstmt5.executeQuery(); */
			while (rs.next()) {
				String name2 = rs.getString(2);				
				if(name2.equals(email)){
						name2=rs.getString(1);
						request.setAttribute("fremail", name2);
						pstmt3.setString(1, name2);
						ResultSet rs3 = pstmt3.executeQuery();
						if (rs3.next()) {
						%>
						<li onclick="chatFriend('<%=name2%>');"><img src="image.jsp?email=<%=name2%>" alt="Profile">
							<div class="userinfo">
								<b><%=rs3.getString(1) + " " + rs3.getString(2)%></b>
								<p><%pstmt4.setString(1,email);
								pstmt4.setString(2,name2);
								pstmt4.setString(3,name2);
								pstmt4.setString(4,email);
								ResultSet rs4 = pstmt4.executeQuery();
								
								if(rs4.next()){
									if(rs4.getString("s_id").equals(email)){
										String demsg = t.decrypted(rs4.getString("messages"),rs.getString("x"),rs.getString("p"));
										out.println("You: "+demsg);
									}
									else{
										String demsg = t.decrypted(rs4.getString("messages"),rs.getString("x"),rs.getString("p"));
										out.println(demsg);
									}
								}else{
									out.println("No messages yet");
								}
								%></p>
							</div>
							<div class=" time">
								<p><%
								if(rs3.getString("status").equals("online")){
									out.println("Online");
								}else if(rs3.getString("status").equals("offline")){
									out.println("Offline");
								}
								else{
									String today = new Date().toString();
									int f = today.substring(0,10).compareTo(rs3.getString("status").substring(0,10));
									if(f==0){
										int time1 = Integer.parseInt(rs3.getString("status").substring(11,13));
										String am ="AM";
										if(time1 >= 12){
											if(time1>12){
												time1=time1-12;
											}
											
											am= "PM";
										}
										out.println(time1+rs3.getString("status").substring(13,16)+" "+am);
									}else{
										out.println(rs3.getString("status").substring(0,10));
									}
								}
								int count=0;
								pstmt6.setString(1,name2);
								pstmt6.setString(2, email);
								ResultSet rs6 = pstmt6.executeQuery();
								while(rs6.next()){
									if(rs6.getString("read").equals("u")){
										count++;
									}
								}
								%></p>								
								<%
								if(count>0){%>
									<span class="notify" style="font-size:10px;margin-left:10px;background-color:red;color:white;padding:1px 5px;border-radius:100%;"><%=count %></span>
								<%}
								%>
							</div>
						</li>
						<% 
					}
				}else {
					pstmt1.setString(1, name2);
					ResultSet rs1 = pstmt1.executeQuery();
					if (rs1.next()) {
						request.setAttribute("fremail", name2);
		%>
						<li onclick="chatFriend('<%=name2%>');"><img src="image.jsp?email=<%=name2%>" alt="Photo">
							<div class="userinfo">
								<b><%=rs1.getString(1) + " " + rs1.getString(2)%></b>
								<p><%pstmt4.setString(1,email);
								pstmt4.setString(2,name2);
								pstmt4.setString(3,name2);
								pstmt4.setString(4,email);
								ResultSet rs4 = pstmt4.executeQuery();
								if(rs4.next()){
									if(rs4.getString("s_id").equals(email)){
										
										String demsg = t.decrypted(rs4.getString("messages"),rs.getString("x"),rs.getString("p"));
										out.println("You: "+demsg);
									}
									else{
										String demsg = t.decrypted(rs4.getString("messages"),rs.getString("x"),rs.getString("p"));
										out.println(demsg);
									}
								}else{
									out.println("No messages yet");
								}
								%></p>
							</div>
							<div class=" time">
								<p><%
								if(rs1.getString("status").equals("online")){
									out.println("Online");
								}else if(rs1.getString("status").equals("offline")){
									out.println("offline");
								}
								else{
									String today1 = new Date().toString();
									int h = today1.substring(0,10).compareTo(rs1.getString("status").substring(0,10));
									if(h==0){
										int time1 = Integer.parseInt(rs1.getString("status").substring(11,13));
										String am ="AM";
										if(time1 >= 12){
											if(time1>12){
												time1=time1-12;
											}
											
											am= "PM";
										}
										out.println(time1+rs1.getString("status").substring(13,16)+" "+am);
									}else{
										out.println(rs1.getString("status").substring(0,10));
									}
								}
								int count=0;
								pstmt6.setString(1,name2);
								pstmt6.setString(2, email);
								ResultSet rs6 = pstmt6.executeQuery();
								while(rs6.next()){
									if(rs6.getString("read").equals("u")){
										count++;
									}
								}
								
								%></p>								
								<%
								if(count>0){%>
									<span class="notify" style="font-size:10px;margin-left:10px;background-color:red;color:white;padding:1px 5px;border-radius:100%;"><%=count %></span>
								<%}
								%>
							</div>
						</li>
		<%
					} else {
		%>
						<li><%="Not found"%> <%
 					}
 				}
 			}
 } catch (Exception e) {
 	e.printStackTrace();
 }finally{
			pstmt6.close();
			pstmt.close();pstmt1.close();pstmt3.close();pstmt4.close();
		}
 %>
	</ul>
</body>
</html>