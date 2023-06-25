package User;

import jakarta.mail.*; 
import jakarta.mail.internet.*;
import java.util.Properties;

public class SendMail {
	public static void sendMail(int otp, String to) {
		Properties properties = System.getProperties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.ssl.enable", "true");
		properties.put("mail.smtp.auth", "true");
		
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
		    protected PasswordAuthentication getPasswordAuthentication() {
		        return new PasswordAuthentication("akshithk111@gmail.com", "penkooamddrolzlv");	   
		    }
		});


		MimeMessage message = new MimeMessage(session);
		try {			
			message.setFrom(new InternetAddress("akshithk111@gmail.com"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("Password Change OTP Verification");
			message.setText("Hi,\n"+"You have requested to change your password. To proceed with the password change, please enter the following One-Time Password (OTP): "+otp+"\nPlease note that this OTP is valid for a limited time. If you did not request this password change, please ignore this email");
			Transport.send(message);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
