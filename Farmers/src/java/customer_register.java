/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DB.DBConnector;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class customer_register extends HttpServlet {

   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String customer_name=req.getParameter("customer_name");
      String customer_adhar = req.getParameter("customer_adhar");
       String customer_password = req.getParameter("customer_password");
       String contact=req.getParameter("contact");
        
        HttpSession session = req.getSession(true);
     
        System.out.println(customer_name);
         System.out.println(customer_adhar);
        System.out.println(customer_password);
       
        
        String tablePassword = "";
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            
            String query ="Insert into customer values('"+customer_name+"','"+customer_adhar+"','"+contact+"','"+customer_password+"','"+100+"')" ;
            System.out.println(query);
            int i= st.executeUpdate(query);
            if ( i>0 ) {
                resp.sendRedirect("customers-login.html");
            }
            else{
            System.out.println("record not inserted");
            }
            
        } catch (SQLException e) {
            System.out.println(e);
            PrintWriter out = resp.getWriter();
            out.println("<html>");
            out.println("<body>");
            out.println("<span style=color:red>Email Address or password mismatch !!!</span>");
            out.println("</body>");
            out.println("</html>");
            RequestDispatcher rd = req.getRequestDispatcher("customers-register.html");
            rd.include(req, resp);
        }
         
//To change body of generated methods, choose Tools | Templates.
   
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("customers-register.html"); //To change body of generated methods, choose Tools | Templates.
  
    }
       
   }
