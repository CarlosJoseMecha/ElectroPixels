package servlets;

import handlers.GestionarUsuarios;
import hibernate.GestionarUsuariosHibernate;
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
public class InsertarUsuarioServlet extends HttpServlet {

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
      processRequest(request, response);

      GestionarUsuariosHibernate gestionarUsuariosHibernate = new GestionarUsuariosHibernate();
      GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
      //datos
      String usuario = request.getParameter("usuario");
      String email = request.getParameter("email");
      String password = request.getParameter("password");
      String rol = request.getParameter("rol");

      //Inserta el cliente en la base de usuarios
      gestionarUsuarios.insertarUsuario(request, response);
      //Insertar en la base de datos de usuarios hibernate.
      //Obtenemos el id que se le acaba de dar al usuario, para que en las dos tablas tenga el mismo.
      int id = gestionarUsuarios.getIdUsuario(request, response);
      Usuario nuevoUsuario = new Usuario(id, usuario, email);
      gestionarUsuariosHibernate.insertarUsuario(nuevoUsuario);
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
