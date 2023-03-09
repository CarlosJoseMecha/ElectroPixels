package hibernate;

import java.sql.*;

public class ConexionHibernate {

   public static void main(String[] args) {
      String jdbcURL = "jdbc:mysql://localhost:3306/electropixels_db_hibernate";
      String usuario = "dam2";
      String pass = "1234";

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         System.out.println("Conectando con la base de datos: " + jdbcURL);
         Connection miConexion = DriverManager.getConnection(jdbcURL, usuario, pass);
         System.out.println("Conexión exitosa");

      } catch (Exception e) {

         System.out.println(e.getMessage());
      }
   }

}
