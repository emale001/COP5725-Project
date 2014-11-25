package entity;

import java.util.ArrayList;

public class Cart {

	private User user;
	private ArrayList<Integer> listofitemids;
	
	public Cart() {
		listofitemids = new ArrayList<Integer>();
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public ArrayList<Integer> getList() {
		return listofitemids;
	}
	public void setList(ArrayList<Integer> list) {
		this.listofitemids = list;
	}
	
	public void addItem (Integer item){
		this.listofitemids.add(item);
	}
	
	public boolean contains (Integer item) {
		return this.listofitemids.contains(item);
	}
	
}
