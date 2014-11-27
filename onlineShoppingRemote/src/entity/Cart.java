package entity;

import java.util.ArrayList;

public class Cart {

	private User user;
	private ArrayList<Product> listofitems;
	private ArrayList<Integer> listofitemids;
	
	public Cart() {
		listofitems = new ArrayList<Product>();
		listofitemids = new ArrayList<Integer>();
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public ArrayList<Product> getListOfItems() {
		return listofitems;
	}
	public void setListOfItems(ArrayList<Product> list) {
		this.listofitems = list;
	}
	
	public void setListOfItemIds (ArrayList<Integer> list) {
		this.listofitemids= list;
	}
	
	public ArrayList<Integer> getListIds (){
		return this.listofitemids;
	}
	
	public void addItem (Product item){
		this.listofitems.add(item);
	}
	
	public void addItem(Integer item) {
		this.listofitemids.add(item);
	}
	
	public Product getItem (int index) {
		return this.listofitems.get(index);
	}
	
	public void removeItem (int index) {
		this.listofitems.remove(index);
	}
	
	public void removeItem (Product item) {
		this.listofitems.remove(item);
	}
	
	public void removeId (Integer itemid) {
		this.listofitemids.remove(itemid);
	}
	
	public boolean contains (Product item) {
		return this.listofitems.contains(item);
	}
	
	public boolean contains (Integer id) {
		return this.listofitemids.contains(id);
		
	}
	 
	public boolean isEmpty() {
		return this.listofitemids.isEmpty() && this.listofitems.isEmpty();
	}
	
}
