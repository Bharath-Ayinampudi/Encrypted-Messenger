<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<%String email = (String)session.getAttribute("email");
String friemail = request.getParameter("friemail");
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","major_project","1133440");
PreparedStatement pstmt= con.prepareStatement("select * from relation where (user_email=? and fre_email=?) or (user_email=? and fre_email=?)");
pstmt.setString(1,email);
pstmt.setString(2,friemail);
pstmt.setString(3,friemail);
pstmt.setString(4,email);
ResultSet rs = pstmt.executeQuery();
if(rs.next()){
	String conn= rs.getString("conid");
	PreparedStatement pstmt1 = con.prepareStatement("delete from inbox where con_id=?");
	pstmt1.setString(1,conn);
	pstmt1.executeUpdate();
	PreparedStatement pstmt2 = con.prepareStatement("delete from relation where conid=?");
	pstmt2.setString(1,conn);
	pstmt2.executeUpdate();
	response.sendRedirect("main.jsp");
}
%>