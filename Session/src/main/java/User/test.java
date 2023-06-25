package User;

import java.math.BigInteger; 
import java.security.SecureRandom;
public class test {    
	
    public BigInteger a;
    public BigInteger b;
    
    public String encrypted(String msg,String x,String p, String g){

        // Define the message to be encrypted
    	BigInteger x1 = new BigInteger(x);
    	BigInteger p1 = new BigInteger(p);
    	BigInteger g1 = new BigInteger(g);
        String message = msg;
        BigInteger y = g1.modPow(x1, p1);
        BigInteger k = new BigInteger(512, new SecureRandom());
        // Compute the ciphertext
        a = g1.modPow(k, p1);
        b = y.modPow(k, p1).multiply(new BigInteger(message.getBytes()));
        
        // Print the encrypted message
        String emsg = a.toString()+","+b.toString();

//        //For Decryption 
//        System.out.println("Calling Decryption Function....");
//        decrypted(a,b,x,p);        
        return emsg;
    }


    public String decrypted(String msg, String x, String p){
    	String[] dmsg =msg.split("[,]",0);
		BigInteger a1= new BigInteger(dmsg[0]);
		BigInteger b1= new BigInteger(dmsg[1]);
         // Decrypt the message
    	BigInteger x1 = new BigInteger(x);
    	BigInteger p1 = new BigInteger(p);
         BigInteger m = b1.divide(a1.modPow(x1, p1));
         String decryptedMessage = new String(m.toByteArray());
         
         // Print the decrypted message
         return decryptedMessage;
    }
}
