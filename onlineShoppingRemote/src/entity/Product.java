package entity;

public class Product {
 private int iditem;
 private String name;
 private String description;
 private double price;
 private int idcategory;
 private String imagepath;
 private int quantity;
 private double totalprice;
 private int cartid;
 private String category;
 
 public Product (int id, String name, String description, double price, int idcategory, String imagepath, int quantity, int cartid, String category) {
	 this.totalprice = quantity * price;
	 this.name = name;
	 this.description = description;
	 this.price = price;
	 this.idcategory = idcategory;
	 this.imagepath = imagepath;
	 this.quantity = quantity;
	 this.cartid = cartid;
	 this.iditem = id;
	 this.setCategory(category);
 }
 
 public Product () {
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

public int getCategoryId() {
	return idcategory;
}

public void setCategoryId(int idcategory) {
	this.idcategory = idcategory;
}

public int getQuantity() {
	return quantity;
}

public void setQuantity(int quantity) {
	this.quantity = quantity;
}



public double getTotalprice() {
	return this.quantity * this.price;
}

public int getCartid() {
	return cartid;
}

public void setCartid(int cartid) {
	this.cartid = cartid;
}

public boolean equals (Object obj) {
	
	if (obj instanceof Product) {
		Product item = (Product) obj;
		return this.getIditem() == item.getIditem();
	}
	return false;
}

public String getCategory() {
	return category;
}

public void setCategory(String category) {
	this.category = category;
}


 
}
