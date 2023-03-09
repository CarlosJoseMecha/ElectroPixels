package servlets;

import hibernate.GestionarProductosHibernate;
import hibernate.Productos;
import java.io.IOException;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Carlos José Mecha
 */
@WebServlet(name = "InsertarEnCarro", urlPatterns = {"/insertar-en-carro"})
public class InsertarEnCarro extends HttpServlet {

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

      HttpSession session = request.getSession();

      if (session.getAttribute("usuarioLogueado") == null) {
         response.sendRedirect("login.jsp");
         return;
      }
      try {
         processRequest(request, response);
         //Instanciamos la clase que obtiene datos de la base de datos.
         GestionarProductosHibernate obtenerProductos = new GestionarProductosHibernate();
         //Inserta el producto en un arraylist
         List<Productos> listaProductos = (List<Productos>) session.getAttribute("carro");

         if (listaProductos == null) {
            //Iniciamos el array
            listaProductos = new ArrayList<>();
            session.setAttribute("carro", listaProductos);
         }
         //Obtiene el id del producto que se ha pulsado
         int id = Integer.parseInt(request.getParameter("id"));
         Productos producto = obtenerProductos.obtenerProducto(id);
         listaProductos.add(producto);
         response.sendRedirect("galeria.jsp");
      } catch (Exception e) {
         out.println(e.getMessage());
      }
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
