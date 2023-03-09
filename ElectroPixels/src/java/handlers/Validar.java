package handlers;

import java.sql.*;

/**
 *
 * @author Carlos José Mecha
 */
public class Validar {

   private Connection conexion;
   private PreparedStatement preparedStatement;
   private ResultSet resultados;

   //El constructor valida la conexion con la base de datos.
   public Validar() {
      try {
         Class.forName("com.mysql.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");
      } catch (Exception e) {
         System.out.println("Error al conectarse a la base de datos: " + e.getMessage());
      }
   }

   public boolean validarUsuario(String usuario) {
      try {
         preparedStatement = conexion.prepareStatement("SELECT nombre_usuario FROM usuarios WHERE nombre_usuario = ?");
         preparedStatement.setString(1, usuario);
         resultados = preparedStatement.executeQuery();
         return resultados.next();
      } catch (Exception e) {
         System.out.println("Error al validar el usuario: " + e.getMessage());
         return false;
      }
   }

   public boolean validarPassword(String contraseña, String confirmacionContraseña) {
      return contraseña.equals(confirmacionContraseña);
   }
}
