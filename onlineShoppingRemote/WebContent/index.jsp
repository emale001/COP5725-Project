<%-- 
    Document   : index
    Created on : Oct 23, 2013, 9:59:02 PM
    Author     : changliu
--%>
<%-- <%@page import="Manager.ReservationManager"%>
<%@page import="Entity.ReservationInfo"%> --%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.Product"%> 
<%@page import= "manager.ProductManager"%>
<%-- <%
    String warningMsg = "";
    try {
        String action = request.getParameter("action");
        // if this request is to create a reservation
        // then create an reservation, redirect to select_cartype.jsp?rid=xxx
        if (action.compareTo("reserve") == 0) {
            // parse parameters from the posted form
            int pickupLoc = Integer.parseInt(request.getParameter("pickupLoc"));
            int dropoffLoc = Integer.parseInt(request.getParameter("dropoffLoc"));
            String pickupDt = request.getParameter("pickupDt");
            String dropoffDt = request.getParameter("dropoffDt");
            String age = request.getParameter("age");
            int carType = Integer.parseInt(request.getParameter("carType"));

            // create a ReservationInfo
          /*   ReservationInfo info = new ReservationInfo(); */
         /*    info.pickupLocation = pickupLoc;
            info.dropoffLocation = dropoffLoc;
            info.pickupDate = pickupDt;
            info.dropoffDate = dropoffDt;
            info.age = age;
            info.carType = carType; */
            String type = request.getParameter("reserveType");
            // if it's guest reservation, set the id to -1
            boolean flag = true;
            if (type.compareTo("guest") == 0) {
              //  info.id = -1;
            } // member reservation, set the id to the user's id
            else {
                // to be done
                try {
                    session = request.getSession();
                    String uidStr = session.getAttribute("uid").toString();
                  //  info.id = Integer.parseInt(uidStr);
                } catch (Exception e) {
                    flag = false;
                    warningMsg = "Please login first";
                    //out.println(e.getMessage());
                }
            }
            
            if (flag) {
                // create the reservation by call the method in RevervationManager
                /* ReservationManager rvMngr = new ReservationManager(); */
                int rId = -1;
            //    rId = rvMngr.createReservation(info);

                // if creation fails, show msg, else go to next step
                if (rId == -1) {
                    warningMsg = "Make reservation failed, try contact administrator.";
                    //out.println("make reservation fails.");
                } else {   
                    session = request.getSession();
                    session.setAttribute("rid", rId);
                    response.sendRedirect("select_cartype.jsp?rid=" + rId);
                }
            }
        }
    } catch (Exception e) {
        // no need to handle the exception.
        System.err.println("exception caught");
    }
%> --%>
<!--include all the libraries needed, as well as the header file-->
<%-- <%@page import="Entity.CarTypeInfo"%>
<%@page import="Manager.CarTypeManager"%> --%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%-- <%@page import="Entity.LocationInfo"%>
<%@page import="Manager.LocationManager"%> --%>
<%@include file="jspf/header.jspf" %>
<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Home" />  
    <jsp:param name="subTitle" value="We strive to provide the best service." />  
</jsp:include>


        
<!--some js functions-->
<!-- <script>
    function createDate(year, month, day, hours)
    {
        var dt = new Date();
        dt.setYear(year + 1900);
        dt.setMonth(month);
        dt.setDate(day);
        dt.setHours(hours);
        dt.setMinutes(0);
        dt.setSeconds(0);
        return dt;
    }
    var dtNow = new Date(Date.now());
    var tmrw = new Date();
    tmrw.setDate(dtNow.getDate() + 1);

    var pickupYear = dtNow.getYear();
    var dropoffYear = tmrw.getYear();

    var pickupMonth = dtNow.getMonth();
    var dropoffMonth = tmrw.getMonth();

    var pickupDay = dtNow.getDate();
    var dropoffDay = tmrw.getDate();

    var pickupHour = dtNow.getHours();
    var dropoffHour = dtNow.getHours();

    var pickupDt = createDate(pickupYear, pickupMonth, pickupDay, pickupHour);
    var dropoffDt = createDate(dropoffYear, dropoffMonth, dropoffDay, dropoffHour);
    // init the datetimepicker and validationEngine
    $(document).ready(function() {
        $('#pickupDt').datetimepicker({
            minDate: pickupDt,
            dateFormat: "yy-mm-dd",
            timeFormat: "HH:mm:ss"
        });
        $('#dropoffDt').datetimepicker({
            minDate: dropoffDt,
            dateFormat: "yy-mm-dd",
            timeFormat: "HH:mm:ss"
        });
        $("#reserve_form").validationEngine('attach',
                {
                    promptPosition: "topLeft",
                    scroll: false,
                    autoHidePrompt: true
                });
    }); -->

   <!--  // deal with reserve button being clicked -->
  <!--   function reserve(flag)
    {
        if (flag === "guest")
        {
            $("#reserveType").val("guest");
            //document.getElementByID("rereserverType").value();
            //Jquery       
        }
        else
        {
            $("#reserveType").val("member");
        }
        $("#reserve_form").submit();
    } -->

<!--main content-->
<div class="container">
<div class="row" >

 </div>
 </div>
 <div class="container-fluid">
 <div class="row">
 <div class="row" class="col-md-12" style= margin-left:80px>
            <table>
   <form>
           <!--  <div class="span9" style="margin-top: 30px">
                <form class="form-search" id="search_form">
                    <div class="control-group">
                        <label class="control-label" for="inputVIN"><b>Search Car By locaiton</b></label>
                        <div class="input-append">
                            <input type="text" class="span2 search-query validate[required, custom[number], minSize[1], maxSize[1]]" name="locId" placeholder="location">
                            <button type="submit" class="btn" name="action" value="searchbylocation">Search</button>
                        </div>
                    </div>
                </form>
            </div> -->
             <%
                        try {
                            String action = request.getParameter("action");
                            ProductManager mngr = new ProductManager();
                          //  CartManager cmgr = new CartManager();
                            List<Product> productlist = null;
                           
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            if (action == null) {

                                productlist = mngr.listAll();
                            } 
                           /*  else if (action.compareTo("addtocart") == 0) {
                            	if (user != null) {
                            		 System.out.println(action);
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
                            	
                                int iditem = Integer.parseInt(request.getParameter("iditem"));
                              
                              productlist = mngr.listAll();
                                response.sendRedirect("view_products.jsp");
                            	}
                            }  */
                            Iterator<Product> itr2 = productlist.iterator();
                            while (itr2.hasNext()) {
                                info = itr2.next();
                                
                                 out.print(
                                		"<form method=\"post\">"
                                		+"<div class=\"row\">"
                                		+ "<div class=\"col-sm-6 col-md-4\">"
                                		+ " <div class=\"thumbnail\">"
                                		+ "<img src=\"" +info.getImagepath()+"\" alt=\"...\">"
                                		+ "<div class=\"caption\">"
                                		+ "<h3>"+info.getDescription()+" "+info.getName()+"</h3>"
                                		+ "<p> $"+ info.getPrice()+"</p>"
                                		+ "<p><button class=\"btn btn-primary\" name=\"action\" value=\"buynow\" type=\"submit\">Buy now</button>"
                                		+  "<input type=\"hidden\" name=\"id\" value=\"" + info.getIditem() + "\">"
                                		+  "<input type=\"hidden\" name=\"description\" value=\"" + info.getDescription() + "\">"
                                		 + " </div>"
                                		 +  "</div>"
                                		 + "</div>"
                                		 + "</div>"
                                		 + "</form>" ); 
                                		    
                                		      
                                		       
                                		        
                                		        
                                		     
                                		   
                                		
                                		
                                 /* out.print(
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
                                        + "</form>");  */
                            }
                        } catch (Exception e) {
                        }
                    %>
            
            </form>
            </table>
        </div>
 
 </div>
 
 </div>
 
 
 
            
            
            
            
           
    <!--reservation panel-->
   <%--  <div id="reserve_panel">
        <form id="reserve_form" method="post">
            <div class="pull-right white_mid_font" style="top:20px;right:20px;position:relative;">Make reservation</div>
            <div style="clear:both;height:25px;"></div>
            <!--location-->
            <div class="reserve_desc white_small_font">Pick up location</div>
            <select class="selectpicker reserve_select validate[required]" name="pickupLoc">
                <%
                    LocationManager mngr = new LocationManager();
                    List<LocationInfo> locationLst = mngr.listAll();
                    Iterator<LocationInfo> itr = locationLst.iterator();
                    while (itr.hasNext()) {
                        LocationInfo info = itr.next();
                        out.print("<option value=" + info.id + ">" + info.addressLine1 + "</option>");
                    }
                %>
            </select> 
            <div class="white_small_font reserve_desc white_small_font">Drop off location</div>
            <select class="selectpicker reserve_select validate[required]" name="dropoffLoc">
                <%
                    itr = locationLst.iterator();
                    while (itr.hasNext()) {
                        LocationInfo info = itr.next();
                        out.print("<option value=" + info.id + ">" + info.addressLine1 + "</option>");
                    }
                %>
            </select>
            <div class="section_divider"></div>
            <!--date-->
            <div class="white_small_font reserve_desc">Pick up date</div>
            <input type="text" class="reserve_input validate[required]" name="pickupDt" id="pickupDt"/>
            <div class="white_small_font reserve_desc">Drop off date</div>
            <input type="text" class="reserve_input validate[required, greaterThan[pickupDt]]" name="dropoffDt" id="dropoffDt"/>  
            <div class="section_divider"></div>
            <!--age and car type-->
            <div class="white_small_font reserve_desc">Age</div>
            <select class="selectpicker reserve_select validate[required]" name="age">
                <option value="less than 25">&lt;25</option>
                <option value="greater than 25">&gt;25</option>
                <option value="senior">senior</option>
            </select>

            <div class="white_small_font reserve_desc" style="display:none;">Car type</div>
            <select class="selectpicker reserve_select validate[required]" name="carType" style="display:none;">
                <%
                    CarTypeManager ctMngr = new CarTypeManager();
                    List<CarTypeInfo> carTypeLst = ctMngr.listAll();
                    Iterator<CarTypeInfo> ctItr = carTypeLst.iterator();
                    while (ctItr.hasNext()) {
                        CarTypeInfo info = ctItr.next();
                        out.print("<option value=" + info.id + ">" + info.type + ",  " + info.price + "$/per day</option>");
                    }
                %>
            </select> 
            <div style="margin-top:20px;">
                <!--if there is an user in the session, hide the book as guest button-->
                <%
                    try {
                        session = request.getSession();
                        String uidStr = session.getAttribute("uid").toString();
                    } catch (Exception e) {
                        out.println("<button class=\"btn btn-primary\" style=\"margin-left:20px;\" onclick=\"reserve('guest');\">Book as guest</button>");
                    }
                %>
                <button class="btn btn-primary " style="margin-left:20px;" onclick="reserve('member');">Book as member</button>
            </div>
            <!--save some information needed to post to the server-->
            <input type="hidden" value="reserve" name="action" id="action"></input>
            <input type="hidden" value="" name="reserveType" id="reserveType"></input>
        </form><!--end reserve form-->
        <%
            if (warningMsg.compareTo("") != 0) {
                out.println("<div class='alert' style='margin:0px 20px 0px 20px;'>"
                        + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                        + "<strong>Warning!</strong>"
                        + warningMsg + "</div>");
            }
        %>
    </div><!--end reservation panel--> --%>
    <!-- <div id="info_bar" >
        <p class="title_font" style="top:20px;left:40px;position:relative;">Rent with us,</p>
        <p class="mid_font" style="top:20px;left:100px;position:relative;">make your journey joyful.</p>
    </div>
</div>end main content -->

<%@include file="jspf/footer.jspf" %>