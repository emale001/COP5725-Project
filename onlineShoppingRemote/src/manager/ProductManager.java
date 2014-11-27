package manager;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Product;
import util.DBHelper;

public class ProductManager {
	 DBHelper db;

	    public ProductManager() throws Exception {
	        this.db = new DBHelper();
	    }

    
	    
	    public List<Product> listAll() throws Exception {
  List<Product> productlist = new ArrayList<Product>();
  String sql = "select iditems, name, description, price, Category.cname, imagepath from items , Category Where items.category = Category.idCategory";
  ResultSet rs = this.db.getSQLResult(sql);
  while (rs.next()) {
     Product info = new Product();
      info.setIditem(rs.getInt("iditems"));
    // info.setCategoryId(rs.getInt("category")); 
     info.setDescription(rs.getString("description")); 
     info.setImagepath(rs.getString("imagepath")); 
     info.setName(rs.getString("name")); 
     info.setPrice(rs.getDouble("price"));
     info.setCategory(rs.getString("cname")); 
     productlist.add(info);
  }
  return productlist;
}
	    
	    
}
