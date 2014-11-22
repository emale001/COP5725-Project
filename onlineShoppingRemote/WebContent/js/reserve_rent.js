/* 
    Document   : reserve_rent.js
    Created on : Nov 11, 2013
    Author     : Wenrui
*/
resultS = new Array();

function searchReservation(){
    var reservationNum = document.getElementById("reservationNum").value;
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    if(reservationNum.length == 0){         
        if (lastName.length == 0 && firstName.length == 0) {
            alert("You should provide either a Reservation Number or a Full Name!");
            return false;
        }
        else if (!(lastName.length != 0 && firstName.length != 0)) {
            alert("You should provide a Full name!");
            return false;
        }
    }
    
    var xhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var sendTo = "SearchReservation_servlet";
    var params = "reservationNum="+reservationNum+"&lastName="+lastName + "&firstName="+firstName;
    xhttp.open("POST", sendTo, false);
    xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //saying that the data sent is in the format of a form submission.
    xhttp.setRequestHeader("Content-length", params.length);
    //alert("params = "+params);
    xhttp.send(params);
    var resultS = new Array();
    /*xhttp.onreadystatechange=function() {
        if (xhttp.readyState==4 && xhttp.status==200){
            //document.getElementById("myDiv").innerHTML=xhttp.responseText;
            //alert(xhttp.responseText);
            eval(xhttp.responseText);
        }
    }*/
    //alert(xhttp.responseText);
    eval(xhttp.responseText);
    
    var dateObj = new Date();
    var month = dateObj.getUTCMonth();
    var day = dateObj.getUTCDate();
    var year = dateObj.getUTCFullYear();
    var newdate = year + "/" + month + "/" + day;      
     
    //Clear the previous contents of the table
    var table = document.getElementById("reservationInfo");
    for(var i = table.rows.length - 1; i > 0; i--)
    {
         table.deleteRow(i);
    }

    //Show the search results as rows of the table.
    for (var i = 0; i < resultS.length; i++) {
        //alert("here!");
        //alert(resultS[i]);
        var fields = resultS[i].split("|");      
                
        //Create "tr" tag
        var tr = document.createElement("tr");    
        
        //var currentDate = document.createElement("td");
        var type = document.createElement("td");
        var pickup_date = document.createElement("td");
        var dropoff_date = document.createElement("td");
        var status = document.createElement("td");
        status.id = "reservationStatus";
        
        var button_td = document.createElement("td");
        var button = document.createElement("button");        
        button.className = "btn btn-primary"; 
        button.onclick = function() {findAvailableCars(status.id);};        
        button.innerHTML ="Find car";
        button_td.appendChild(button); 

        //currentDate.innerHTML = newdate;
        type.innerHTML = fields[0];
        pickup_date.innerHTML = fields[1]+", "+fields[2];
        dropoff_date.innerHTML = fields[3]+", "+fields[4];
        status.innerHTML = fields[5]; //(fields[5] == 2)? "Valid" : "Invalid";
        document.getElementById("carTypeId").value = fields[6];
        document.getElementById("pickupLocation").value = fields[9];

        //tr.appendChild(currentDate);
        tr.appendChild(type);
        tr.appendChild(pickup_date);
        tr.appendChild(dropoff_date);
        tr.appendChild(status);      
        tr.appendChild(button_td); 
        
        table.appendChild(tr);
    }
}

function findAvailableCars(reservationStatusId)
{ // Search for availabale cars according to car type and pickup city.
    var carTypeId = document.getElementById("carTypeId").value;
    var pickupLocation= document.getElementById("pickupLocation").value;
    
    var xhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var sendTo = "FindCar_servlet";
    var params = "carTypeId="+carTypeId+"&pickupLocation="+pickupLocation;
    //alert(params);
    xhttp.open("POST", sendTo, false);
    xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //saying that the data sent is in the format of a form submission.
    xhttp.setRequestHeader("Content-length", params.length);
    xhttp.send(params);
    //var resultS = new Array();
    /*xhttp.onreadystatechange=function() {
        if (xhttp.readyState==4 && xhttp.status==200){
            //document.getElementById("myDiv").innerHTML=xhttp.responseText;
            alert(xhttp.responseText);
            eval(xhttp.responseText);
        }
    }*/
    //alert(xhttp.responseText);
    eval(xhttp.responseText);
    /*
    var dateObj = new Date();
    var month = dateObj.getUTCMonth()+1;
    var day = dateObj.getUTCDate();
    var year = dateObj.getUTCFullYear();
    var newdate = year + "-" + month + "-" + day;*/
    
    //Get "div" tag
    var myDiv = document.getElementById("searchResults");
    //myDiv.style="width: 150pt";
    //Create "table" tag
    //alert("0");    
    
    if(document.getElementById("availableCarsLabel") == null)
    {
        var description = document.createElement("label");
        description.id = "availableCarsLabel";
        description.className = "control-label";
        description.innerHTML = "<b>Available Cars</b>";   
        myDiv.appendChild(description);        
    }

    //If the table has already been created, do not create it again!
    if(document.getElementById("findAvailableCarInfo") != null)
    {     
        var existingTable = document.getElementById("findAvailableCarInfo") ;
        myDiv.removeChild(existingTable);
        //myDiv.innerHTML = " ";
    }        
    
    //Create a table to show the results
    var table = document.createElement("table");
    table.id = "findAvailableCarInfo";
    table.className = "table table-hover";
    table.style="margin-left: 10px"
    
    //alert("1");
    //Create another "tr" tag
    var trHead = document.createElement("tr");
    //alert("2");
    //Create "th" tags
    var image_head = document.createElement("th");
    var info_head = document.createElement("th");
    info_head.innerHTML = "Information";    
    var vin_head = document.createElement("th");
    vin_head.innerHTML = "VIN";  
    var records_head = document.createElement("th");
    records_head.innerHTML = "Records";  
    var status_head = document.createElement("th");
    status_head.innerHTML = "Status";      
    var button_head = document.createElement("th");
    //alert("3")
    //Append "th" to "tr"
    trHead.appendChild(image_head);
    trHead.appendChild(info_head);
    trHead.appendChild(vin_head);
    trHead.appendChild(records_head);
    trHead.appendChild(status_head);    
    trHead.appendChild(button_head);
    //Append two "tr"s to "table"
    table.appendChild(trHead);      
    //alert("4");
   
    for (var i = 0; i <resultS.length ; i++) {
        //alert("5");
        //alert(resultS[i]);
        var fields = resultS[i].split("|");
        
        //Create "tr" tag
        var tr = document.createElement("tr");    
        
        var image = document.createElement("td");
        var info = document.createElement("td");
        var vin = document.createElement("td");
        var records = document.createElement("td");
        var status = document.createElement("td");
        var button_td = document.createElement("td");
        
        var button = document.createElement("button");
              
        //image.innerHTML = "<img src='img/Camry.jpg' height='150px' width='200px'/>";
        //image.innerHTML = "<img src='"+fields[4]+"' height='100px' width='100px' class='img-polaroid'/>";
        image.innerHTML = "<img src='"+fields[4]+"' height='100px' width='100px'/>";
        info.innerHTML = fields[0];
        vin.innerHTML = fields[1];
        records.innerHTML = fields[2];
        status.innerHTML = fields[3];
        status.id = "status"+i;   
        
        var carId = fields[5];
                 
        button.id ="button"+i;
        button.className = "btn btn-primary"; 
        button.style = "margin-left:40px;";
           
        //http://mdn.beonex.com/en/Core_JavaScript_1.5_Guide/Functions#Creating_closures_in_loops.3a_A_common_mistake
        //http://stackoverflow.com/questions/14342871/assign-onclick-function-in-a-loop-does-not-work-in-javascript
        button.onclick = (function(vin, buttonId, statusId, carId, reservationStatusId){return function(){reserveCar(vin, buttonId, statusId, carId, reservationStatusId);};})(vin.innerHTML, button.id, status.id, carId, reservationStatusId);
        
        //onclick = (function(index) { return function() { deleteRows(index);};})(i);
        button.innerHTML ="Reserve";     
        
        tr.appendChild(image);
        tr.appendChild(info);
        tr.appendChild(vin);
        tr.appendChild(records);
        tr.appendChild(status);    
        
        button_td.appendChild(button);       
        tr.appendChild(button_td);      
        
        table.appendChild(tr);
    }    
    
    myDiv.appendChild(table);    
    resultS.length = 0;
}

function reserveCar(vin, buttonId, statusId, carId, reservationStatusId)
{
    var canReserveCar = document.getElementById("canReserveCar");
    if(canReserveCar.value == "cannot")
     {
         alert("One reservation can only reserve one car!");
         return;
     }
     else {
         canReserveCar.value = "cannot";
     }
    //alert("reserveCar()\n vin="+vin + "\n buttonId="+buttonId);
    var xhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var sendTo = "Reserve_servlet";
    var params = "vin="+vin+"&carId="+carId;
    xhttp.open("POST", sendTo, true);
    xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //saying that the data sent is in the format of a form submission.
    xhttp.setRequestHeader("Content-length", params.length);
    xhttp.send(params);
    xhttp.onreadystatechange=function() {
        if (xhttp.readyState==4 && xhttp.status==200){
            eval(xhttp.responseText);
            if(succeed == "YES"){
                document.getElementById(reservationStatusId).innerHTML="<b>3</b>";
                document.getElementById(statusId).innerHTML="<b>Reserved</b>";
                document.getElementById(buttonId).disabled = true;
                //alert("Reservation Completed!");  
            }
            else if(succeed == "NO") {
                alert("You cannot reserve a second car.");
            }
        }
    }
}

function clickLeftReserve()
{
    //alert();
    //document.getElementById("reservation_or_car").innerHTML = "<b>Search car</b>";
    document.getElementById("searchResult").innerHTML = " ";
    document.getElementById("searchCarResult").innerHTML = " ";  
    document.getElementById("availableCar").innerHTML = " ";  
    
    document.getElementById("reservation_or_car").innerHTML = "<b>Search Reservation</b> ";    
    document.getElementById("reservationNum").value = " ";      
    document.getElementById("lastName").value = " ";    
    document.getElementById("firstName").value = " ";  
    document.getElementById("searchButton").onclick = function() {searchReservation();};      
    
}

function clickLeftReturn()
{
    //alert();
    //document.getElementById("reservation_or_car").innerHTML = "<b>Search car</b>";
    document.getElementById("searchResult").innerHTML = " ";
    document.getElementById("searchCarResult").innerHTML = " ";  
    document.getElementById("availableCar").innerHTML = " ";  
    
    document.getElementById("reservation_or_car").innerHTML = "<b>Search Car</b> ";    
    document.getElementById("reservationNum").value = " ";      
    document.getElementById("lastName").value = " ";    
    document.getElementById("firstName").value = " ";  
    document.getElementById("searchButton").onclick = function() {searchCar();};      
    
}

function searchCar()
{
    var reservationNum = document.getElementById("reservationNum").value;
    var lastName = document.getElementById("lastName").value;
    var firstName = document.getElementById("firstName").value;
    if(reservationNum.length == 0){         
        if (lastName.length == 0 && firstName.length == 0) {
            alert("You should provide either a Reservation Number or a Full Name!");
            return false;
        }
        else if (!(lastName.length != 0 && firstName.length != 0)) {
            alert("You should provide a Full name!");
            return false;
        }
    }
    
    var xhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var sendTo = "SearchCar_servlet";
    var params = "reservationNum="+reservationNum+"&lastName="+lastName + "&firstName="+firstName;
    xhttp.open("POST", sendTo, false);
    xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //saying that the data sent is in the format of a form submission.
    xhttp.setRequestHeader("Content-length", params.length);
    xhttp.send(params);
    var resultS = new Array();
    /*xhttp.onreadystatechange=function() {
        if (xhttp.readyState==4 && xhttp.status==200){
            //document.getElementById("myDiv").innerHTML=xhttp.responseText;
            alert(xhttp.responseText);
            eval(xhttp.responseText);
        }
    }*/
    //alert(xhttp.responseText);
    eval(xhttp.responseText);
    
    var dateObj = new Date();
    var month = dateObj.getUTCMonth()+1;
    var day = dateObj.getUTCDate();
    var year = dateObj.getUTCFullYear();
    var newdate = year + "-" + month + "-" + day;
    
    //Get the div
    var myDiv = document.getElementById("searchResults");
    //Clear the previous contents of the table
    var table = document.getElementById("searcCarInfo");
    for(var j = table.rows.length - 1; j > 0; j--)
    {
         table.deleteRow(j);
    }   
    
    var extraTable = document.getElementById("extraTable");
    if(extraTable != null){
        myDiv.removeChild(extraTable);           
    }    
    
    for (var i = 0; i < resultS.length; i++) 
    {
        //alert("here!");
        //alert(resultS[i]);
        var fields = resultS[i].split("|")
        
        //Create "tr" tag
        var tr = document.createElement("tr");    
        

        var image = document.createElement("td");
        //var currentDate = document.createElement("td");
        //var dropoff_date = document.createElement("td");
        var name = document.createElement("td");
        //var pickup_date = document.createElement("td");
        var car = document.createElement("td");
        var vin = document.createElement("td");    
        var price = document.createElement("td");  
        var status = document.createElement("td");
/*        
        var button_td = document.createElement("td");
        var button = document.createElement("button");      
        button.id = "returnCarId";
        button.className = "btn btn-primary";         
        button.onclick = function() {returnCar(vin.innerHTML, "carStatusId", "returnCarId");};        
        button.innerHTML ="Return Car";
        button_td.appendChild(button);*/

        image.innerHTML = "<img src='"+fields[6]+"' height='100px' width='100px'/>";
        //currentDate.innerHTML = newdate;
        //dropoff_date.innerHTML = fields[2].split(" ")[0];
        name.innerHTML = fields[0];
        //pickup_date.innerHTML = fields[1];        
        car.innerHTML= fields[3];
        vin.innerHTML= fields[4];
        price.innerHTML = fields[9];
        price.id = "totalPrice";
        status.innerHTML = fields[5];
        status.id = "carStatusId";
        
        tr.appendChild(image);
        //tr.appendChild(currentDate);
        //tr.appendChild(dropoff_date);
        tr.appendChild(name);
        //tr.appendChild(pickup_date);
        tr.appendChild(car);       
        tr.appendChild(vin);  
        tr.appendChild(price); 
        tr.appendChild(status);          
        //tr.appendChild(button_td); 
        
        table.appendChild(tr);
        
            //Create a table to show the results
        var extraTable = document.createElement("table");
        extraTable.id = "extraTable";
        extraTable.className = "table table-hover";
        extraTable.style="margin-left: 10px"
        
        //Create "tr" tag
        var extraTr1 = document.createElement("tr");    
        
        //var currentDate = document.createElement("td");
        var carRecords = document.createElement("td");
        var carRecordsInput = document.createElement("td");
        //var pickup_date = document.createElement("td");
        //var dropoff_date = document.createElement("td");
        var extraCost = document.createElement("td");
        var extraCostInput = document.createElement("td");  
        
        var button_td = document.createElement("td");
        var button = document.createElement("button");      
        button.id = "returnCarId";
        button.className = "btn btn-primary";         
        button.onclick = function() {returnCar(vin.innerHTML, status.id, price.id, button.id, carRecordsInputArea.id, extraCostInputText.id, actualLocationInputText.id);};        
        button.innerHTML ="Return Car";
        button_td.appendChild(button);
        
        carRecords.innerHTML = "Car Records";
        //textarea
        var carRecordsInputArea = document.createElement("textarea");
        carRecordsInputArea.className = "form-control";
        carRecordsInputArea.id = "carRecords";
        carRecordsInputArea.rows = "1";      
        carRecordsInputArea.value = fields[7];
        carRecordsInput.appendChild(carRecordsInputArea);
        
        extraCost.innerHTML = "Extra Cost";
        //text
        var extraCostInputText= document.createElement("input");
        extraCostInputText.className = "controls";
        extraCostInputText.id = "extraCost";     
        extraCostInputText.value = "0";
        //extraCostInputText.placeholder = "0";
        //Add "textarea" to "td"
        extraCostInput.appendChild(extraCostInputText);     
        //Add "td" to tr
        extraTr1.appendChild(carRecords);
        extraTr1.appendChild(carRecordsInput);
        extraTr1.appendChild(extraCost);
        extraTr1.appendChild(extraCostInput);
        extraTr1.appendChild(button_td); 
        //Add "tr" to table
        extraTable.appendChild(extraTr1);
        
        //Create "tr" tag
        var extraTr2 = document.createElement("tr");    
        
        //var currentDate = document.createElement("td");
        var actualLocation = document.createElement("td");
        var actualLocationInput = document.createElement("td");
        //var pickup_date = document.createElement("td");
        //var dropoff_date = document.createElement("td");
        var scheduledLocation = document.createElement("td");
        var scheduledLocationInput = document.createElement("td");          
        
        actualLocation.innerHTML = "Return City";
        //textarea
        var actualLocationInputText= document.createElement("input");    
        actualLocationInputText.className = "controls";
        actualLocationInputText.id = "actualLocation";    
        actualLocationInputText.value = fields[8];
        actualLocationInput.appendChild(actualLocationInputText);
        
        scheduledLocation.innerHTML = "Expected Return City";
        //textarea
        var scheduledLocationInputText= document.createElement("input");
        scheduledLocationInputText.className = "controls";
        scheduledLocationInputText.id = "scheduledLocation";     
        scheduledLocationInputText.readOnly = true;
        scheduledLocationInputText.value = fields[8];
        //Add "textarea" to "td"
        scheduledLocationInput.appendChild(scheduledLocationInputText);     
        //Add "td" to tr
        extraTr2.appendChild(actualLocation);
        extraTr2.appendChild(actualLocationInput);
        extraTr2.appendChild(scheduledLocation);
        extraTr2.appendChild(scheduledLocationInput);
     
        //Add "tr" to table
        extraTable.appendChild(extraTr2);        
        
        //Create "tr" tag
        var extraTr3 = document.createElement("tr");    
        
        //var currentDate = document.createElement("td");
        var actualDate = document.createElement("td");
        var actualDateInput = document.createElement("td");
        //var pickup_date = document.createElement("td");
        //var dropoff_date = document.createElement("td");
        var scheduledDate = document.createElement("td");
        var scheduledDateInput = document.createElement("td");          
        
        actualDate.innerHTML = "Return Date";
        //textarea
        var actualDateInputText= document.createElement("input");    
        actualDateInputText.className = "controls";
        actualDateInputText.id = "actualDate";    
        actualDateInputText.value = newdate;
        actualDateInputText.readOnly = true;
        actualDateInput.appendChild(actualDateInputText);
        
        scheduledDate.innerHTML = "Expected Return Date";
        //textarea
        var scheduledDateInputText= document.createElement("input");
        scheduledDateInputText.className = "controls";
        scheduledDateInputText.id = "scheduledDate";     
        scheduledDateInputText.readOnly = true;
        scheduledDateInputText.value = fields[2].split(" ")[0];
        //Add "textarea" to "td"
        scheduledDateInput.appendChild(scheduledDateInputText);     
        //Add "td" to tr
        extraTr3.appendChild(actualDate);
        extraTr3.appendChild(actualDateInput);
        extraTr3.appendChild(scheduledDate);
        extraTr3.appendChild(scheduledDateInput);
     
        //Add "tr" to table
        extraTable.appendChild(extraTr3);               
        
        //Add "table" to div
        myDiv.appendChild(extraTable);
    }
    
}

function returnCar(vin, carStatusId, priceId, returnCarId, carRecordsInputAreaId, extraCostInputTextId, actualLocationInputTextId)
{
    //alert("returnCar()\n vin="+vin);
    if(document.getElementById(carStatusId).innerHTML == "Available")
    {
        alert("This car has been returned.");
        return;
    }
    
    var carRecords = document.getElementById(carRecordsInputAreaId).value;
    var extraCost = document.getElementById(extraCostInputTextId).value;
    var actualReturnCity = document.getElementById(actualLocationInputTextId).value;
    
    var xhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    var sendTo = "ReturnCar_servlet";
    var params = "vin="+vin+"&carRecords="+carRecords+"&extraCost="+extraCost+"&actualReturnCity="+actualReturnCity;
    //alert(params);
    xhttp.open("POST", sendTo, true);
    xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded"); //saying that the data sent is in the format of a form submission.
    xhttp.setRequestHeader("Content-length", params.length);
    xhttp.send(params);
    xhttp.onreadystatechange=function() {
        if (xhttp.readyState==4 && xhttp.status==200){
            var succeed, finalPrice;
            //alert(xhttp.responseText);            
            eval(xhttp.responseText);
            //alert("hehe!");
            if(succeed == "YES"){
                document.getElementById(priceId).innerHTML="<b>"+finalPrice+"</b>";
                document.getElementById(carStatusId).innerHTML="<b>Available</b>";
                document.getElementById(returnCarId).disabled = true;
                alert("Return Successfully\n");  
            }                      
        }
    }    
}
