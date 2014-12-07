
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