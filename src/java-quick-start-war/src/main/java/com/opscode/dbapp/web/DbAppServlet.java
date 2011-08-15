package com.opscode.dbapp.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.opscode.dbapp.model.Product;

public class DbAppServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;
  private static Logger logger = Logger.getLogger(DbAppServlet.class.getName());

  @Override
  protected void doGet(HttpServletRequest request,
      HttpServletResponse response) throws ServletException, IOException {

    // parse the limit param off of the request
    int n = 10;
    String count = request.getParameter("n");
    if (count != null) {
      try {
        n = Integer.parseInt(count);
      } catch (NumberFormatException ignore) {
      }
    }

    // query the db and retrieve results
    List<Product> results = retrieveResults(n);

    // redirect to the JSP for display
    request.setAttribute("results", results);
    getServletConfig().getServletContext()
        .getRequestDispatcher("/WEB-INF/jsp/results.jsp").forward(request, response);

  }

  /**
   * Get a database connection from the registered data source in the servlet
   * container.
   * 
   * @return a database connection
   */
  private Connection getConnection() {
    Connection connection = null;
    try {
      InitialContext initContext = new InitialContext();
      Context envContext  = (Context)initContext.lookup("java:/comp/env");
      String appEnvironment = (String) envContext.lookup("appEnvironment");
      logger.log(Level.INFO, "application running in the '" + appEnvironment + "' environment!");
      DataSource dataSource = (DataSource) envContext.lookup("jdbc/dbapp");
      connection = dataSource.getConnection();
    } catch (Exception e) {
      logger.log(Level.SEVERE, "error retrieving db connection", e);
    }
    return connection;
  }

  /**
   * Query the database and build a list of Products from the results
   * 
   * @param limit rows to display
   * @return a list of products
   */
  private List<Product> retrieveResults(int limit) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    List<Product> results = new ArrayList<Product>();

    try {
      conn = getConnection();
      String sql = "select productCode, productName, MSRP from products limit ?";
      stmt = conn.prepareStatement(sql);
      stmt.setInt(1, limit);
      rs = stmt.executeQuery();

      while (rs.next()) {
        Product p = new Product();
        p.setCode(rs.getString(1));
        p.setName(rs.getString(2));
        p.setMsrp(rs.getString(3));
        results.add(p);
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "error retrieving results.", e);
    } finally {
      if (null != rs) {
        try {
          rs.close();
        } catch (Exception e) {
          logger.log(Level.SEVERE, "error closing result set.", e);
        }
      }
      if (null != conn) {
        try {
          conn.close();
        } catch (Exception e) {
          logger.log(Level.SEVERE, "error closing db connection.", e);
        }
      }
    }
    return results;
  }

}
