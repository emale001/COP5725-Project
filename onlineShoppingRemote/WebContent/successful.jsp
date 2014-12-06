<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="jspf/header.jspf" %>

<jsp:include page="jspf/top_banner.jsp">
    <jsp:param name="title" value="Payment" />  
    <jsp:param name="subTitle" value="Your payment was a success" />  
</jsp:include>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Successful transaction</title>
</head>
<body>

<div class="container-fluid">
	<div class ="row">
		<h3 class = "row" class="small_font"style="margin-top:20px;margin-left:80px;font-size:16px">
		Your payment in the amount of $ ${checkoutprice} was successful
		</h3>	
		</div>
	</div>

</body>
</html>