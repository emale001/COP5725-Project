<%-- 
    Document   : about_us
    Created on : Nov 13, 2013, 1:08:45 PM
    Author     : changliu
--%>

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
            <td><img src="img/chang.png" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Chang</td>
            <td>4012483</td>
            <td>leader of the third deliverable</td>
            <td>mainly in charge of: UI design<br/> 
                architecture design<br/>
                database design<br/>
                user register/sign in<br/>
                security and privilege control.<br/>
                project configuration management(Svn source control)
            </td>
        </tr>
        <tr>
            <td><img src="img/edwin.png" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Edwin</td>
            <td>2929484</td>
            <td>leader of the second deliverable</td>
            <td>
                responsible for implementing two web pages: manage_car.jsp and manage_employee.jsp,<br/>
                which enble administrator to manage the cars and employees.
            </td>
        </tr>
        <tr>
            <td><img src="img/hiba.jpg" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Name</td>
            <td>6644890</td>
            <td>leader of the user manual</td>
            <td>responsible for implementing two web pages: select_cartype.jsp and reserve_car.jsp,<br/> 
                which are for the users reserving car's process. <br/>
            </td>
        </tr>
        <tr>
            <td><img src="img/nahid.jpg" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Name</td>
            <td>43245542</td>
            <td>leader for the first deliverable</td>
            <td>
                Group leader for the first deliverable.<br/>
                Use Case Diagram,Sequence Diagram,State Chart Diagram<br/>
                Coding: Edit User Information,Edit Reservation Pages</td>
        </tr>
        <tr>
            <td><img src="img/wenrui.jpg" class="img-rounded" style="width:140px;height:140px;"></td>
            <td>Name</td>
            <td>4672552</td>
            <td>leader of the test specification document</td>
            <td>responsible for implementing two web pages: rent_car.jsp and return_car.jsp,<br/> 
                which represents the front-desk employee's routine work. <br/>
                These two pages enable a front-desk employee to help users pick up a car <br/> and return a car.
                Picture are included.</td>
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
