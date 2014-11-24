package entity;

import java.util.ArrayList;

public class Cart {

	private User user;
	private ArrayList<Product> list;
	
	public Cart() {
		list = new ArrayList<Product>();
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public ArrayList<Product> getList() {
		return list;
	}
	public void setList(ArrayList<Product> list) {
		this.list = list;
	}
	
	public void addItem (Product item){
		this.list.add(item);
	}
	
}
