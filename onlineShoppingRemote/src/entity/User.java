/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Edwin Malek
 */
//String hash = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password +"salt");
public class User {
    public String email;
    public String password;
    public int role; // 0= admin, 1 = customers
    public String firstname;
    public String lastname;
    public int userid;
    public int username;
    
    
   

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 43 * hash + (this.email != null ? this.email.hashCode() : 0);
        hash = 43 * hash + (this.password != null ? this.password.hashCode() : 0);
        hash = 43 * hash + this.role;
        hash = 43 * hash + (this.firstname != null ? this.firstname.hashCode() : 0);
        hash = 43 * hash + (this.lastname != null ? this.lastname.hashCode() : 0);
 
        hash = 43 * hash + this.userid;
        return hash;
    }
    
}
       



