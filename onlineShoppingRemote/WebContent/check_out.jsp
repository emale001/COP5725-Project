

<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="jspf/header.jspf" %>


<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Check Out" />  
    <jsp:param name="subTitle" value="Payment Information." />  
</jsp:include>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.CreditCard"%> 
<%@page import="entity.Product"%> 
<%@page import= "manager.ProductManager"%>
<%@page import= "manager.CartManager"%>
<%@page import= "manager.CreditCardManager"%>
<%@page import= "entity.User"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>


<!-- uncomment this script to unable credit card regex check -->
 <script>
    // init the datetimepicker and validationEngine
    $(document).ready(function() {

        $('#check_out_form').validationEngine('attach',
                {
                    promptPosition: "topLeft",
                    scroll: false,
                    autoHidePrompt: true
                });

    });



</script>  


<div>
	<div>
<form id="check_out_form" action="successful.jsp" method="post">
<%
		session = request.getSession();
		String action = request.getParameter("action");
		String firstname = "";
		User user = (User) session.getAttribute("user");	
		String checkoutprice = session.getAttribute("checkoutprice").toString();
		
		
				if (action == null || action.equals("checkout")) {
					
					
					 if (user != null) {
						
					} 
					
				}
				
				
				
				try {
			   
			    ProductManager mngr = new ProductManager();
			    CartManager cmgr = new CartManager();
			    List<Product> productlist = null;
			   	Cart cart = (Cart) session.getAttribute("shoppingcart");
			    Product info = null;
			    System.out.println(action);
			    CreditCard card = new CreditCard();
			   // session = request.getSession();
			 //   User user = (User) session.getAttribute("user");
			 
			 
			 	if (action.equals("payment")) {
			 		String name_on_card = request.getParameter("name_on_card");
			 		String card_type = request.getParameter("card_type");
			 		String address1 = request.getParameter("address1");
			 		String card_num = request.getParameter("card_no");
			 		String city = request.getParameter("city");
			 		String month = request.getParameter("month2");
			 		String year = request.getParameter("year2");
			 		String state = request.getParameter("state");
			 		String cvv = request.getParameter("secure_code");
			 		String zip = request.getParameter("zip_code");
			 	
			 		if (user != null) {
			 			card.setFulladdress(address1, city, state, zip);
			 			card.setName_on_card(name_on_card);
			 			card.setCard_type(card_type);
			 			card.setNumber(card_num);
			 			card.setExpiration_date(month, year);
			 			card.setSecurity_code(cvv);
			 			card.setUser_id(user.userid);
			 			CreditCardManager ccmgr = new CreditCardManager();
			 			int cardid = ccmgr.createCreditCard(card);
			 			card.setId(cardid);
			 			if (cardid == -1) {
			 				ccmgr.updateCard(card);
			 			}
			 			
			 		
			 		}
			 		else {
			 			response.sendRedirect("successful.jsp");
			 		}
			 		
			 	}
			    
				}

				catch (Exception e) {
					System.err.println(e +" after while check_out.jsp");
				}
%>
            <table cellpadding="2" >
                <div class="column_width"></div>
                <tr><td align="right"> <strong> Personal Information </strong> </td></tr>
                <tr>
                    <td align="right">First name</td><td><input  style=' width:150px;'type="text"   value="<% if(user != null && user.firstname != null) {out.print(user.firstname);} %>" id="f_name" name="f_name" value=""  placeholder="First Name" class ="validate[required, custom[onlyLetterSp],maxSize[50]]"/></td>
                   <%-- <td align="right">Driver License</td><td><input style=' width:150px;' type="text" value="<% if(User_Info.driverLicense!= null && uid!=-1) { out.print( User_Info.driverLicense);} %>" id="d_license" name="d_license" value="" placeholder="Driver License" class ="validate[required, custom[onlyLetterNumber], maxSize[17]]"/></td> --%>
                </tr>
                <tr>

                    <%-- <td align="right">Last name</td><td><input style=' width:150px;' type="text" value="<% if(User_Info.lastName!= null && uid!=-1) { out.print( User_Info.lastName);} %>" id="l_name" name="l_name" value="" placeholder="Last Name" class ="validate[required, custom[onlyLetterSp], maxSize[50]]"/></td>
                    <td align="right">DOB</td><td><input style=' width:150px;' type="text" value="<% if(User_Info.dob!= null && uid!=-1) { out.print( User_Info.dob);} %>" id="dob" name="dob" value="" placeholder="yyyy-MM-DD" class ="validate[required, custom[date]]"/></td> --%>

                    <td align="right">Last name</td><td><input style=' width:150px;' type="text" id="l_name" name="l_name" value="<% if(user != null && user.lastname != null) { out.print( user.lastname);} %>" placeholder="Last Name" class ="validate[required, custom[onlyLetterSp], maxSize[50]]"/></td>
                    <td align="right">Expiration Date</td><td><select id="month1" name="month1" style=" width:85px;" >
                        <option value="01">January
                        <option value="02">February
                        <option value="03">March
                        <option value="04">April
                        <option value="05">May
                        <option value="06">June
                        <option value="07">July
                        <option value="08">August
                        <option value="09">September
                        <option value="10">October
                        <option value="11">November
                        <option value="12">December
                    </select> /
                    <select id="year1" name="year1" style=" width:65px; ">
                        <%
                        int year = 2013;
                        while (year < 2051) {
                            out.print("<option value=" + year + ">" + year);
                            year = year + 1;
                        }
                        %></select></td>

                </tr>
                <tr>
                    <td align="right">Email</td><td><input style=' width:162px;' id ="user_email" value="<% if(user != null && user.email != null) {out.print(user.email);} %>" type="text" name="email" placeholder="Email" class="input-block-level validate[required,custom[email]]" /></td>
                </tr>
                <tr>
                    <td align="right">Confirm Email</td><td><input style=' width:162px;' type="text" value="" placeholder="Confirm Email" class="input-block-level validate[equals[user_email]]"/></td>
                <tr><td><br></td><td><br></td></tr>
                <div class="table_divider"></div>
                <tr><td align="right"><strong>Billing Information </strong></td></tr>
                <tr><td></td><td><img src='image/cards.png'></td><td></td><td></td></tr>
                <tr>
                    <td align="right" >Credit Card Type</td><td><select style=' width:162px;' id="card_type" name="card_type" >
                        <option value="Visa">Visa</option>   
                        <option value="MasterCard">MasterCard</option> 
                        <option value="American Express">American Express</option> 
                        </select></td>
                    <td align="right">Address Line 1</td><td><input style=' width:150px;' type="text" id="address1" name="address1" value="" placeholder="Address Line 1" class ="validate[required, maxSize[30]]"/></td>
                </tr>
                <tr>
                    <td align="right">Credit Card Number</td><td><input style=' width:150px;' type="text" id="card_no" name="card_no" value="" placeholder="Credit Card Number" class ="validate[required, creditCard,minSize[16], maxSize[16]]"/></td>
                    <td align="right">Address Line 2</td><td><input  style=' width:150px;'type="text" id="address2" name="address2" value="" placeholder="Address Line 2" class ="validate[ maxSize[50]]"/></td>
                </tr>
                <tr>
                    <td align="right">Name on card</td><td><input style=' width:150px;' type="text" id="name_on_card" name="name_on_card" value="" placeholder="Name on card" class ="validate[required, custom[onlyLetterSp], maxSize[50]]"/></td>
                    <td align="right">City</td><td><input style=' width:150px;' type="text" id="city" name="city" value="" placeholder="City" class ="validate[required, custom[onlyLetterSp],maxSize[50]]"/></td>
                </tr>
                <tr>
                    <td align="right">Expiration Date</td><td><select id="month2" name="month2" style=" width:85px;" >
                        <option value="01">January
                        <option value="02">February
                        <option value="03">March
                        <option value="04">April
                        <option value="05">May
                        <option value="06">June
                        <option value="07">July
                        <option value="08">August
                        <option value="09">September
                        <option value="10">October
                        <option value="11">November
                        <option value="12">December
                    </select> /
                    <select id="year2" name="year2" style=" width:65px; ">
                        <%
                        int year2 = 2013;
                        while (year2 < 2051) {
                            out.print("<option value=" + year2 + ">" + year2);
                            year2 = year2 + 1;
                        }
                        %></select></td>
                    <td align="right">State</td><td><input style=' width:150px;' type="text" id="state" name="state" value="" placeholder="State" class ="validate[required, custom[onlyLetterSp], maxSize[50]]"/></td>
                </tr>
                <tr>
                    <td align="right">Secure Code</td><td><input style=' width:150px;' type="text" id="secure_code" name="secure_code" value="" placeholder="Secure Code" class ="validate[required, custom[onlyNumberSp],minSize[3], maxSize[3]]"/></td>
                    <td align="right">Zip Code</td><td><input style=' width:150px;' type="text" id="zip_code" name="zip_code" value="" placeholder="Zip Code" class ="validate[required, custom[onlyNumberSp],minSize[5], maxSize[5]]"/></td>
                </tr>
                <tr>
                    <td><td></td>
                    <td></td><td><h4>$ ${checkoutprice}</h4> <button class= "btn btn-primary" ><!-- name="action" value="submitpayment" type="submit" --> Submit Payment</button></td>
                </tr>
                <!--  <tr>
                    <td><td></td>
                    <td></td><td><button class="btn btn-primary">Reserve</button></td>
                </tr> -->
            </table> 
            <input type="hidden" value="payment" name="action" id="action"></input>
        </form>
    </div><!--end of reserve table-->
</div><!--end main content-->
</body>
<%@include file="jspf/footer.jspf" %>
</html>