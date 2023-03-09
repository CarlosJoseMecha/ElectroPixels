package servlets;

import hibernate.GestionarProductosHibernate;
import hibernate.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Carlos José Mecha
 */
public class InsertarProductoServlet extends HttpServlet {

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

        if (!ServletFileUpload.isMultipartContent(request)) {
            throw new ServletException("Content type is not multipart/form-data");
        }

        ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);
            String titulo = "";
            String precio = "";
            String autor = "";
            String URLimagen = "";
            String URLperfil = "";
            String cantidad = "";

            for (FileItem fileItem : fileItems) {
                if (fileItem.isFormField()) {
                    String fieldName = fileItem.getFieldName();
                    String fieldValue = fileItem.getString();
                    if (fieldName.equals("titulo")) {
                        titulo = fieldValue;
                    } else if (fieldName.equals("precio")) {
                        precio = fieldValue;
                    } else if (fieldName.equals("autor")) {
                        autor = fieldValue;
                    } else if (fieldName.equals("URLimagen")) {
                        URLimagen = fieldValue;
                    } else if (fieldName.equals("URLperfil")) {
                        URLperfil = fieldValue;
                    } else if (fieldName.equals("cantidad")) {
                        cantidad = fieldValue;
                    }
                }
            }

            Productos producto = new Productos(titulo, Float.parseFloat(precio), autor, URLimagen, URLperfil, Integer.parseInt(cantidad));
            GestionarProductosHibernate gestionarProductos = new GestionarProductosHibernate();
            gestionarProductos.insertarProducto(producto);
            response.sendRedirect("gestionar-productos.jsp");
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }

}
