

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.Product"%> 
<%@page import= "manager.ProductManager"%>
<%@page import="javax.servlet.http.*"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<%@include file="jspf/header.jspf" %>
<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Home" />  
    <jsp:param name="subTitle" value="We strive to provide the best service." />  
</jsp:include>


        


<!--main content-->
<div class="container">
<div class="row" >

 </div>
 </div>
 <div class="container-fluid">
 <div class="row">
 <div class="row" class="col-md-12" style= margin-left:80px>
            <table>
  
             <%
                        try {
                            String action = request.getParameter("action");
                            ProductManager mngr = new ProductManager();
                          //  CartManager cmgr = new CartManager();
                            List<Product> productlist = null;
                           String url = "";
                            Product info = null;
                            System.out.println(action);
                            session = request.getSession();
                            User user = (User) session.getAttribute("user");
                            if (action == null) {

                                productlist = mngr.listAll();
                            } 
                            
                            else if (action.equals("buynow")) {
                            	String checkoutprice = request.getParameter("checkoutprice");
                            	session.setAttribute("checkoutprice", checkoutprice); 
                            	
                            	response.sendRedirect("check_out.jsp");
                            	return;
                            	
                            }
                        
                            Iterator<Product> itr2 = productlist.iterator();
                           /*  double checkoutprice = 0; */
                            while (itr2.hasNext()) {
                                info = itr2.next();
                             double checkoutprice = info.getPrice();
                                //session.setAttribute("checkoutprice", checkoutprice); 
                                 out.print(
                                		"<form id = \"buynow_form\" action=\"check_out.jsp\" method=\"post\">"
                                		+"<div class=\"row\">"
                                		+ "<div class=\"col-sm-6 col-md-4\">"
                                		+ " <div class=\"thumbnail\">"
                                		+ "<img src=\"" +info.getImagepath()+"\" alt=\"...\">"
                                		+ "<div class=\"caption\">"
                                		+ "<h3>"+info.getDescription()+" "+info.getName()+"</h3>"
                                		+ "<p> $"+ info.getPrice()+"</p>"
                                		
                                		+  "<input type=\"hidden\" name=\"id\" value=\"" + info.getIditem() + "\">"
                                		+  "<input type=\"hidden\" name=\"description\" value=\"" + info.getDescription() + "\">"
                                				+  "<input type=\"hidden\" name=\"checkoutprice\" value=\"" + checkoutprice + "\">" //addded 12/6/14
                                		
                                				+ "<p><button class=\"btn btn-primary\" onclick='buynow();'name=\"action\" value=\"buynow\" type=\"submit\">Buy now</button>"	
                                				
                                			+ " </div>"
                                		 +  "</div>"
                                		 + "</div>"
                                		 + "</div>"
                                		 /* checkoutprice = info.getPrice();
                                		 session.setAttribute("checkoutprice", checkoutprice); */
                                		 
                                		 +"</form>"); 
                               //  out.println("<form action=\"check_out.jsp\" method=\"post\"> <input type=\"hidden\" name=\"checkoutprice\" value=\"" + checkoutprice + "\"> </form>");
                                		 
 										
                                        
                                		 
                                		 
                                		
                                		    
                                		      
                              
                                		        
                                		        
                                		     
                                		   
                                		
                                		
                              
                            }
                           
                           
                            
                        } catch (Exception e) {
                        }
             
             			
                    %>
            
         <!--    </form> -->
            </table>
        </div>
 
 </div>
 
 </div>
 
         
  
<script>
  function buynow()
                        {
                            $("#buynow_form").submit();
                        }
  </script>

<%@include file="jspf/footer.jspf" %>