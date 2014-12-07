<%-- 
    Document   : manage_car.jsp
    Created on : Oct 29, 2013, 4:25:02 PM
    Author     : edwin
--%>
<%-- <%@page import="Entity.CarTypeInfo"%>
<%@page import="Manager.CarTypeManager"%>
<%@page import="Entity.LocationInfo"%>
<%@page import="Manager.LocationManager"%> --%>
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
    <jsp:param name="title" value="Products" />  
    <jsp:param name="subTitle" value="We strive to provide the best service." />  
</jsp:include>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<%@page import="entity.Product"%> 
<%@page import="entity.Cart"%> 
<%@page import= "manager.ProductManager"%>
<%@page import= "manager.CartManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%-- <%@page import="Manager.UserManager"
<%-- <%@page import="Manager.UserManager"%>
<%@page import="Entity.Product"%> --%>
<script>
    // init the datetimepicker and validationEngine
    $(document).ready(function() {

        $('#insertemployee_form').validationEngine('attach',
                {
                    promptPosition: "topLeft",
                    scroll: false,
                    autoHidePrompt: true
                });
        $('#search_form').validationEngine('attach',
                {
                    promptPosition: "topLeft",
                    scroll: false,
                    autoHidePrompt: true
                });

    });

</script>
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
                <table class="table" style="margin-left: 10px">
                    <tr>
                        <th></th>
                        <th> name</th>
                        <th> description</th> 
                        <th> price </th>

                        <th> category</th>
                      
                        <th></th>
                    </tr>
                    <%
                        try {
                            String action = request.getParameter("action");
                            ProductManager mngr = new ProductManager();
                            CartManager cmgr = new CartManager();
                           	List<Product> productlist = null;
                        	Cart cart = null;
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            cart = (Cart) session.getAttribute("shoppingcart");
                           
                           
                      
                            if (action == null) {
                            	if (user != null) {

                                productlist = mngr.listAll();
                            	}
                            	else {
                            		 productlist = mngr.listAll();
                            		// session.removeAttribute("shoppingcart");
                            		// cart.getListIds().clear();
                            		// cart.getListOfItems().clear();
                            	}	
                        	} 
                            else if (action.compareTo("addtocart") == 0) {
                            	String msg = "";
                            	if (user != null) {
                            		 System.out.println(action+ user + "user != null");
                            		int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	 int exist = cmgr.insertInCart(iditem, user);
                            	 if (exist != -1){
                            	 out.println(action+ ": item has been added to your cart");
                            	 productlist = mngr.listAll();
                            	 }
                            	 else {
                            		 out.println(action+ ": item is already in your cart");
                            		 productlist = mngr.listAll();
                            	 }
                            	}
                            	else {
                            
                            		if (cart == null ){
                            			cart = new Cart();
                            			System.out.println("cart is null");
                            		}
                            		
                            	int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	/* String name, description, imagepath;
                            	int category */
                            	String name, description, imagepath, category;
                            	int idcategory = Integer.parseInt(request.getParameter("idcategory"));
                            	//int quantity = Integer.parseInt(request.getParameter("quantity"));
                            	int quantity = 1;
                            	int cartid = Integer.parseInt(request.getParameter("cartid"));
                            	 int index = Integer.parseInt(request.getParameter("index")); //just added 11/27/14
                            	double price = Double.parseDouble(request.getParameter("price"));
                            	double totalprice = Double.parseDouble(request.getParameter("totalprice"));
                            	name = request.getParameter("name").toString();
                            	description = request.getParameter("description").toString();
                            	imagepath = request.getParameter("imagepath").toString();
                            	category = request.getParameter("category").toString();
                            	Product item = new Product (iditem, name, description, price, idcategory, imagepath, quantity, cartid, category);
                            	
                            	if (/*!cart.contains(iditem) && */ !cart.contains(item)) {
                            		
                                	
                            		//System.out.println("info" + session.getAttribute("item").toString());
                            		cart.addItem(iditem);
                            		cart.addItem(item);
                            		//cart.getListIds().add(index, iditem);
                            		//cart.getListOfItems().add(index, item);
                            		msg = " : item has been added to your cart";
                            		session = request.getSession();
                                    session.setAttribute("shoppingcart", cart);
                                    
                            	}
                            	else {
                            		msg = ": Item is already in your cart";
                            	}
                            	//System.out.println(action + cart + "user is null");
                            	out.println(action+ msg);
                              
                             	productlist = mngr.listAll();
                                //response.sendRedirect("view_products.jsp");
                            	}
                            } 
                            Iterator<Product> itr2 = productlist.iterator();
                            int index = 0;
                            while (itr2.hasNext()) {
                                info = itr2.next();
                                
                             /*    out.print(
                                		"<form method=\"post\">"
                                		+"<div class=\"row\">"
                                		+ "<div class=\"col-sm-6 col-md-4\">"
                                		+ " <div class=\"thumbnail\">"
                                		+ "<img src=\"" +info.getImagepath()+"\" alt=\"...\">"
                                		+ "<div class=\"caption\">"
                                		+ "<h3>"+info.getDescription()+" "+info.getName()+"</h3>"
                                		+ "<p> $"+ info.getPrice()+"</p>"
                                		+ "<p><button class=\"btn btn-primary\" name=\"action\" value=\"addtocart\" type=\"submit\">add To Cart</button> <button class=\"btn btn-default\" name=\"action\" value=\"bid\" type=\"submit\">Bid</button</p>"
                                		+ + "<input type=\"hidden\" name=\"id\" value=\"" + info.id + "\">"
                                		 + " </div>"
                                		 +  "</div>"
                                		 + "</div>"
                                		 + "</div>"
                                		 + "</form>" ); */
                                		    
                                		      
                                		       
                                		        
                                		        
                                		     
                                		   
                                		
                                		
                                 out.print(
                                        "<form method=\"post\">"
                                        + "<tr>"
                                        + "<td> <img src=" + "\"" + info.getImagepath() + "\"" + " style=\"width:140px;height:100px;\">"
                                        + "<td>" + info.getName() + "</td>"
                                        + "<td>" + info.getDescription() + "</td>"
                                        + "<td>" + info.getPrice() + "</td>"
                                        + "<td>" + info.getCategory() + "</td>"
                                        + "<input type=\"hidden\" name=\"iditem\" value=\"" + info.getIditem() + "\">"
                                         + "<input type=\"hidden\" name=\"name\" value=\"" + info.getName() + "\">"
                                         + "<input type=\"hidden\" name=\"description\" value=\"" + info.getDescription() + "\">"
                                         + "<input type=\"hidden\" name=\"price\" value=\"" + info.getPrice() + "\">"
                                        + "<input type=\"hidden\" name=\"idcategory\" value=\"" + info.getCategoryId() + "\">"
                                        + "<input type=\"hidden\" name=\"imagepath\" value=\"" + info.getImagepath() + "\">"
                                        + "<input type=\"hidden\" name=\"totalprice\" value=\"" + info.getTotalprice() + "\">"
                                        + "<input type=\"hidden\" name=\"quantity\" value=\"" + info.getQuantity() + "\">"
                                        + "<input type=\"hidden\" name=\"cartid\" value=\"" + info.getCartid() + "\">"
                                        + "<input type=\"hidden\" name=\"index\" value=\"" + index + "\">"
                                        + "<input type=\"hidden\" name=\"category\" value=\"" + info.getCategory() + "\">"
                                        + "<td> <button class=\"btn btn-success\" name=\"action\" value=\"addtocart\" type=\"submit\"><i class=\"icon-trash icon-white\"></i>Add To Cart</button></td>"
                                        + "</tr>"
                                        + "</form>"); 
                                		 
                                		 
                                		// request.setAttribute("item", info); 
                                		 index++;
                            }
                        } catch (Exception e) {
                        	System.err.println(e +" after while view_products.jsp");
                        }
                    %>
                </table>
            </form>
        </div>
        
        
      
	
         
        
        
     
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $("#index_tab").removeClass("red_underscore");
        $("#product_tab").addClass("red_underscore");
    });
</script>




<%@include file="jspf/footer.jspf" %>
