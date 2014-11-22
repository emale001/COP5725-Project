<%-- 
    Document   : top_barner
    Created on : Nov 11, 2013, 5:42:19 PM
    Author     : changliu
--%>
<div class="container">
    <div class="row" style="height:130px;border-left: 10px solid #7DD2F5;margin-left:0px;background-color: #EEEEF0;">
        <div style="margin-left:80px; margin-top:30px;font-weight:400;font-size:20px; ">
            <%
                out.print(request.getParameter("title"));
            %>    
        </div>
        <h4 class="small_font"style="margin-top:20px;margin-left:80px;font-size:16px">
            <%
                out.print(request.getParameter("subTitle"));
            %>    
        </h4>
    </div>
</div>