<%--
    Document   : gestionarProductos
    Created on : Feb 12, 2023, 6:42:10 PM
    Author     : Carlos José Mecha
--%>

<%@page import="hibernate.Productos"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page import="hibernate.GestionarProductosHibernate"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   GestionarProductosHibernate gestionarProductos = new GestionarProductosHibernate();
   //Traer todos los productos de la base de datos.
   List<Productos> datosProductos = gestionarProductos.obtenerTodosProductos();
%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Administrar Productos</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-gestionar-productos.css" rel="stylesheet" />
      <!--  Reset -->
      <link href="css/reset.css" rel="stylesheet" />
      <!-- Fonts -->
      <link href="css/fonts.css" rel="stylesheet" />
      <!-- CSS Navbar -->
      <link href="css/navbar.css" rel="stylesheet" />
      <!-- CSS Footer -->
      <link href="css/footer.css" rel="stylesheet" />
      <!-- Bootstrap Icons -->
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
      <!-- Google fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet">
   </head>

   <body>
      <!-- ***** Navbar ***** -->
      <jsp:include page="navbar.jsp" />
      <div class="container-xl">
         <div class="table-responsive">
            <div class="table-wrapper rounded-3 border border-white">
               <div class="table-title rounded-3 border border-white">
                  <div class="row">
                     <div class="col-sm-6">
                        <h2>ADMINISTRAR PRODUCTOS</h2>
                     </div>
                     <div class="col-sm-6">
                        <a href="#añadirProductoModal" class="btn btn btn-success rounded-3 d-flex justify-content-center align-items-center " data-bs-toggle="modal" data-bs-target="#añadirProductoModal">
                           <i class="bi bi-file-earmark-plus-fill"></i> <span class="fw-bold p-1">AÑADIR PRODUCTO</span>
                        </a>
                     </div>
                  </div>
               </div>
               <table class="table table-striped table-hover">
                  <thead class="text-start">
                     <tr>
                        <th scope="col">NFT</th>
                        <th scope="col">Titulo</th>
                        <th scope="col">Autor</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col">Precio</th>
                        <th scope="col">Acciones</th>
                     </tr>
                  </thead>
                  <tbody>
                     <% if (datosProductos != null) {
                           for (Productos producto : datosProductos) {
                     %>
                     <tr>
                        <td>
                           <div class="container align-items-center justify-content-center p-0 container-imagen">
                              <img src="<%= producto.getURLimagen()%>"  alt="...">
                           </div>
                        </td>
                        <td><%=producto.getTitulo()%></td>
                        <td>
                           <div class="container d-flex justify-content-start align-items-center ps-0 container-autor">
                              <img class="img-perfil mx-2 " src="<%= producto.getURLperfil()%>" alt="" ><p><%=producto.getAutor()%></p>
                           </div>
                        </td>
                        <td>
                           <div class="container container-cantidad d-flex  align-items-center p-0">
                              <%=producto.getCantidad()%>
                           </div>
                        </td>
                        <td>
                           <div class="container container-precio d-flex  align-items-center p-0">
                              <%=producto.getPrecio()%>  ETH
                           </div>

                        </td>
                        <td>
                           <div class="container justify-content-center ">
                              <a href="#eliminarProductoModal" class="delete" data-bs-toggle="modal" data-bs-target="#eliminarProductoModal" onclick="seleccionarUsuario(<%=producto.getId()%>)"><i class="bi bi-trash3-fill"></i></a>
                           </div>
                        </td>
                     </tr>
                     <%  }
                        }%>
                  </tbody>
               </table>
            </div>
         </div>
      </div>

      <!-- Añadir Modal HTML -->
      <div class="modal fade" id="añadirProductoModal" tabindex="-1" aria-labelledby="añadirProductoModal" aria-hidden="true">
         <div class="modal-dialog ">
            <div class="modal-content">
               <div class="modal-header">
                  <h1 class="modal-title fs-5" >Añadir producto</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <!-- ***** Form ***** -->
                  <div class="container-gestionar">
                     <div class="wrap-gestionar">
                        <form action="insertar-producto" method="post" enctype="multipart/form-data" >
                           <div class="form-group py-2">
                              <label for="titulo">Titulo producto</label>
                              <input type="text" class="form-control" id="titulo" name="titulo" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="autor">Autor</label>
                              <input type="text" class="form-control" id="autor" name="autor" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="URLimagen">URLImagen</label>
                              <input type="url" class="form-control" id="URLimagen" name="URLimagen" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="URLperfil">URLPerfil</label>
                              <input type="text" class="form-control" id="URLperfil" name="URLperfil" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="cantidad">Cantidad</label>
                              <input type="number" class="form-control" id="cantidad" name="cantidad" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="precio">Precio</label>
                              <input type="text" class="form-control" id="precio" name="precio" required>
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                              <button type="submit" class="btn btn-primary">Añadir producto</button>
                           </div>
                        </form>
                     </div>
                  </div>
                  <!-- ***** Form Fin ***** -->
               </div>
            </div>
         </div>
      </div>

      <!-- Eliminar Modal HTML -->
      <div class="modal fade" id="eliminarProductoModal" tabindex="-1" aria-labelledby="eliminarProductoModal" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
               <form action='eliminar-producto' method="post"  id="eliminarProductoForm">
                  <div class="modal-header">
                     <h4 class="modal-title">Eliminar producto</h4>
                     <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="bi bi-x-lg" style='font-size: 1.5rem;'></i></button>
                  </div>
                  <div class="modal-body">
                     <p>¿Estas seguro de que quieres eliminar el producto?</p>
                     <p class="text-warning"><small>Esta acción no se puede deshacer.</small></p>
                  </div>
                  <div class="modal-footer text-center">
                     <input type="button" class="btn btn-default" data-bs-dismiss="modal" value="Cancelar">
                     <input type="submit" class="btn btn-danger" value="Eliminar" onclick="eliminarProducto()">
                  </div>
               </form>
            </div>
         </div>
      </div>
      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="js/scripts.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</body>
</html>

