/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DB.DBConnector;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aksha
 */
public class ProcessPayment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String adharcard=req.getParameter("adharcard");
        String customer_adhar=req.getParameter("customer_adharcard");
        String product_id=req.getParameter("product_id");
        String farmer_contact="";
        String customer_contact="";
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            String query = "Select contact from kissan where adharcard='" + adharcard + "'";
            rs = st.executeQuery(query);
            if (rs.next()) {
                farmer_contact = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        try {

            Statement st = null;
            ResultSet rs = null;
            st = DBConnector.getStatement();
            String query = "Select contact from customer where customer_adhar='" + customer_adhar + "'";
            rs = st.executeQuery(query);
            if (rs.next()) {
                customer_contact = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        System.out.println("Farmer_contact "+farmer_contact);
        System.out.println("Customer_contact "+customer_contact);
        try {
            Statement st = null;
            st = DBConnector.getStatement();
            String query = "UPDATE products SET "
                    + "proceedpay='"+1+"',customer_contact='"+customer_contact+"',farmer_contact='"+farmer_contact+"' "
                    + "WHERE product_id ='"+product_id+"';";
            System.out.println(query);
            int i = st.executeUpdate(query);
            if (i > 0) {
                resp.sendRedirect("product_farmer.jsp");
                System.out.println("Record Updated");
            } else {
                System.out.println("record not Updated");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }  
        //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("product_farmer.jsp"); //To change body of generated methods, choose Tools | Templates.
    }

    
}
