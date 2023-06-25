<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.BigInteger"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page import="User.test" %>
<%!String g; %>
<%
String email=(String)session.getAttribute("email");
String fremail =(String)request.getParameter("fremail");
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","major_project","1133440");
test t = new test();
PreparedStatement pstmt1=con.prepareStatement("select * from relation where (user_email=? and fre_email=?) or (user_email=? and fre_email=?)");
pstmt1.setString(1,email);
pstmt1.setString(2,fremail);
pstmt1.setString(3,fremail);
pstmt1.setString(4,email);
ResultSet rs1 = pstmt1.executeQuery();
if(rs1.next()){ 
	String id = rs1.getString("conid");
	if(!(msg.isEmpty())){
		String emsg = t.encrypted(msg,rs1.getString("x"),rs1.getString("p"),id);
		PreparedStatement pstmt = con.prepareStatement("insert into inbox(m_id,s_id,r_id,messages,con_id,read) values(s_m_id.nextval,?,?,?,?,?)");
		pstmt.setString(1,email);
		pstmt.setString(2,fremail);
		pstmt.setString(3,emsg);
		pstmt.setString(4,id);
		pstmt.setString(5,"u");
		pstmt.executeUpdate();
	}
}
%>
	<%
				PreparedStatement pstmt2 = con.prepareStatement("select * from inbox where (s_id=? and r_id=?) or (s_id=? and r_id=?) order by time");
	pstmt2.setString(1,email);
	pstmt2.setString(2,fremail);
	pstmt2.setString(3,fremail);
	pstmt2.setString(4,email);
	ResultSet rs2= pstmt2.executeQuery();
				while (rs2.next()) {
					if (rs2.getString(2).equals(email)) {
				%>
				<div class="chat outgoing">
					<div class="details">
						<p><%
String[] dmsg = rs2.getString("messages").split("[,]",0);
						BigInteger bg1 = new BigInteger(dmsg[0]);
						BigInteger bg2 = new BigInteger(dmsg[1]);
						String demsg = t.decrypted(rs2.getString("messages"),rs1.getString("x"),rs1.getString("p"));
						out.println(demsg);
%></p>
					</div>
				</div>
				<%
				}else{
				%>
				<div class="chat incoming">
					<img src="image.jsp?email=<%=fremail%>">
					<div class="details">
						<p><%
						String demsg = t.decrypted(rs2.getString("messages"),rs1.getString("x"),rs1.getString("p"));
						out.println(demsg);
%></p>
					</div>
				</div>
				<%} }%>	
</body>
</html>