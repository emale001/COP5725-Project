package entity;

public class Product {
 private int iditem;
 private String name;
 private String description;
 private double price;
 private int category;
 private String imagepath;
 
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

public int getCategory() {
	return category;
}

public void setCategory(int category) {
	this.category = category;
}
 
}
