package servlets;

import hibernate.GestionarUsuariosHibernate;
import handlers.GestionarUsuarios;
import handlers.Validar;
import hibernate.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Carlos José Mecha
 */
public class RegistrarServlet extends HttpServlet {

   /**
    * Handles the HTTP <code>POST</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
      Validar validar = new Validar();
      GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
      GestionarUsuariosHibernate gestionarUsuariosHibernate = new GestionarUsuariosHibernate();

      //datos
      String usuario = request.getParameter("usuario");
      String password = request.getParameter("password");
      String passconfirm = request.getParameter("passconfirm");
      String email = request.getParameter("email");

      //insertar
      if (!validar.validarUsuario(usuario)) {
         // Ejecuta si el usuario no existe
         if (validar.validarPassword(password, passconfirm)) {
            // Comprueba si las contraseñas coinciden a la hora de registrar.
            //Inserta en la base de datos de usuarios.
            gestionarUsuarios.insertarUsuario(request, response);
            //Insertar en la base de datos de usuarios hibernate.
            //Obtenemos el id que se le acaba de dar al usuario, para que en las dos tablas tenga el mismo.
            int id = gestionarUsuarios.getIdUsuario(request, response);
            Usuario nuevoUsuario = new Usuario(id, usuario, email);
            gestionarUsuariosHibernate.insertarUsuario(nuevoUsuario);
         } else {
            // Aquí el código que se ejecuta si las contraseñas no son iguales
         }
      } else {
         // Aquí el código que se ejecuta si el usuario ya existe
      }
   }

   /**
    * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
      response.setContentType("text/html;charset=UTF-8");
   }

   // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
   /**
    * Handles the HTTP <code>GET</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
      processRequest(request, response);
   }

   /**
    * Returns a short description of the servlet.
    *
    * @return a String containing servlet description
    */
   @Override
   public String getServletInfo() {
      return "Short description";
   }// </editor-fold>

}
