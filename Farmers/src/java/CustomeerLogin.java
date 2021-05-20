/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
public class CustomeerLogin extends HttpServlet {

    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String customer_name = req.getParameter("customer_name");
        String customer_password = req.getParameter("customer_password");
        HttpSession session = req.getSession(true);

        System.out.println(customer_name);
        System.out.println(customer_password);
        String tablePassword = "";
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            String query = "Select customer_password from customer where customer_name='"+customer_name+"'";
            System.out.println(query);
            rs = st.executeQuery(query);
            if (rs.next()) {
                tablePassword = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        if (customer_name != null && customer_password != null && !customer_name.trim().equals("") && customer_password.equals(tablePassword)) {
            session.setAttribute("farmername", customer_name);
            session.setAttribute("password", customer_password);
            resp.sendRedirect("Home.html");
        } else {
            PrintWriter out = resp.getWriter();
            out.println("<html>");
            out.println("<body>");
            out.println("<span style=color:red>Email Address or password mismatch !!!</span>");
            out.println("</body>");
            out.println("</html>");
            RequestDispatcher rd = req.getRequestDispatcher("/customers-login.html");
            rd.include(req, resp);
        }
//To change body of generated methods, choose Tools | Templates.
   
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("customers-login.html"); //To change body of generated methods, choose Tools | Templates.
  
    }

}
