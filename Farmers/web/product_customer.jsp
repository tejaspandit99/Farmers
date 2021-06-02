<%-- 
    Document   : product_farmer
    Created on : 22 May, 2021, 11:21:35 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
   <%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBConnector" %>
<!DOCTYPE html>
<html>
<head>
     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
</head>

<style>
	body
	{
		background-color: #f1dfd1;
background-image: linear-gradient(315deg, #f1dfd1 0%, #f6f0ea 74%);
	}

div.gallery {border-radius: 25px;
padding:10;
background-color: orange;
  width: 300px;
  height: 500px;

  border: 10px solid black;
}

div.gallery:hover {
  border: 1px solid black;
}

div.gallery img {
	border-radius: 25px;
  padding: 20px;
  width: 200px;
  height: 150px;
 position: center;
  width: 100%;
  height: auto;
}


div.desc {
    padding: 15px;
  text-align: center;
}

* {
  box-sizing: border-box;
}

.responsive {
  padding: 0 6px;
  float: left;
  width: 24.99999%;
}

@media only screen and (max-width: 700px) {
  .responsive {
    width: 49.99999%;
    margin: 6px 0;
  }
}

@media only screen and (max-width: 500px) {
  .responsive {
    width: 100%;
  }
}

.clearfix:after {
  content: "";
  display: table;
  clear: both;
}

</style>
</head>
<body>
    <%
           String customer_adharcard="";
         customer_adharcard = (String) session.getAttribute("customer_adhar");
            if (customer_adharcard == null || customer_adharcard == "") {
                response.sendRedirect("customers-login.html");
            }
            int count = 0;
            Statement st = null;
            ResultSet rs = null;

            st = DBConnector.getStatement();
            int min=0;
        %>
    <nav class="navbar navbar-expand-lg navbar-black bg-black">
   <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler navbar navbar-dark bg-dark" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
        <a class="nav-link ml-5" href="">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown ml-5">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" 
           aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#Vegetable">Vegetable</a>
          <a class="dropdown-item" href="#Pulses">Pulses</a>
          <a class="dropdown-item" href="#Fruits">Fruits</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#Others">Others</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="LogOut_customer.jsp">Log-out</a>
      </li>
    </ul>
  </div>
</nav><br/><br/>
 <section id="Vegetable">
     <center> <b><h1 class="text-uppercase"> Vegetable</h1></b></center><br/><br/>
     <%
                try {

                    String query = "Select * from products where category='Vegetable' ";
                    rs = st.executeQuery(query);
                    rs.last();
                    count = rs.getRow();
                    rs.beforeFirst();
                    System.out.println("count " + count);
                    if (count == 0) {
            %>
            <br>
            <b style="color: green;font-size: 40px;" ><center>You have no products related to Vegetables</b></center>
            <br>
            <%
                }
                System.out.println(query);
            %>
            <%
                while (rs.next()) {
                    Blob blob = rs.getBlob("image");

                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();
            %>
     
<div class="responsive">
  <div class="gallery">
 
      <img src="data:image/jpg;base64,<%=base64Image%>" style="height: 45%; width: 95%"><br/>
      
      <center><b><%=rs.getString(1)%></center>
      <center>Price: Rs.<%=rs.getString(2)%>/kg</center></b>
      <center>
          <b>Quantity</b> <b>: <%=rs.getString(12)%> kg</b>
      </center>
                    
                    <%
                        String endtime=rs.getString(10);
                        String e[]=endtime.split(" ");
                        for(int i=0;i<e.length;i++)
                        {
                            System.out.println(e[i]);
                        }
                        String end="";
                        String e0[]=e[0].split("-");
                        end=end+e0[e0.length-1];
                        for(int i=e0.length-2;i>=0;i--)
                        {
                            end=end+"-"+e0[i];
                        }
                        end="("+end+")"+" "+e[1];
                        if (Integer.valueOf(rs.getString(11)) == 0) {
                    %>
                    
                    &nbsp;&nbsp;&nbsp; <b>End of Bid :</b>
                    <br/>
                    <center> <b style="color:green; padding-left: 20px;"><%=end%></b><br/></center>
                    <center><b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg</center> 
                    
                    <form action="Bid_Update" method="post">
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="hidden" name="product_name" value="<%=rs.getString(1)%>">
                        <input type="hidden" name="product_id" value="<%=rs.getString(7)%>">
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button>Bid Now</button>
                    </form>
                        
                    <%
                    } else if (Integer.valueOf(rs.getString(11)) == 1) {
                    %>
                    <center> <b>End of Bid :</b></center>
                    
                    <center><b style="color:green">Timed Out</b><br/></center>
                   
                    <center><b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg</center>
                    
                        <%
                       if(customer_adharcard!=null && customer_adharcard!="")
                            {
                        if(customer_adharcard.equals(String.valueOf(rs.getString("customer_adharcard"))) && (Integer.valueOf(rs.getString("proceedpay"))==1))
                        {
                            System.out.println(customer_adharcard);
                            System.out.println(rs.getString("customer_adharcard"));
                        %>
                        <b>Chat with farmer</b>
                        <a href="https://wa.me/+91<%=rs.getString("farmer_contact")%>" target="blank"><button class="buynow-btn1">Chat Now</button></a>
                        <%
                            System.out.println("https://wa.me/+91"+rs.getString("farmer_contact"));
                        }}
                        %>
                        <br>
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button class="buynow-btn">Timed Out</button>
                        
                    <% 
                        }
                    %>   
      </div> </div>

 <%
//                String end_date=rs.getString(10);
//                int find =findDifference(end_date);
                    }
                } catch (SQLException e) {
                    System.out.println(e);
                }
            %>
 </section>

<div class="clearfix"></div>

<div style="padding:6px;">
  
</div></style>

</body>
</html>

  <!DOCTYPE html>
<html>
<head>
<style>
div.gallery {
  border: 5px solid black;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 250;
  height: 250;
}

div.desc {
  padding: 15px;
  text-align: center;
}

* {
  box-sizing: border-box;
}

.responsive {
  padding: 0 6px;
  float: left;
  width: 24.99999%;
}

@media only screen and (max-width: 700px) {
  .responsive {
    width: 49.99999%;
    margin: 6px 0;
  }
}

@media only screen and (max-width: 500px) {
  .responsive {
    width: 100%;
  }
}

.clearfix:after {
  content: "";
  display: table;
  clear: both;
}
.item-image-size{
    height: 200px;
    width:300px;
    padding: 5px;
}
</style>
</head>
<body>
<section id="Fruits">
     <center> <b><h1 class="text-uppercase">Fruits</h1></b></center><br/><br/>
     <% 
         try {

                    String query = "Select * from products where category='Fruits'";
                    rs = st.executeQuery(query);
                    rs.last();
                    count = rs.getRow();
                    rs.beforeFirst();
                    System.out.println("count " + count);
                    if (count == 0) {
            %>
      <br>
      <b style="color: green;font-size: 40px;" ><center>You have no products related to Fruits</b></center>
            <br>
            <%
                }
                System.out.println(query);
            %>
            <%
                while (rs.next()) {
                    Blob blob = rs.getBlob("image");

                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();
            %>
  <div class="responsive">
  <div class="gallery">          
         <img src="data:image/jpg;base64,<%=base64Image%>" style="height: 45%; width: 95%"  >
      
     
    <div class="desc"><b><%=rs.getString(1)%></div>
    	<div class=desc"><b><center>Price: Rs.<%=rs.getString(2)%></center></b></div>
  
      <center>
          <b>Quantity</b> <b>: <%=rs.getString(12)%> kg</b>
      </center>
                    
                    <%
                        String endtime=rs.getString(10);
                        String e[]=endtime.split(" ");
                        for(int i=0;i<e.length;i++)
                        {
                            System.out.println(e[i]);
                        }
                        String end="";
                        String e0[]=e[0].split("-");
                        end=end+e0[e0.length-1];
                        for(int i=e0.length-2;i>=0;i--)
                        {
                            end=end+"-"+e0[i];
                        }
                        end="("+end+")"+" "+e[1];
                        if (Integer.valueOf(rs.getString(11)) == 0) {
                    %>
                    
                    &nbsp;&nbsp;&nbsp; <b>End of Bid :</b>
                    <br/>
                    <b style="color:green; padding-left: 20px;"><%=end%></b><br/>
                    <b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg 
                    
                    <form action="Bid_Update" method="post">
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="hidden" name="product_name" value="<%=rs.getString(1)%>">
                        <input type="hidden" name="product_id" value="<%=rs.getString(7)%>">
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button>Bid Now</button>
                    </form>
                        
                    <%
                    } else if (Integer.valueOf(rs.getString(11)) == 1) {
                    %>
                    <center> <b>End of Bid :</b></center>
                    
                    <center><b style="color:green">Timed Out</b><br/></center>
                   
                    <center><b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg</center>
                    
                        <%
                       if(customer_adharcard!=null && customer_adharcard!="")
                            {
                        if(customer_adharcard.equals(String.valueOf(rs.getString("customer_adharcard"))) && (Integer.valueOf(rs.getString("proceedpay"))==1))
                        {
                            System.out.println(customer_adharcard);
                            System.out.println(rs.getString("customer_adharcard"));
                        %>
                        <b>Chat with farmer</b>
                        <a href="https://wa.me/+91<%=rs.getString("farmer_contact")%>" target="blank"><button class="buynow-btn1">Chat Now</button></a>
                        <%
                            System.out.println("https://wa.me/+91"+rs.getString("farmer_contact"));
                        }}
                        %>
                        <br>
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button class="buynow-btn">Timed Out</button>
                        
                    <% 
                        }
                    %> 
  </div>
</div>
 <%
//                String end_date=rs.getString(10);
//                int find =findDifference(end_date);
                    }
                } catch (SQLException e) {
                    System.out.println(e);
                }
            %>

</section>

<div class="clearfix"></div>

<div style="padding:6px;">
  
</div>

</body>


<body>
<section id="Pulses">
    <center> <b><h1 class="text-uppercase">Pulses</h1></b></center><br/><br/>
    <%
                try {

                    String query = "Select * from products where category='Pulses'";
                    rs = st.executeQuery(query);
                    rs.last();
                    count = rs.getRow();
                    rs.beforeFirst();
                    System.out.println("count " + count);
                    if (count == 0) {
            %>
            <br>
            <b style="color: green;font-size: 40px;" ><center>You have no products related to Pulses</b></center>
            <br>
            <%
                }
                System.out.println(query);
            %>
            <%
                while (rs.next()) {
                    Blob blob = rs.getBlob("image");

                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();
            %>
     
  <div class="responsive">
  <div class="gallery">
    
      <img src="data:image/jpg;base64,<%=base64Image%>" style="height: 45%; width: 95%">

    
         <center><b><%=rs.getString(1)%></center>
      <center>Price: Rs.<%=rs.getString(2)%></center></b>
      <center>
          <b>Quantity</b> <b>: <%=rs.getString(12)%> kg</b>
      </center>
                    
                    <%
                        String endtime=rs.getString(10);
                        String e[]=endtime.split(" ");
                        for(int i=0;i<e.length;i++)
                        {
                            System.out.println(e[i]);
                        }
                        String end="";
                        String e0[]=e[0].split("-");
                        end=end+e0[e0.length-1];
                        for(int i=e0.length-2;i>=0;i--)
                        {
                            end=end+"-"+e0[i];
                        }
                        end="("+end+")"+" "+e[1];
                        if (Integer.valueOf(rs.getString(11)) == 0) {
                    %>
                    
                    &nbsp;&nbsp;&nbsp; <b>End of Bid :</b>
                    <br/>
                    <b style="color:green; padding-left: 20px;"><%=end%></b><br/>
                    <b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg 
                    
                    <form action="Bid_Update" method="post">
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="hidden" name="product_name" value="<%=rs.getString(1)%>">
                        <input type="hidden" name="product_id" value="<%=rs.getString(7)%>">
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button>Bid Now</button>
                    </form>
                        
                    <%
                    } else if (Integer.valueOf(rs.getString(11)) == 1) {
                    %>
                    <center> <b>End of Bid :</b></center>
                    
                    <center><b style="color:green">Timed Out</b><br/></center>
                   
                    <center><b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg</center>
                    
                        <%
                       if(customer_adharcard!=null && customer_adharcard!="")
                            {
                        if(customer_adharcard.equals(String.valueOf(rs.getString("customer_adharcard"))) && (Integer.valueOf(rs.getString("proceedpay"))==1))
                        {
                            System.out.println(customer_adharcard);
                            System.out.println(rs.getString("customer_adharcard"));
                        %>
                        <b>Chat with farmer</b>
                        <a href="https://wa.me/+91<%=rs.getString("farmer_contact")%>" target="blank"><button class="buynow-btn1">Chat Now</button></a>
                        <%
                            System.out.println("https://wa.me/+91"+rs.getString("farmer_contact"));
                        }}
                        %>
                        <br>
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button class="buynow-btn">Timed Out</button>
                        
                    <% 
                        }
                    %> 
        
        
        
        
  </div>
</div>
 <%
//                String end_date=rs.getString(10);
//                int find =findDifference(end_date);
                    }
                } catch (SQLException e) {
                    System.out.println(e);
                }
            %>
</section>

<div class="clearfix"></div>

<div style="padding:6px;">
  
</div>

</body>
<body>

      <section id="Others">
    <center> <b><h1 class="text-uppercase">Others</h1></b></center><br/><br/>
       <%
                try {

                    String query = "Select * from products where category='Others'" ;
                    rs = st.executeQuery(query);
                    rs.last();
                    count = rs.getRow();
                    rs.beforeFirst();
                    System.out.println("count " + count);
                    if (count == 0) {
            %>
            <br>
            <b style="color: green;font-size: 40px;" ><center>You have no other products</b></center>
            <br>
            <%
                }
                System.out.println(query);
            %>
            <%
                while (rs.next()) {
                    Blob blob = rs.getBlob("image");

                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();
            %>
     
    <div class="responsive">
  <div class="gallery">
    <img src="data:image/jpg;base64,<%=base64Image%>" style="height: 45%; width: 95%">
    <center><b><%=rs.getString(1)%><center>
                <center><b>Price: Rs.<%=rs.getString(2)%></center></b>
    
      <center>
          <b>Quantity</b> <b>: <%=rs.getString(12)%> kg</b>
      </center>
                    
                    <%
                        String endtime=rs.getString(10);
                        String e[]=endtime.split(" ");
                        for(int i=0;i<e.length;i++)
                        {
                            System.out.println(e[i]);
                        }
                        String end="";
                        String e0[]=e[0].split("-");
                        end=end+e0[e0.length-1];
                        for(int i=e0.length-2;i>=0;i--)
                        {
                            end=end+"-"+e0[i];
                        }
                        end="("+end+")"+" "+e[1];
                        if (Integer.valueOf(rs.getString(11)) == 0) {
                    %>
                    
                    <center> <b>End of Bid :</b></center>
                    <br/>
                    <b style="color:green; padding-left: 20px;"><%=end%></b><br/>
                    <b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg 
                    
                    <form action="Bid_Update" method="post">
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="hidden" name="product_name" value="<%=rs.getString(1)%>">
                        <input type="hidden" name="product_id" value="<%=rs.getString(7)%>">
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button>Bid Now</button>
                    </form>
                        
                    <%
                    } else if (Integer.valueOf(rs.getString(11)) == 1) {
                    %>
                    <center> <b>End of Bid :</b></center>
                    
                    <center><b style="color:green">Timed Out</b><br/></center>
                   
                    <center><b>Current Bid</b> : Rs.<%=rs.getString(4)%>/kg</center>
                    
                        <%
                       if(customer_adharcard!=null && customer_adharcard!="")
                            {
                        if(customer_adharcard.equals(String.valueOf(rs.getString("customer_adharcard"))) && (Integer.valueOf(rs.getString("proceedpay"))==1))
                        {
                            System.out.println(customer_adharcard);
                            System.out.println(rs.getString("customer_adharcard"));
                        %>
                        <b>Chat with farmer</b>
                        <a href="https://wa.me/+91<%=rs.getString("farmer_contact")%>" target="blank"><button class="buynow-btn1">Chat Now</button></a>
                        <%
                            System.out.println("https://wa.me/+91"+rs.getString("farmer_contact"));
                        }}
                        %>
                        <br>
                        <%
                            min = Integer.parseInt(rs.getString(4)) + 1;
                        %>
                        <input type="number" min="<%=min%>" name="Bid_value" value="<%=min%>"required>
                        <button class="buynow-btn">Timed Out</button>
                        
                    <% 
                        }
                    %> 
        
        
        
  </div>
</div>
        <%
//                String end_date=rs.getString(10);
//                int find =findDifference(end_date);
                    }
                } catch (SQLException e) {
                    System.out.println(e);
                }
            %>
            
      </section>
<div class="clearfix"></div>

<div style="padding:6px;">
  
</div>

</body>

</html>

