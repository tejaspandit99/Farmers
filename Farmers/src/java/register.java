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
/* THIS PAGE IS FOR FARMERS REGISTERATION */
public class register extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String name = req.getParameter("name");
        String password = req.getParameter("password");
        String adharcard = req.getParameter("adharcard");
        String contact=req.getParameter("contact");
        HttpSession session = req.getSession(true);
     
        System.out.println(name);
        System.out.println(adharcard);
        System.out.println(password);
        String tablePassword = "";
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            
            String query ="Insert into kissan values('"+name+"','"+adharcard+"','"+contact+"','"+password+"')" ;
            System.out.println(query);
            int i= st.executeUpdate(query);
            if ( i>0 ) {
                resp.sendRedirect("farmers-login.html");
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
            RequestDispatcher rd = req.getRequestDispatcher("farmer-register.html");
            rd.include(req, resp);
        }
         
//To change body of generated methods, choose Tools | Templates.
   
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("farmer-register.html"); //To change body of generated methods, choose Tools | Templates.
  
    }

    
}
