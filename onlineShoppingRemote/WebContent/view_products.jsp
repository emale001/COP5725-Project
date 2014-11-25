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
                        	//Cart cart = null;
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            Cart cart = (Cart) session.getAttribute("shoppingcart");
                           
                      
                            if (action == null) {

                                productlist = mngr.listAll();
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
                            		}
                            		
                            	int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	if (!cart.contains(iditem)) {
                            		cart.addItem(iditem);
                            		msg = " : item has been added to your cart";
                            		//session = request.getSession();
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
                                        + "<td> <button class=\"btn btn-success\" name=\"action\" value=\"addtocart\" type=\"submit\"><i class=\"icon-trash icon-white\"></i>Add To Cart</button></td>"
                                        + "</tr>"
                                        + "</form>"); 
                            }
                        } catch (Exception e) {
                        	System.err.println(e +"");
                        }
                    %>
                </table>
            </form>
        </div>
        
        
      <!--   <div class="row">
  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img src="image/product/lotto-sports-shoes-white-210x210.jpg" alt="...">
      <div class="caption">
        <h3>Thumbnail label</h3>
        <p>...</p>
        <p><a href="#" class="btn btn-primary" role="button">add To Cart</a> <a href="#" class="btn btn-default" role="button">Bid</a></p>
      </div>
    </div>
  </div>
</div> -->
      <!--   <div class="span9" style="height:auto;border:0px solid;">
            <div class="span9" style="margin-top:20px;font-weight:900;margin-bottom:20px;">Add a new employee</div>
            <form id ="insertemployee_form" class="form-horizontal" style="margin-top: 20px" method="post">

                <div class="control-group">
                    <label class="control-label" for="inputFistName">First Name</label>
                    <div class="controls">
                        <input type="text" class ="validate[required, custom[onlyLetterSp], minSize[1]]"id="inputEmail" name="firstname" placeholder="First Name">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputLastName">Last Name</label>
                    <div class="controls">
                        <input type="text" class ="validate[required, custom[onlyLetterSp], minSize[1]]" id="inputPassword" name="lastname" placeholder="Last Name">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputDOB">Date of Birth</label>
                    <div class="controls">
                        <input type="text" class ="validate[required, custom[date]]" id="inputEmail"  name="dob" placeholder="i.e. YYYY-MM-DD">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputRole">Role</label>
                    <div class="controls">
                        <input type="text" class ="validate[required, custom[number], minSize[1], maxSize[1]]"id="inputPassword" name="role" placeholder="Role">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">Email</label>
                    <div class="controls">
                        <input type="text" class ="validate[required, custom[email]]"id="inputPassword" name="email" placeholder="Email">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputPassword">Password</label>
                    <div class="controls">
                        <input type="password" class ="validate[required, minSize[8]]" id="inputPassword" name="password" placeholder="Password">
                    </div>
                </div>
                <div class="text-center span7" style="margin-bottom: 20px">
                    <button class="btn btn-primary"  type="submit" name="action" value="insertemployee">Submit</button>
                </div>              -->
                
              <%--   <%
                    try {
                        String action = request.getParameter("action");
                        if (action != null) {
                            if (action.compareTo("insertemployee") == 0) {
                                String firstname = request.getParameter("firstname");
                                String lastname = request.getParameter("lastname");
                                String dob = request.getParameter("dob");

                                int role = Integer.parseInt(request.getParameter("role"));;
                                String email = request.getParameter("email");
                                String password = request.getParameter("password");
                                Encryptor encryptor = new Encryptor();
                                password = encryptor.getMD5Str(password);
                                User user = new User();

                                user.firstname = firstname;
                                user.lastname = lastname;
                              /*   user.dob = dob; */
                                user.role = role;
                                user.email = email;
                                user.password = password;
                               // user.driverLicense = null;

                                UserManager userMngr = new UserManager();
                                int cId = -1;
                          // cId = userMngr.createEmployee(user);

                                // if creation fails, show msg, else go to next step
                                if (cId == -1) {
                                    out.println("insert Employee Failed.");
                                } else {
                                    response.sendRedirect("manage_employee.jsp?cid=");
                                }
                                return;
                            }
                        }
                    } catch (Exception e) {
                    }
                %> --%>
          <!--   </form>
            <div class="span9" style="margin-top: 30px">
                <form id="search_form" class="form-search">
                    <div class="control-group">
                        <label class="control-label" for="inputRole"><b>Search Employee By Role</b></label>
                        <div class="input-append">
                            <input type="text" class="span2 search-query validate[required, custom[number], minSize[1], maxSize[1]]" name="userrole" placeholder="Role">
                            <button type="submit" class="btn" name="action" value="searchbyrole">Search</button>
                        </div>
                    </div>
                </form>
            </div> -->
            <%-- <form method="post">
                <table class="table table-hover" style="margin-left: 10px">
                    <tr>
                        <th> First Name</th>
                        <th> Last Name</th> 
                        <th> Date of Birth </th>
                        <th> Email </th>
                        <th> Role</th>
                        <th></th>
                    </tr>
                    <%
                        try {
                            String action = request.getParameter("action");
                            UserManager mngr = new UserManager();
                            List<User> userList = null;
                            User info = null;
                            if (action == null) {
                                userList = mngr.getUsersByRole(1);
                            } else if (action.compareTo("searchbyrole") == 0) {
                                String role = request.getParameter("userrole");
                                userList = mngr.getUsersByRole(Integer.parseInt(role));
                            } else if (action.compareTo("deleterow") == 0) {
                                String id = request.getParameter("id");
                                mngr.deleteUserById(Integer.parseInt(id));
                                response.sendRedirect("manage_employee.jsp");
                            }

                            Iterator<User> itr2 = userList.iterator();
                            while (itr2.hasNext()) {
                                info = itr2.next();
                                out.print(
                                        "<form method=\"post\">"
                                        + "<tr>"
                                        // + "<td> <img src=" + "\"" + info.imgPath + "\"" + " style=\"width:200px;height:150px;\"" + "class=\"img-polaroid\">"
                                        + "<td>" + info.firstname + "</td>"
                                        + "<td>" + info.lastname + "</td>"
                                    /*     + "<td>" + info.dob + "</td>" */
                                        + "<td>" + info.email + "</td>"
                                        + "<td>" + info.role + "</td>"
                                        + "<input type=\"hidden\" name=\"id\" value=\"" + info.userid + "\">"
                                        // + "<td> <button class=\"btn btn-primary\" name=\"action\" value=\"deleterow\" type=\"submit\">Delete</button></td>"
                                        + "<td> <button class=\"btn btn-danger\" name=\"action\" value=\"deleterow\" type=\"submit\"><i class=\"icon-trash icon-white\"></i>Delete</button></td>"
                                        + "</tr>"
                                        + "</form>");

                            }
                        } catch (Exception e) {
                        }

                    %>
                </table>
            </form> --%>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
