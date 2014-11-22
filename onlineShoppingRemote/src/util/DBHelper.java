/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Edwin Malek
 */
public class DBHelper {

    private Statement stmt;
    private Connection conn;
    private String url;
    private String usr;
    private String pwd;

    public DBHelper() throws Exception {
        this.url = "jdbc:mysql://127.0.0.1:3306/ShoppingOnlineDB";
        this.usr = "root";
        this.pwd = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //Class.forName(com.mysql.jdbc.Driver.class.getName());
            this.conn = DriverManager.getConnection(url, usr, pwd);
        } catch (Exception ex) {
            throw ex;
        }
    }

    /**
     * return the resultSet of the sql statement
     *
     * @param sql
     * @return ResultSet
     * @throws SQLException
     */
    public ResultSet getSQLResult(String sql) throws SQLException {
        try {
            this.stmt = this.conn.createStatement();
            ResultSet rs = this.stmt.executeQuery(sql);
            return rs;
        } catch (SQLException ex) {
            System.out.print("[DBHelper]    " + ex.toString());
            throw ex;
        }
    }
    // return the resultSet of the sql statement

    /**
     *
     * @param sql
     * @return newly inserted key
     * @throws SQLException
     */
    public List<Integer> executeSQL(String sql) throws SQLException {
        try {
            this.stmt = this.conn.createStatement();
            this.stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = this.stmt.getGeneratedKeys();
            List<Integer> keyLst = new ArrayList<Integer>();
            if (rs.next()) {
                int key = rs.getInt(1);
                keyLst.add(key);
            }
            return keyLst;
        } catch (SQLException ex) {
            System.out.print("[DBHelper]" + ex.toString());
            throw ex;
        }
    }

    @Override
    protected void finalize() throws SQLException {
        if (this.stmt != null) {
            try {
                this.stmt.close();
            } catch (SQLException ex) {
                throw ex;
            }
        }
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch (SQLException ex) {
                throw ex;
            }
        }
    }
}
