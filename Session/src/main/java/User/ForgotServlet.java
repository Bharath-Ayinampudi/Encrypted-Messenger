package User;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.Math;
import java.sql.*;

@WebServlet("/ForgotServlet")
public class ForgotServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","major_project","1133440");
			HttpSession hs = request.getSession();
			if(!(request.getParameter("lemail")==null)) {
				String email = request.getParameter("lemail");
				PreparedStatement pstmt = con.prepareStatement("select * from register where email=?");
				pstmt.setString(1, email);
				ResultSet rs = pstmt.executeQuery();
				
				if(rs.next()) {
					int num =(int) Math.floor((Math.random()*1000000));
					PreparedStatement pstmt1 = con.prepareStatement("update register set code=? where email=?");
					pstmt1.setInt(1, num);
					pstmt1.setString(2, email);
					int count=pstmt1.executeUpdate();
					if(count>0) {
						SendMail.sendMail(num,"bharathchoudary33@gmail.com");	
						String msg="Enter OTP sent to the registered email";
						hs.setAttribute("msg", msg);
						hs.setAttribute("email", email);
						response.sendRedirect("Forgot.jsp");
					}
				}
				
			}else if(!(request.getParameter("otp")==null)) {
				String otp = request.getParameter("otp");
				String email =(String)hs.getAttribute("email");
				PreparedStatement pstmt2 = con.prepareStatement("select * from register where email=? and code=?");
				pstmt2.setString(1, email);
				pstmt2.setString(2, otp);
				ResultSet rs2 = pstmt2.executeQuery();
				if(rs2.next()) {				
					hs.setAttribute("msg1", "Hello");
					response.sendRedirect("Forgot.jsp");
				}
			}else if(!(request.getParameter("npwd")==null) && !(request.getParameter("cpwd")==null)) {
				if(request.getParameter("npwd").equals(request.getParameter("cpwd"))){
					PreparedStatement pstmt3 = con.prepareStatement("update register set password = RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => ?)) where email=?");
					pstmt3.setString(1,request.getParameter("cpwd"));
					pstmt3.setString(2,(String)hs.getAttribute("email"));
					if(pstmt3.executeUpdate()>0) {
						response.sendRedirect("index.jsp");
					}else {
						System.out.println("Error");
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
