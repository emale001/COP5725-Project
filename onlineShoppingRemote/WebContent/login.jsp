<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Team4Zone Login Page</title>
</head>
<body>
<%@include file="jspf/header.jspf" %>
<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Products" />  
    <jsp:param name="subTitle" value="We strive to provide the best service." />  
</jsp:include>
<div class="container">
    <div class="row">
          <div class="span6">
           <label class="control-label" > Email</label>
          
          
          <label>  Password</label>
          </div>
                  
                <form class="form-inline" action="#" method="post">
                    
                   <input type="email" class="form-control" id="exampleInputEmail2" placeholder="Enter email">
                    <input type="password" class="form-control" id="exampleInputPassword2" placeholder="Password">
                    <button type="submit" class="btn">Sign In</button>
                </form>       
          </div> 
          </div>     
<jsp:include page="jspf/control_panel.jsp">
            <jsp:param name="menuItems" value="Products, Bid Products" />  
            <jsp:param name="menuLinks" value="view_products.jsp,bid_products.jsp" />  
</jsp:include> 


   


<%@include file="jspf/footer.jspf" %>
</body>
</html>