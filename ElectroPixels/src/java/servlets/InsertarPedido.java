package servlets;

import handlers.GestionarUsuarios;
import hibernate.GestionarPedidosHibernate;
import hibernate.Productos;
import java.io.IOException;
import static java.lang.System.out;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Carlos José Mecha
 */
public class InsertarPedido extends HttpServlet {

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

      //Comprueba que existe un carrito en la sesion
      HttpSession session = request.getSession();
      if (session.getAttribute("carro") == null) {
         // el carrito no está en la sesión, redirecciona al carro otra vez
         response.sendRedirect("carrito.jsp");
      } else {
         // el carrito está en la sesión, continúa procesando la solicitud
         GestionarPedidosHibernate gestionarPedidos = new GestionarPedidosHibernate();
         GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
         //Recoge el valor total del pedido del parametro pasado por URL.
         float totalPedido = Float.parseFloat(request.getParameter("total"));
         out.println("TOTAL: " + totalPedido);
         int idPedido = gestionarPedidos.insertarPedido((List<Productos>) session.getAttribute("carro"), (int) session.getAttribute("id_usuario"), totalPedido);
         if (idPedido != -1) {
            //restar el total del pedido al saldo del usuario
            float saldoUsuario = (Float) session.getAttribute("saldo");
            saldoUsuario -= totalPedido;
            session.setAttribute("saldo", saldoUsuario);
            //actualizar el saldo en la base de datos
            int idUsuario = (int) session.getAttribute("id_usuario");
            gestionarUsuarios.updateSaldo(saldoUsuario, idUsuario);
            //borra el carrito porque el pedido ya se ha realizado
            session.removeAttribute("carro");
            response.sendRedirect("confirmacion-pedido.jsp?id=" + idPedido);
         } else {
            response.sendRedirect("carrito.jsp");
         }
      }
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
