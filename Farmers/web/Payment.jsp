<%-- 
    Document   : Payment
    Created on : 26 May, 2021, 5:09:45 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
    </head>
    <style></style>
    <body>
       <div style="text-align: center;" class="title">Security Amount</div>
            <center>
                <br><form action="customers-register.html" method="POST">
            <script src="https://checkout.razorpay.com/v1/checkout.js" 
            data-key="rzp_test_PYmUVniJMZcRCs"
            data-amount="10000"    
            data-currency="INR" 
            data-buttontext=" Pay Now "
            data-name="Agriculture-Interface"    
            data-description=""    
            data-image="https://i0.wp.com/netclipart.com/pp/m/392-3923372_indian-farmer-png-indian-farmer-images-png.png"    
            data-prefill.name=""    
            data-prefill.email=""    
            data-theme.color="#F37254">
        </script>
        <input type="hidden" custom="Hidden Element" name="hidden"></form></center>
        </div>
    </body>
</html>
