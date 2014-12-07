
<script>
    $("p").mouseover(function() {
        $("p").css("color", "black");
    });
</script>
<div class="span2" style="height:600px;border:0px solid; background-color: #666666;width:220px;box-shadow:5px 5px 200px 50px inset;">
    <ul class="nav nav-list">
        <li class="nav-header small_font" style="height: 26px;padding-top:10px;padding-left:35px;border-right:5px solid #2EFDFF; margin-top: 30px; margin-bottom: 30px; background-color:#FFF568;">Control Panel</li>
            <%
                String[] menuItems = request.getParameter("menuItems").split(",");
                String[] menuLinks = request.getParameter("menuLinks").split(",");
                for (int i = 0; i < menuItems.length; i++) {
                    out.print("<li ><a href=\"" + menuLinks[i] + "\"><p style=\"color: white;font-weight:100;font-size:15px;margin-left:40px;\">" + menuItems[i] + "</p></a></li>");
                }
            %>   
    </ul>
</div>
