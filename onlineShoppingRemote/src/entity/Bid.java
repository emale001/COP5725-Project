package entity;

import java.sql.Date;

public class Bid {
	private int bidID;
	private int iditem;
	private int userID;
	private String name;
	private String description;
	private double price;
	private String category;
	private String imagepath;
	private String dt;
	 
	public Bid () {
	}

	public int getBidID() {
		return bidID;
	}

	 public void setBidID(int bidID) {
		 this.bidID = bidID;
	 }
 
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	
	public int getIditem() {
		return iditem;
	}
	
	public void setIditem(int iditem) {
		this.iditem = iditem;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public double getPrice() {
		return price;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getImagepath() {
		return imagepath;
	}
	
	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public void setDate(String d){
		this.dt = d;
	}
	
	public String getDate(){
		return this.dt;
	}
}
