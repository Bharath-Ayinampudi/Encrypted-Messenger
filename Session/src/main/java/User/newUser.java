package User;

import java.sql.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/reg")
@MultipartConfig(maxFileSize = 16177216)
public class newUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;

	public newUser() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "major_project", "1133440");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			RequestDispatcher dispatcher = null;
			String fname = request.getParameter("fname");
			String lname = request.getParameter("lname");
			String email = request.getParameter("remail");
			String pwd = request.getParameter("rpwd");
			Part part = request.getPart("profileImage");
			if(!(fname.isEmpty()) && !(lname.isEmpty()) && !(email.isEmpty()) &&!(pwd.isEmpty())) {
				 PreparedStatement pstmt =con.prepareStatement("select * from register where email=? and password=RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => ?))");
				 pstmt.setString(1, email); 
				 pstmt.setString(2, pwd);
				 ResultSet rs =pstmt.executeQuery();
				 if(rs.next()) {
					 dispatcher = request.getRequestDispatcher("index.jsp"); 
					 request.setAttribute("status2", "accountExist"); 
					 dispatcher.forward(request, response); 
				 }else {
					 pstmt = con.prepareStatement("INSERT INTO REGISTER VALUES(?,?,?,RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => ?)),?,?,?)");
					 pstmt.setString(1, fname); 
					 pstmt.setString(2, lname); 
					 pstmt.setString(3, email); 
					 pstmt.setString(4, pwd);
					 if(part!=null) {
						 InputStream is = part.getInputStream();
						 pstmt.setBlob(5, is);
					 }
					 pstmt.setString(6,"offline");
					 pstmt.setString(7, "0");
					 int rowCount = pstmt.executeUpdate(); 
					 dispatcher = request.getRequestDispatcher("index.jsp");
					 if (rowCount > 0) {
						 request.setAttribute("status2", "success"); 
					}else {
						request.setAttribute("status2", "failed"); 
					}
					 dispatcher.forward(request, response);
				 }
			}else { 
				dispatcher = request.getRequestDispatcher("index.jsp"); 
				request.setAttribute("status2", "empty"); 
				dispatcher.forward(request, response); 
			}		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
