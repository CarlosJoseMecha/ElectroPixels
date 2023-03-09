package handlers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Carlos José Mecha
 */
public class Autenticar {

   /**
    *
    * @param request
    * @param response
    * @throws IOException
    * @throws ServletException
    */
   public void comprobarCredenciales(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      // Obtener los datos del formulario
      String email = request.getParameter("email");
      String password = request.getParameter("password");

      // Inicializar variables
      boolean encontrado = false;
      boolean passwordOK = false;

      // Conexión a la base de datos
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");
         // Consulta para obtener los datos del usuario
         String sql = "SELECT * FROM usuarios WHERE email=? AND password=?";
         try ( PreparedStatement preparedStatement = conexion.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            // Ejecutar la consulta y obtener los resultados
            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
               if (resultSet.absolute(1)) {
                  encontrado = true;
                  String passwordBD = resultSet.getString("password");
                  if (passwordBD.equals(password)) {
                     passwordOK = true;
                  }
               }
            }

            // Comprobar si los datos son correctos
            if (encontrado && passwordOK) {
               // Establecer los atributos de sesión del usuario
               HttpSession session = request.getSession();
               session.setAttribute("usuarioLogueado", true);
               session.setAttribute("email_usuario", email);

               // Realizar consultas para obtener los demás datos del usuario y establecerlos en la sesión
               sql = "SELECT rol, id, nombre_usuario, saldo FROM usuarios WHERE email = ?";
               try ( PreparedStatement statement = conexion.prepareStatement(sql)) {
                  statement.setString(1, email);

                  try ( ResultSet result = statement.executeQuery()) {
                     if (result.next()) {
                        String rol = result.getString("rol");
                        int id = result.getInt("id");
                        String nombre_usuario = result.getString("nombre_usuario");
                        float saldo = result.getFloat("saldo");

                        session.setAttribute("rol", rol);
                        session.setAttribute("id_usuario", id);
                        session.setAttribute("nombre_usuario", nombre_usuario);
                        session.setAttribute("saldo", saldo);
                     }
                  }
               }

               // Redirigir a otra página
               response.sendRedirect("index.jsp");
            } else {
               response.sendRedirect("login.jsp?error=notFound");
            }
         }
      } catch (Exception e) {
         System.err.println(e.getMessage());
      }
   }
}
