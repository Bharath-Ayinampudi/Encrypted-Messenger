<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%String email = (String)request.getParameter("email");
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","major_project","1133440");
	PreparedStatement pstmt = con.prepareStatement("select * from register where email =?");
	pstmt.setString(1,email);
	ResultSet rs = pstmt.executeQuery();
	OutputStream os = null;
	if(rs.next()){
		Blob blob = rs.getBlob(5);
		byte byteArray[] = blob.getBytes(1, (int)blob.length());
		response.setContentType("image/gif");
		os = response.getOutputStream();
		os.write(byteArray);
		os.flush();
		os.close();
	}
}catch(Exception e){
	e.printStackTrace();
}
%>