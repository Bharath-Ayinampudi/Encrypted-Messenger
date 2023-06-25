<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
String email = (String) session.getAttribute("email");
Connection con;
%>
<%
String cfname = request.getParameter("cfname");
String clname = request.getParameter("clname");
String cemail = request.getParameter("cemail");
String cpword = request.getParameter("cpword");
String crpword = request.getParameter("crpword");
%>
<%
try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "major_project", "1133440");
	if(crpword.equals("null")){
		PreparedStatement pstmt = con.prepareStatement("update register set fname = ? , lname = ? , email=?, password=? where email=?");
		pstmt.setString(1, cfname);
		pstmt.setString(2, clname);
		pstmt.setString(3, cemail);
		if (cpword.equals(crpword)) {
			pstmt.setString(4, crpword);
			pstmt.setString(5, email);
			int f = pstmt.executeUpdate();
			if (f > 0)
				out.println("success");
		} else
			out.println("passwordNotMatch");

	}else{
		PreparedStatement pstmt2 = con.prepareStatement("update register set fname = ? , lname = ? , email=? where email=?");
		pstmt2.setString(1, cfname);
		pstmt2.setString(2, clname);
		pstmt2.setString(3, cemail);
		pstmt2.setString(4, email);
		int f1 = pstmt2.executeUpdate();
		if (f1 > 0){
			out.println("success");
	}
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>