<% 
String pemail=request.getParameter("q"); 
String email=(String)session.getAttribute("email"); 
%>
<%@page import="java.sql.*"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page import  ="java.math.BigInteger" %>
<%@page import  ="java.security.SecureRandom" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add People</title>
<style>
.sidebar img{
	width: 40px;
	height: 40px;
    border-radius: 100%;
    object-fit: fill;
    margin-right: 10px;    
    image-rendering: optimizeSpeed;
}
</style>
</head>
<body>
		<ul>
			<li><img src="image.jsp?email=<%=pemail%>" alt="Profile" alt="Photo">
				<div class="userinfo">
						<b id="fru">
							<%
							try{ 
								Class.forName("oracle.jdbc.driver.OracleDriver"); 
								Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","major_project","1133440");
								PreparedStatement pstmt=con.prepareStatement("select * from register where email=?"); 
								pstmt.setString(1,pemail); 
								ResultSet rs=pstmt.executeQuery();
								if(rs.next()){ 
									if(email.equals(pemail)){
										out.println("Me");
									}
									else{
										out.println(rs.getString("fname").concat(" ").concat(rs.getString("lname")));
										PreparedStatement pstmt1 = con.prepareStatement("select * from relation where (user_email=? and fre_email=?) or (user_email=? and fre_email=?) "); 
										pstmt1.setString(1,email); 
										pstmt1.setString(2,pemail);
										pstmt1.setString(3,pemail); 
										pstmt1.setString(4,email);
										ResultSet rs1 = pstmt1.executeQuery(); 
										if(!(rs1.next())){
											BigInteger p = BigInteger.probablePrime(512, new SecureRandom());
											BigInteger x = new BigInteger(512, new SecureRandom());
												PreparedStatement pstmt2=con.prepareStatement("insert into relation values(?,?,sq.nextval,?,?)");
												pstmt2.setString(1,email); 
												pstmt2.setString(2,pemail);
												pstmt2.setString(3,p.toString());
												pstmt2.setString(4,x.toString());
												pstmt2.executeUpdate(); 
											} 
									}
									}else{
										out.println("Not Found"); 
									}
								}catch(Exception e){
									e.printStackTrace();
								} %>
						</b>
				</div>
			</li>
		</ul>
</body>
</html>