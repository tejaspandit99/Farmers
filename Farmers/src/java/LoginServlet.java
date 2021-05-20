/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author HP
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String adharcard = req.getParameter("adharcard");
        String password = req.getParameter("password");
        HttpSession session = req.getSession(true);

        System.out.println(adharcard);
        System.out.println(password);
        String tablePassword = "";
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            String query = "Select password from kissan where adharcard='" + adharcard + "'";
            rs = st.executeQuery(query);
            if (rs.next()) {
                tablePassword = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        if (adharcard != null && password != null && !adharcard.trim().equals("") && password.equals(tablePassword)) {
            session.setAttribute("adharcard", adharcard);
            session.setAttribute("password", password);
            resp.sendRedirect("product.html");
        } else {
            PrintWriter out = resp.getWriter();
            out.println("<html>");
            out.println("<body>");
            out.println("<span style=color:red>Email Address or password mismatch !!!</span>");
            out.println("</body>");
            out.println("</html>");
            RequestDispatcher rd = req.getRequestDispatcher("/LoginServlet.jsp");
            rd.include(req, resp);
        }
//To change body of generated methods, choose Tools | Templates.
   
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("farmers-login.html"); //To change body of generated methods, choose Tools | Templates.
  
    }

    
}
