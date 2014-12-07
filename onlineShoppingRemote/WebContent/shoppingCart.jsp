
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="jspf/header.jspf" %>
<!--
    include the top barner
    please make sure to pass the parameters:
    para: title
    para: subTitle
-->
<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Shopping Cart" />  
    <jsp:param name="subTitle" value="View your shopping cart: update or delete items from your cart" />  
</jsp:include>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="entity.Product"%> 
<%@page import= "manager.ProductManager"%>
<%@page import= "manager.CartManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%-- <%@page import="Manager.UserManager"
<%-- <%@page import="Manager.UserManager"%>
<%@page import="Entity.Product"%> --%>

<div class="container">
    <div class="row">
        <!--
            include the control panel.
            please make sure to pass the parameters:
            para: menuItems
            para: menuLinks
        -->
        <%-- <jsp:include page="jspf/control_panel.jsp">
            <jsp:param name="menuItems" value="Products, Bid Products" />  
            <jsp:param name="menuLinks" value="view_products.jsp,bid_products.jsp" />  
        </jsp:include> --%>
        
         </div>
            <form method="post">
                <table class="table table-condensed" style="margin-left: 10px">
                    <!-- <tr>
                        <th></th>
                        <th> Name</th>
                        <th> Description</th> 
                        <th> Price </th>

                        <th> Category</th>
                      	<th>Quantity </th>
                      	<th>Total Price </th>
                        <th></th>
                        <th></th>
                        
                    </tr> -->
                    <%
                        try {
                            String action = request.getParameter("action");
                            ProductManager mngr = new ProductManager();
                            CartManager cmgr = new CartManager();
                            List<Product> productlist = null;
                           	Cart cart = (Cart) session.getAttribute("shoppingcart");
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            
                            
                            if (action == null) {
                            	System.out.println(action+" shoppingcart.jsp displaying cart first time");
                            	if (user != null) {
                           		 System.out.println(action);
                           		//int iditem = Integer.parseInt(request.getParameter("iditem"));
                           
                           	 	productlist = cmgr.getUserShoppingCart(user);
                           	 
                            	}
                            	
                            	else if  (cart != null /*|| !cart.isEmpty()*/){ 
                            		//ArrayList<Integer> shoppinglist;
                            		System.out.println(action + " dead \"code\"");
                            		//request.getSession();
                            		//cart = (Cart) request.getAttribute("shoppingcart");
                            		productlist = (List<Product>) cart.getListOfItems();
                            	} 
                            	else {
                            		String msg = "You currently has no Items in your Shopping Cart";
                                    out.print("<tr><td><h4>"+msg+ "</h4></td></tr>");
                            	}
                           	  	//productlist = cmgr.getUserShoppingCart(user);
                           	 
                           	}
                            	
                              //  productlist = cmgr.getUserShoppingCart(user);
                            
                             else if (action.equals("deletefromcart")) {
                            	if (user != null) {
                            		 System.out.println(action);
                            		//int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	int idcartitem = Integer.parseInt(request.getParameter("idcartitem"));
                            	 int exist = cmgr.deleteFromCart(idcartitem);
                            	 productlist = cmgr.getUserShoppingCart(user);
                            	}
                            	else {
                            		Product item = new Product ();
                            		String name, description, imagepath;
                                	String category = request.getParameter("category").toString();
                                	//int quantity = Integer.parseInt(request.getParameter("quantity"));
                                	int quantity = 1;
                                	int cartid = Integer.parseInt(request.getParameter("cartid"));
                                	int index = Integer.parseInt(request.getParameter("index")); //just added 11/27/14
                                	double price = Double.parseDouble(request.getParameter("price"));
                                	double totalprice = Double.parseDouble(request.getParameter("totalprice"));
                                	name = request.getParameter("name").toString();
                                	//description = request.getParameter("description").toString();
                                	imagepath = request.getParameter("imagepath").toString();
                            		
                            		 int iditem = Integer.parseInt(request.getParameter("iditem"));
                            		 item.setIditem(iditem);
                            			 
                            			 //cart.removeItem(index);
                            			//cart.getListOfItems().remove(o)
                            			// cart.removeId(iditem);
                            			cart.removeItem(item);
                            			cart.removeId(new Integer (iditem));
                            		
                            		//cart.setListOfItems((ArrayList<Product>)productlist);
                            		productlist = (List<Product>) cart.getListOfItems();
                            		cart.setListOfItems((ArrayList<Product>)productlist);
                            		session.setAttribute("shoppingcart", cart);
                            		// out.println(action+ ": item is already in your cart");
                            		
                            	 }  
                            	}
                             else if (action.equals("updatecart")){
                            	 System.out.println(action);
                            	if (user != null) {
                            	 int quantity = Integer.parseInt(request.getParameter("quantity"));
                            	 System.out.println(quantity);
                            	// request.setAttribute("quantity", quantity);
                            	 int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	 int idcartitem= Integer.parseInt(request.getParameter("idcartitem"));
                            	 cmgr.updateCartQuantity(quantity, iditem, user, idcartitem);
                            	 	
                            	productlist = cmgr.getUserShoppingCart(user);                             
                            	 }
                            	else {
                            	
                                int iditem = Integer.parseInt(request.getParameter("iditem"));
                                int index = Integer.parseInt(request.getParameter("index"));
                                int quantity = Integer.parseInt(request.getParameter("quantity"));
                                cart.getItem(index).setQuantity(quantity);
                              	productlist = (List<Product>) cart.getListOfItems();
                               // response.sendRedirect("view_products.jsp");
                            	}
                             }
                            /*  else if (action.equals("checkout")){
                            	 response.sendRedirect("check_out.jsp");
                            	 return;
                            	 
                             } */
                            
                            if (productlist.size() == 0 || productlist == null) {
                            	String msg = "You currently has no Items in your Shopping Cart";
                    
                            	out.print("<tr><td><h4>"+msg+ "</h4></td></tr>");
                            	
                            }
                            else {
                            Iterator<Product> itr = productlist.iterator();
                            double checkoutprice = 0;
                            out.print(
                           		 "<tr>"
                                   + "<th></th>"
                                   + "<th> Name</th>"
                                 // <!--   <th> Description</th>  -->
                                   + "<th> Price </th>"

                                   + "<th> Category</th>"
                                  	+"<th>Quantity </th>"
                                  	+"<th>Total Price </th>"
                                    +"<th></th>"
                                    +"<th></th>"
                                    
                                +"</tr>");
                            int index = 0;
                            while (itr.hasNext()) {
                                info = itr.next();
                               
                           
                                 out.print(
                                		/*  "<tr>"
                                        + "<th></th>"
                                        + "<th> Name</th>"
                                      // <!--   <th> Description</th>  -->
                                        + "<th> Price </th>"

                                        + "<th> Category</th>"
                                       	+"<th>Quantity </th>"
                                       	+"<th>Total Price </th>"
                                         +"<th></th>"
                                         +"<th></th>"
                                         
                                     +"</tr>" */
                                		 
                                	 	//"<form method=\"post\"" + 
                                       "<form method=\"post\">"
                                        + "<tr>"
                                        + "<td> <img src=" + "\"" + info.getImagepath() + "\"" + " style=\"width:140px;height:100px;\">"
                                        + "<td>" + info.getName() + "</td>"
                                      /*   + "<td>" + info.getDescription() + "</td>" */
                                        + "<td>$" + info.getPrice() + "</td>"
                                        + "<td>" + info.getCategory() + "</td>"
                                        + "<td> <input type=\"text\" class=\"form-control\" name=\"quantity\" value=\"" + info.getQuantity() + "\"></td>"
                                       	+ "<td>$" + info.getTotalprice() + "</td>"
                                        + "<input type=\"hidden\" name=\"iditem\" value=\"" + info.getIditem() + "\">"
                                        + "<input type=\"hidden\" name=\"idcartitem\" value=\"" + info.getCartid() + "\">"
                                       // + "<input type=\"hidden\" name=\"description\" value=\"" + info.getDescription() + "\">"
                                    	+ "<input type=\"hidden\" name=\"name\" value=\"" + info.getName() + "\">"
                                        + "<input type=\"hidden\" name=\"price\" value=\"" + info.getPrice() + "\">"
                                        + "<input type=\"hidden\" name=\"idcategory\" value=\"" + info.getCategoryId() + "\">"
                                        + "<input type=\"hidden\" name=\"imagepath\" value=\"" + info.getImagepath() + "\">"
                                        + "<input type=\"hidden\" name=\"totalprice\" value=\"" + info.getTotalprice() + "\">"
                                        + "<input type=\"hidden\" name=\"quantity\" value=\"" + info.getQuantity() + "\">"
                                        + "<input type=\"hidden\" name=\"cartid\" value=\"" + info.getCartid() + "\">"
                                        + "<input type=\"hidden\" name=\"category\" value=\"" + info.getCategory() + "\">"
                                        
                                        + "<input type=\"hidden\" name=\"index\" value=\"" + index + "\">"
                                        + "<td> <button class=\"btn btn-danger\" name=\"action\" value=\"deletefromcart\" type=\"submit\">Delete from cart</button></td>"
                                          + "<td> <button class=\"btn btn-default\" name=\"action\" value=\"updatecart\" type=\"submit\">Update Price</button></td>" 
                                        + "</tr>"
                                        + "</form>"); 
                                 
                                 
                                 
                                 checkoutprice += info.getTotalprice();
                                 session.setAttribute("checkoutprice", checkoutprice);
                                 index++;
                            }
                            out.println("<form action=\"check_out.jsp\" method=\"post\"> <tr> <td> <p><h4>Check out price: </p> $"+ checkoutprice +"</h4> </td></tr> <tr> <td> <button class=\"btn btn-primary\" name=\"action\" value=\"checkout\" type=\"submit\">Check Out</button></td> </tr> </form>");
                            }
                        
                        } catch (Exception e) {
                        	System.err.println( e + " Shoppingcart.jsp error exeption caught here!!!");
                        }
                    %>
                </table>
                <!-- <button type="submit"  name="action" value="updatecart" class="btn btn-default">Update Prices</button> -->
                <%-- <label name="checkoutprice" value="$<%=checkoutprice %>"> </label> --%>
            </form>
        </div>
        
        
     
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
