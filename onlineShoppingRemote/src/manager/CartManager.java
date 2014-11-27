package manager;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sound.midi.MidiDevice.Info;

import util.DBHelper;
import entity.Cart;
import entity.Product;
import entity.User;

public class CartManager {
	DBHelper db;

    public CartManager() throws Exception {
        this.db = new DBHelper();
    }


    
    public List<Product> getUserShoppingCart(User user) throws Exception {
//    	Cart cart = null;
    	List<Product> shoppingcart = new ArrayList<Product>();
    	String sql = "select idcartitems, cartitems.iditems, name, description, price, Category.cname, imagepath, quantity"
    			+ " from cartitems , items, Category  where cartitems.iditems = items.idItems AND items.category = Category.idCategory"
    			+ " AND cartitems.idusers =" + user.userid ;
    	ResultSet rs = this.db.getSQLResult(sql);
    	while (rs.next()) {
    		Product info = new Product();
    		
    		info.setIditem(rs.getInt("iditems"));
    		//info.setCategoryId(rs.getInt("category")); 
    		info.setDescription(rs.getString("description")); 
    		info.setImagepath(rs.getString("imagepath")); 
    		info.setName(rs.getString("name")); 
    		info.setPrice(rs.getDouble("price"));
    		info.setQuantity(Integer.parseInt(rs.getString("quantity")));
    		info.setCartid(rs.getInt("idcartitems"));
    		info.setCategory(rs.getString("cname")); 
    		shoppingcart.add(info);
    		}
    		return shoppingcart;
}
    
//    public List<Product> getUserShoppingCart(User user) throws Exception {
////    	Cart cart = null;
//    	List<Product> shoppingcart = new ArrayList<Product>();
//    	String sql = "select idcartitems, cartitems.iditems, name, description, price, category, imagepath, quantity"
//    			+ " from cartitems , items  where cartitems.iditems = items.idItems AND cartitems.idusers =" + user.userid ;
//    	ResultSet rs = this.db.getSQLResult(sql);
//    	while (rs.next()) {
//    		Product info = new Product();
//    		
//    		info.setIditem(rs.getInt("iditems"));
//    		info.setCategory(rs.getInt("category")); 
//    		info.setDescription(rs.getString("description")); 
//    		info.setImagepath(rs.getString("imagepath")); 
//    		info.setName(rs.getString("name")); 
//    		info.setPrice(rs.getDouble("price"));
//    		info.setQuantity(Integer.parseInt(rs.getString("quantity")));
//    		info.setCartid(rs.getInt("idcartitems"));
//    		shoppingcart.add(info);
//    		}
//    		return shoppingcart;
//}
    
    
    public int insertInCart(int iditem, User user) throws Exception {
        try {
        	
            String sql = "select * from cartitems where idusers = "+user.userid+" AND iditems = '" + iditem + "' limit 1; ";
            ResultSet rs = this.db.getSQLResult(sql);
            while (rs.next()) {
                return -1;
            }
            sql = "insert into cartitems (idusers, iditems) values('"
                    + user.userid + "', '" + iditem + "')";

            return this.db.executeSQL(sql).get(0);
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    
    public int deleteFromCart(int iditem, User user) throws Exception {
    	try {
            String sql = "delete from cartitems where idusers = "+user.userid+" and iditems =" + iditem;
            this.db.executeSQL(sql);
            return 1;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public int deleteFromCart(int idcartitem) throws Exception {
    	try {
            String sql = "delete from cartitems where idcartitems = "+ idcartitem;
            this.db.executeSQL(sql);
            return 1;
        } catch (Exception e) {
            throw e;
        }
    }
    public void updateCartQuantity(int quantity, int iditem, User user, int idcartitem) throws SQLException {

        try {
            String sql = "UPDATE cartitems SET quantity ="+ quantity+ " "+ "WHERE idusers = "+user.userid
            		+" and idcartitems="+idcartitem+ " and iditems =" + iditem;

            this.db.executeSQL(sql);
        } catch (SQLException ex) {
            throw ex;
        }
    }

}
