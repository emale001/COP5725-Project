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
                <table class="table table-condensed" style="margin-left: 10px">
                    <tr>
                        <th></th>
                        <th> Name</th>
                      <!--   <th> Description</th>  -->
                        <th> Price </th>

                        <th> Category</th>
                      	<th>Quantity </th>
                      	<th>Total Price </th>
                        <th></th>
                        <th></th>
                        
                    </tr>
                    <%
                        try {
                            String action = request.getParameter("action");
                            ProductManager mngr = new ProductManager();
                            CartManager cmgr = new CartManager();
                            List<Product> productlist = null;
                           
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            if (action == null) {
                            	System.out.println(action+user.email+"displaying cart first time");
                            	if (user != null) {
                           		 System.out.println(action);
                           		//int iditem = Integer.parseInt(request.getParameter("iditem"));
                           
                           	 productlist = cmgr.getUserShoppingCart(user);
                           	 
                            	}
                           	  	productlist = cmgr.getUserShoppingCart(user);
                           	 
                           	}
                            	
                                //productlist = cmgr.getUserShoppingCart(user);
                            
                             else if (action.equals("deletefromcart")) {
                            	if (user != null) {
                            		 System.out.println(action);
                            		//int iditem = Integer.parseInt(request.getParameter("iditem"));
                            	int idcartitem = Integer.parseInt(request.getParameter("idcartitem"));
                            	 int exist = cmgr.deleteFromCart(idcartitem);
                            	 productlist = cmgr.getUserShoppingCart(user);
                            	}
                            	/*  else {
                            		 out.println(action+ ": item is already in your cart");
                            		 productlist = mngr.listAll();
                            	 } */
                            	}
                             else if (action.equals("updatecart")){
                            	 System.out.println(action);
                            	
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
                              
                              productlist = mngr.listAll();
                                response.sendRedirect("view_products.jsp");
                            	}
                             
                            Iterator<Product> itr = productlist.iterator();
                            double checkoutprice = 0;
                            while (itr.hasNext()) {
                                info = itr.next();
                                
                           
                                 out.print(
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
                                        + "<td> <button class=\"btn btn-danger\" name=\"action\" value=\"deletefromcart\" type=\"submit\">Delete from cart</button></td>"
                                          + "<td> <button class=\"btn btn-default\" name=\"action\" value=\"updatecart\" type=\"submit\">Update Price</button></td>" 
                                        + "</tr>"
                                        + "</form>"); 
                                 
                                 checkoutprice += info.getTotalprice();
                            }
                            out.println("<tr> <td> <p><h4>Check out price: </p> $"+ checkoutprice +"</h4> </td></tr> <tr> <td> <button class=\"btn btn-primary\" name=\"action\" value=\"checkout\" type=\"submit\">Check Out</button></td> </tr>");
                           
                        } catch (Exception e) {
                        	System.err.println( e + " error exeption caught here!!!");
                        }
                    %>
                </table>
                <!-- <button type="submit"  name="action" value="updatecart" class="btn btn-default">Update Prices</button> -->
                <%-- <label name="checkoutprice" value="$<%=checkoutprice %>"> </label> --%>
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
