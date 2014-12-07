

<%@include file="jspf/header.jspf" %>
<div class="container" style="">
    <div class="hero-unit">
        <h1>OnlineShopping.com</h1>
        <p>
            This website is created for class COP5725
            We designed a super user-friendly UI to improve the users' experience when shopping online with us.
            
        </p>
    </div>
</div>

<div class="container">
    
    <div style="margin-left:10px;margin-bottom:10px;" class=""><strong style="border-bottom:5px solid #7DD2F5; font-size:20px;margin-right:5px;">Team member</strong>showing in alphabetic order:p</div>

    <table id="reservationInfo" class="table table-hover" style="margin-left: 10px">
        <tr>
            <!--<th></th>-->
            <th></th>
            <th> Name</th>
            <th> Panther_ID</th> 
            <th> Role </th>
            <th> Main tasks</th>
            <th></th>
        <tr>
            <td><img src="" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Edwin</td>
            <td>4012483</td>
            <td>leader of the project</td>
            <td>mainly in charge of: UI design<br/> 
                
                database connection<br/>
                user register/sign in<br/>
                security and privilege control.<br/>
                project configuration management(Svn source control)
                responsible for implementing the following pages: about_us.jsp, view_product.jsp, shoppingCart.jsp, login, logout, edit user info<br/>
            </td>
        </tr>
       
        <tr>
            <td><img src="" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Carlos</td>
            <td>3512223</td>
            <td>bid product</td>
            <td>responsible for implementing the web pages: bid_products.jsp,<br/> 
                And created the logic and database. <br/>
            </td>
        </tr>
        <tr>
            <td><img src="" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Amit</td>
            <td>5570238</td>
            <td>buy_now products</td>
            <td>
             responsible for implementing the web pages: index.jsp, buynowManager class<br/>
                and the logic assiociated with it<br/>
              
        </tr>
        <tr>
            <td><img src="" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Rosmar</td>
            <td>3372737</td>
            <td>Front end design (original design not used here)</td>
            <td>responsible for providing the original HTML and CSS: Later on during the semester,<br/> 
                the group decided to go with bootstrap instead of the HTML provided.
                </td>
        </tr>
    </table>
</div>
<script>
    $(document).ready(function(){
        $("#index_tab").removeClass("red_underscore");
        $("#about_us_tab").addClass("red_underscore");
    });
</script>
<%@include file="jspf/footer.jspf" %>
