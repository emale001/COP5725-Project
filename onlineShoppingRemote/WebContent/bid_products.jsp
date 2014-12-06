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

<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Bids" />  
    <jsp:param name="subTitle" value="We strive to provide the best service." />  
</jsp:include>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="entity.Product"%> 
<%@page import="entity.Cart"%> 
<%@page import="entity.Bid"%> 
<%@page import= "manager.ProductManager"%>
<%@page import= "manager.CartManager"%>
<%@page import= "manager.BiddingManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

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
                        <th> Name</th>
                        <th> Description</th> 
                        <th> Current Bid </th>

                        <th> Category</th>
                        <th> Time Left</th>
                      
                        <th></th>
                    </tr>
                    <%
                        try {
                            String action = request.getParameter("action");
                            String price = request.getParameter("bidPrice");
                            String bid_id = request.getParameter("bid_id");
                            String user_id = request.getParameter("currentUser");
                            
                            User user = (User) session.getAttribute("user");
                            BiddingManager mngr = new BiddingManager();
                            
                            List<Bid> bidlist = null;
                            Bid info = null;
                            System.out.println(action);
                            session = request.getSession();
                            
                            Cart cart = (Cart) session.getAttribute("shoppingcart");
                           
                            bidlist = mngr.listAll();
                            
                            Iterator<Bid> itr2 = bidlist.iterator();
                            while (itr2.hasNext()) {
                                info = itr2.next();
                                
                                String timeLeft = "";
                                Calendar cal = Calendar.getInstance();
                                String[] bidTimeInfo = info.getDate().split(" ");
                                String[] bidDate = bidTimeInfo[0].split("-");
                                String[] bidTime = bidTimeInfo[1].split(":");
                                
                                Calendar day = Calendar.getInstance();
                                day.set(Integer.parseInt(bidDate[0]), Integer.parseInt(bidDate[1])-1, Integer.parseInt(bidDate[2]),
                                		Integer.parseInt(bidTime[0]), Integer.parseInt(bidTime[1]), (int)Double.parseDouble(bidTime[2]));
                                
                                // Time until the bidding closes: 24 hours.
                                day.add(Calendar.DAY_OF_MONTH, 1);
                                
                                if(day.before(cal))
                                	timeLeft = "Bidding Over";
                                else
                                {	
                                	long totalSeconds = (day.getTimeInMillis() - cal.getTimeInMillis())/1000;
                                	long s = totalSeconds % 60;
                                	long m = (totalSeconds / 60) % 60;
                                	long h = (totalSeconds / (60*60)) % 24;
                                	timeLeft =  h + ":" + m + ":" + s;
                                }
                                if (!timeLeft.equals("Bidding Over"))
                                 out.print(
                                        "<form method=\"post\">"
                                        + "<tr>"
                                        + "<td> <img src=" + "\"" + info.getImagepath() + "\"" + " style=\"width:140px;height:100px;\">"
                                        + "<td>" + info.getName() + "</td>"
                                        + "<td>" + info.getDescription() + "</td>"
                                        + "<td>" + "$" + (int)info.getPrice() + "</td>"
                                        + "<td>" + info.getCategory() + "</td>"
                                        + "<td>" + timeLeft + "</td>"
                                        + "<input type=\"hidden\" name=\"bid_id\" value=\"" + info.getBidID() + "\">"
                                        + "<input type=\"hidden\" name=\"bidPrice\" value=\"" + info.getPrice() + "\">"
                                        + "<input type=\"hidden\" name=\"currentUser\" value=\"" + info.getUserID() + "\">"
                                        + "<td> <button class=\"btn btn-success\" name=\"action\" value=\"bidded\" type=\"submit\"><i class=\"icon-trash icon-white\"></i>Bid</button></td>"
                                        + "</tr>"
                                        + "</form>"); 
                                else
                                	out.print(
                                        "<form method=\"post\">"
                                        + "<tr>"
                                        + "<td> <img src=" + "\"" + info.getImagepath() + "\"" + " style=\"width:140px;height:100px;\">"
                                        + "<td>" + info.getName() + "</td>"
                                        + "<td>" + info.getDescription() + "</td>"
                                        + "<td>" + "$" + (int)info.getPrice() + "</td>"
                                        + "<td>" + info.getCategory() + "</td>"
                                        + "<td>" + timeLeft + "</td>"
                                        + "<input type=\"hidden\" name=\"bid_id\" value=\"" + info.getBidID() + "\">"
                                        + "<input type=\"hidden\" name=\"bidPrice\" value=\"" + info.getPrice() + "\">"
                                        + "<input type=\"hidden\" name=\"currentUser\" value=\"" + info.getUserID() + "\">"
                                        + "</tr>"
                                        + "</form>"); 
                                 
                            }
                            if(action != null && action.equals("bidded"))
                            {
                            	// Someone has bidded.
                            	if(user == null)
                            		out.println("<div class='alert pull-right' style='margin:0px 130px 0px 20px;'>"
                                            + "<button type='button' class='close' data-dismiss='alert'>&times;</button>Unable to bid. you must be logged in.</div>");
                            	else
                            	{
                            		if( user.userid == (Integer.parseInt(user_id)))
                          				{
                            			out.println("<div class='alert pull-right' style='margin:0px 130px 0px 20px;'>"
                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>You are currently the highest bidder.</div>");
                          				}
                            		else
                            		{
                            			mngr.placeBid(bid_id, price, user.userid);
                            			//response.sendRedirect("bid_products.jsp");
                            		}
                            	}
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
<script>
    $(document).ready(function(){
        $("#index_tab").removeClass("red_underscore");
        $("#bidproduct_tab").addClass("red_underscore");
    });
</script>
<%@include file="jspf/footer.jspf" %>