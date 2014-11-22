/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;

import util.DBHelper;
import util.Encryptor;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

import entity.User;

/**
 *
 * @author Edwin Malek
 */
public class UserManager {

    DBHelper db;

    public UserManager() throws Exception {
        this.db = new DBHelper();
    }

    /**
     *
     * @param user
     * @return the userId that just created or -1 if error
     */
    public int createUser(User user) throws Exception {
        try {
            String sql = "select * from users where email = '" + user.email + "' limit 1; ";
            ResultSet rs = this.db.getSQLResult(sql);
            while (rs.next()) {
                return -1;
            }
            sql = "insert into users (email, password, role) values('"
                    + user.email + "', '" + user.password + "', " + "1)";

            return this.db.executeSQL(sql).get(0);
        } catch (Exception ex) {
            throw ex;
        }
    }

   

    /**
     * get the userInfo by an id
     *
     * @param id
     * @return user or null
     * @throws Exception
     */
    public User getUsersById(int id) throws Exception {
        User user = null;
        String sql = "select * from users where idusers = " + id;
        ResultSet rs = this.db.getSQLResult(sql);
        while (rs.next()) {
            user = new User();
            user.userid = id;
            user.email = rs.getString("email");
            user.password = rs.getString("password");
            user.role = rs.getInt("role");
            user.firstname = rs.getString("firstname");
            user.lastname = rs.getString("lastname");
         
        }
        return user;
    }

    public List<User> getUsersByRole(int role) throws Exception {
        List<User> userList = new ArrayList<User>();
        String sql = "select * from users where role = " + role;
        ResultSet rs = this.db.getSQLResult(sql);
        while (rs.next()) {
            User user = new User();
            user.userid = rs.getInt("idusers");
            user.email = rs.getString("email");
            user.password = rs.getString("password");
            user.role = role;
            user.firstname = rs.getString("first_name");
            user.lastname = rs.getString("last_name");
       
            userList.add(user);
        }
        return userList;
    }

//     public List<LocationInfo> listAll() throws Exception {
//        List<LocationInfo> locationLst = new ArrayList<LocationInfo>();
//        String sql = "select * from location";
//        ResultSet rs = this.db.getSQLResult(sql);
//        while (rs.next()) {
//            LocationInfo info = new LocationInfo();
//            info.id = rs.getInt("id");
//            info.addressLine1 = rs.getString("addr_line1");
//            info.addressLine2 = rs.getString("addr_line2");
//            info.city = rs.getString("city");
//            info.state = rs.getString("state");
//            info.zip = rs.getString("zip");
//            locationLst.add(info);
//        }
//        return locationLst;
//    }
    /**
     *
     * @param email
     * @param password
     * @return user or null if wrong email or password
     * @throws Exception
     */
    public User getUser(String email, String password) throws Exception {
        User user = null;
        String sql = "select * from users where email = '" + email + "' and password = '" + password + "';";
        ResultSet rs = this.db.getSQLResult(sql);
        while (rs.next()) {
            user = new User();
            user.userid = rs.getInt("idusers");
            user.email = rs.getString("email");
            user.password = rs.getString("password");
            user.role = rs.getInt("role");
            user.firstname = rs.getString("firstname");
            user.lastname = rs.getString("lastname");
          
        }
        return user;
    }

    /**
     * if user is member, then update user record during reservation to save
     * personal information
     *
     * @param UserInfo
     * @return user id
     */
    public void updateUser(User info) throws SQLException {

        try {
            String sql = "UPDATE users SET  first_name = '" + info.firstname + "', last_name = '"
                    + info.lastname +  "' WHERE idusers =" + info.userid;

            this.db.executeSQL(sql);
        } catch (SQLException ex) {
            throw ex;
        }
    }
    /**
    * if user is member, then update user record during 
    * reservation to save personal information
    * @param UserInfo
    * @return user id
    */
    
    
    public int updateUserInfo(User info){
    
        try{
            String passwordQueryPart ="";
            Encryptor encryptor = new Encryptor();
            if(!info.password.equals(""))
            {
                info.password = encryptor.getMD5Str(info.password);
                passwordQueryPart="',password='"+info.password;
            }
            
        String sql = "UPDATE user SET email='"+info.email+passwordQueryPart + "',first_name = '" +info.firstname+ "', last_name = '" 
                     +info.lastname + "' WHERE idusers =" + info.userid;
       
       this.db.executeSQL(sql);
       return 0;
        } catch (Exception ex) {
            return -1;
        }
    }

    public int deleteUserById(int id) throws Exception {
        try {


            String sql = "delete from user where idusers = " + id;
            this.db.executeSQL(sql);
            return 1;
        } catch (Exception e) {
            throw e;
        }
    }
}
