package manager;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sound.midi.MidiDevice.Info;

import util.DBHelper;
import entity.Bid;

public class BiddingManager {
	DBHelper db;

    public BiddingManager() throws Exception {
        this.db = new DBHelper();
    }


    
    public List<Bid> listAll() throws Exception {
//    	Cart cart = null;
    	List<Bid> biddingList = new ArrayList<Bid>();
    	String sql = "select bid_id, bid_items.product_id, bid_items.user_id, name, description, bid_items.high_bid, cname, imagepath, time_initiated"
    			+ " from bid_items , items, category  where bid_items.product_id = items.idItems and category.idCategory = items.category";
    	ResultSet rs = this.db.getSQLResult(sql);
    	while (rs.next()) {
    		Bid info = new Bid();
    		
    		info.setUserID(rs.getInt("user_id"));
    		info.setBidID(rs.getInt("bid_id"));
    		info.setIditem(rs.getInt("product_id"));
    		info.setCategory(rs.getString("cname")); 
    		info.setDescription(rs.getString("description")); 
    		info.setImagepath(rs.getString("imagepath")); 
    		info.setName(rs.getString("name")); 
    		info.setPrice(rs.getDouble("high_bid"));
    		info.setDate(rs.getString("time_initiated"));
    		biddingList.add(info);
    		}
    		return biddingList;
    }
    
    public Boolean placeBid(String bidID, String newBid, int userID) throws Exception {
    	double i = Double.parseDouble(newBid);
    	i++; // Current price change is by $1.
    	String sql = "update bid_items set second_bid = high_bid, high_bid = '" + i 
    			+ "', second_user_id = user_id, user_id = '" + userID + "' where bid_id = '" + bidID + "'";
    	this.db.executeSQL(sql);
    	return true;
    }

}
