/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Edwin Malek
 */
public class CreditCard{
    private int id;
    private String number;
    private String expiration_date;
    private String security_code;
    private String name_on_card;
    private String card_type;
    private String zip_code;
    private String state;
    private String month;
    private String year;
    private String address;
    private String fulladdress;
    private String city;
    
    private int user_id;
    
    public void setCity(String city) {
    	this.city = city;
    }
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getSecurity_code() {
		return security_code;
	}
	public void setSecurity_code(String security_code) {
		this.security_code = security_code;
	}
	public String getExpiration_date() {
		return this.expiration_date;
	}
	public void setExpiration_date(String month, String year) {
		this.month = month;
		this.year = year;
		this.expiration_date = this.month+"/"+this.year;
	}
	public void setExpiration_date(String expiration_date) {
		
		this.expiration_date = expiration_date;
	}
	public String getName_on_card() {
		return name_on_card;
	}
	public void setName_on_card(String name_on_card) {
		this.name_on_card = name_on_card;
	}
	public String getCard_type() {
		return card_type;
	}
	public void setCard_type(String card_type) {
		this.card_type = card_type;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFulladdress() {
		return fulladdress;
	}
	public void setFulladdress(String fulladdress) {
		this.address = fulladdress;
	}
	public void setFulladdress(String address, String city, String state, String zipcode) {
		this.address = address;
		this.state = state;
		this.city = city;
		this.zip_code = zipcode;
		this.fulladdress = this.address +"," + this.city +","+ this.state +" "+ this.zip_code;
	}
}
