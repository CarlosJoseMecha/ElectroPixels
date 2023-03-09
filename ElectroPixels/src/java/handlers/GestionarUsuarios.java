package handlers;

/**
 *
 * @author Carlos José Mecha
 */
import hibernate.Usuario;
import static java.lang.System.out;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Carlos José Mecha
 */
public class GestionarUsuarios {

   /**
    * Devuelve todos los usuarios de la base de datos
    *
    * @return
    */
   public List<Usuario> getTodosUsuarios() {
      List<Usuario> listaUsuarios = new ArrayList<>();
      Connection conexion = null;
      PreparedStatement statement = null;
      ResultSet resultado = null;

      try {
         // Conectar a la base de datos
         Class.forName("com.mysql.cj.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");

         // Preparar la consulta
         String sql = "SELECT * FROM usuarios";
         statement = conexion.prepareStatement(sql);

         // Ejecutar la consulta y obtener el resultado
         resultado = statement.executeQuery();

         // Recorrer el resultado y crear objetos de tipo Usuario
         while (resultado.next()) {
            int id = resultado.getInt("id");
            String nombre = resultado.getString("nombre_usuario");
            String email = resultado.getString("email");
            String password = resultado.getString("password");
            Float saldo = resultado.getFloat("saldo");
            String rol = resultado.getString("rol");

            Usuario usuario = new Usuario(id, nombre, email, password, saldo, rol);
            listaUsuarios.add(usuario);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      } finally {
         try {
            if (resultado != null) {
               resultado.close();
            }
            if (statement != null) {
               statement.close();
            }
            if (conexion != null) {
               conexion.close();
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }

      return listaUsuarios;
   }

   /**
    * Devuelve un usuario con un ID que le indicas
    *
    * @param request
    * @param response
    * @return
    */
   public int getIdUsuario(HttpServletRequest request, HttpServletResponse response) {
      int id = 0;
      PreparedStatement statement = null;
      ResultSet resultado = null;
      try {
         // Conectar a la base de datos
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");

         // Preparar la consulta
         String sql = "SELECT id FROM usuarios WHERE email = ?";
         statement = conexion.prepareStatement(sql);

         // Establecer los parámetros de la consulta
         String email = request.getParameter("email");
         statement.setString(1, email);
         // Ejecutar la consulta y obtener el resultado
         resultado = statement.executeQuery();
         if (resultado.next()) {
            id = resultado.getInt("id");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         // Cerrar los recursos utilizados
         try {
            if (resultado != null) {
               resultado.close();
            }
            if (statement != null) {
               statement.close();
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
      return id;
   }

   /**
    * Inserta un usuario en la base de datos
    *
    * @param request
    * @param response
    */
   public void insertarUsuario(HttpServletRequest request, HttpServletResponse response) {
      // Conexión a la base de datos
      Connection conexion = null;
      String usuario = request.getParameter("usuario");
      String email = request.getParameter("email");
      String password = request.getParameter("password");
      String rol = request.getParameter("rol");
      // Obtener la URL de la página que hizo la solicitud
      String referer = request.getHeader("Referer");

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");
         Statement statement = conexion.createStatement();
         String insertSql;

         // Si se proporciona un rol, se utiliza el rol proporcionado
         if (rol != null && !rol.isEmpty()) {

            insertSql = "INSERT INTO usuarios (nombre_usuario, email, password, saldo, rol) "
                    + "VALUES ('" + usuario + "', '" + email + "', '" + password + "', 0, '" + rol + "')";
         } else {
            // Si no se proporciona un rol, se utiliza el rol predeterminado de "user"
            insertSql = "INSERT INTO usuarios (nombre_usuario, email, password, saldo, rol) "
                    + "VALUES ('" + usuario + "', '" + email + "', '" + password + "', 0, 'user')";
         }

         //Comprueba que se ha insertado correctamente
         int rowsAffected = statement.executeUpdate(insertSql);
         if (rowsAffected == 1) {
            // La inserción fue exitosa, dependiendo de la pagina desde la que vino el request, redirecciona a una u otra.
            if (referer != null && referer.contains("gestionar-usuarios.jsp")) {
               // Redirigir a la página de gestión de usuarios
               out.println("INSERTADO CORRECTAMENTE EN electropixels_db");
               response.sendRedirect("gestionar-usuarios.jsp");
            } else {
               // Redirigir a la página de confirmación
               out.println("INSERTADO CORRECTAMENTE EN electropixels_db");
               response.sendRedirect("confirmacion.jsp");
            }
         } else {
            //No se ha podido insertar, hacer algo.  //TODO
            out.println("ERROR AL INSERTAR EN electropixels_db");
         }
      } catch (Exception e) {
         e.printStackTrace();
         out.println("Error al insertar el usuario.");
         out.println(e.getMessage());
         out.println(e.getStackTrace());
      } finally {
         if (conexion != null) {
            try {
               conexion.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         }
      }
   }

   /**
    * Elimina un usuario de la base de datos
    *
    * @param id
    */
   public void eliminarUsuario(int id) {
      // Conexión a la base de datos
      Connection conexion = null;

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");

         // Preparar el statement
         String deleteSql = "DELETE FROM usuarios WHERE id = ?";
         PreparedStatement statement = conexion.prepareStatement(deleteSql);
         statement.setInt(1, id);

         // Ejecutar el statement
         statement.executeUpdate();
         statement.close();
      } catch (Exception e) {
         out.println("ERROR AL ELIMINAR DE electropixels_db");
         out.println(e.getMessage());
      } finally {
         if (conexion != null) {
            try {
               conexion.close();
            } catch (SQLException e) {
               out.println(e.getMessage());
            }
         }
      }
   }

   /**
    * Hace un update del saldo de un usuario en la base de datos
    *
    * @param saldoUsuario
    * @param idUsuario
    */
   public void updateSaldo(float saldoUsuario, int idUsuario) {
      // Conexión a la base de datos
      Connection conexion = null;
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");

         // Preparar el statement
         String updateSql = "UPDATE usuarios SET saldo = ? WHERE id = ?";
         PreparedStatement statement = conexion.prepareStatement(updateSql);
         statement.setFloat(1, saldoUsuario);
         statement.setInt(2, idUsuario);

         // Ejecutar el statement
         statement.executeUpdate();
         statement.close();
      } catch (Exception e) {
         // Manejar excepciones
         out.println(e.getMessage());
      } finally {
         // Cerrar la conexión a la base de datos
         if (conexion != null) {
            try {
               conexion.close();
            } catch (SQLException e) {
               // Manejar excepciones
               out.println(e.getMessage());
            }
         }
      }
   }

   /**
    * Devuelve el saldo de un usuario de la base de datos
    *
    * @param idUsuario
    * @return
    */
   public float getSaldo(int idUsuario) {
      // Conexión a la base de datos
      Connection conexion = null;
      float saldo = 0;
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/electropixels_db", "dam2", "1234");

         // Preparar el statement
         String selectSql = "SELECT saldo FROM usuarios WHERE id = ?";
         PreparedStatement statement = conexion.prepareStatement(selectSql);
         statement.setInt(1, idUsuario);

         // Ejecutar la consulta
         ResultSet resultSet = statement.executeQuery();

         // Obtener el saldo del usuario
         if (resultSet.next()) {
            saldo = resultSet.getFloat("saldo");
         }

         resultSet.close();
         statement.close();
      } catch (Exception e) {
         // Manejar excepciones
      } finally {
         // Cerrar la conexión a la base de datos
         if (conexion != null) {
            try {
               conexion.close();
            } catch (SQLException e) {
               // Manejar excepciones
            }
         }
      }

      // Devolver el saldo del usuario
      return saldo;
   }

}
