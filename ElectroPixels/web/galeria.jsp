<%--
    Document   : productos
    Created on : Feb 9, 2023, 11:14:56 AM
    Author     : Carlos José Mecha
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="hibernate.Productos"%>
<%@page import="java.util.Iterator"%>
<%@page import="hibernate.GestionarProductosHibernate"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   GestionarProductosHibernate gestionarProductos = new GestionarProductosHibernate();
   List<Productos> productos;

   if (request.getAttribute("resultados") != null) {
      productos = (List<Productos>) request.getAttribute("resultados");
   } else {
      productos = gestionarProductos.obtenerTodosProductos();
   }
   List<Productos> carritoActual = new ArrayList<>();
   //Productos actualmente en el carrito
   if (session.getAttribute("carro") != null) {
      carritoActual = (List<Productos>) session.getAttribute("carro");
   }
%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Galería</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-galeria.css" rel="stylesheet" />
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

      <!-- ***** Galeria ***** -->
      <div class="container main-container">
         <div class="container mt-5">
            <!-- Barra de busqueda -->
            <form class="d-flex search" role="search" action="filtrar" method="post">
               <input class="form-control me-2" type="search" placeholder="Filtrar" aria-label="Search" name="terminoBusqueda">
               <button class="btn btn-outline-success" type="submit"><i class="bi bi-search"></i></button>
            </form>
            <!-- Barra de busqueda fin -->
         </div>
         <div class="container">
            <h2 class="display-6 text-light py-3" style="font-family: 'Poppins', sans-serif; font-weight: 500">Galeria</h2>
         </div>
         <div class="row">
            <%               Iterator<Productos> iterator = productos.iterator();
               int count = 0;
               while (iterator.hasNext()) {
                  Productos producto = iterator.next();
            %>
            <div class="col-md-3 col-sm-6">
               <div class="card p-1 pb-0" style="width: 19rem;">
                  <div class="image-box">
                     <img id="nft-img" class="card-img-top" src="<%= producto.getURLimagen()%>"  alt="...">
                  </div>
                  <div class="card-body  ">
                     <div class="container d-flex justify-content-start container-profile align-items-center pb-1">
                        <img src="<%= producto.getURLperfil()%>" alt="" class="rounded-circle me-2 img-perfil border">
                        <p class="card-text text-dark"><%= producto.getAutor()%></p>
                     </div>
                     <div class="container container-titulo">
                        <h5 class="titulo py-2"><%= producto.getTitulo()%></h5>
                        <div class="container d-flex justify-content-start" style="padding-left: 0 !important;">
                           <h6 class="precio ps-0 py-1"><%= producto.getPrecio()%>  ETH</h6><img src="assets/icons/ethereum.svg" class="mt-1 eth-icon"
                                                                                                 alt="...">
                        </div>
                     </div>
                     <%
                        boolean productoEnCarrito = false;
                        for (Productos pCarrito : carritoActual) {
                           if (pCarrito.getId() == producto.getId()) {
                              productoEnCarrito = true;
                              break;
                           }
                        }
                        if (productoEnCarrito) {
                     %>
                     <div class="container d-flex justify-content-end pt-2 pe-0 container-btn" disabled>
                        <a href="javascript:void(0);" class="btn btn-md d-flex align-items-center py-1 pe-1 btn-carrito" disabled>Ya en carrito <i class="bi bi-cart-fill px-2"></i></a>
                     </div>
                     <% } else {%>
                     <div class="container d-flex justify-content-end pt-2 pe-0 container-btn">
                        <a href="insertar-en-carro?id=<%= producto.getId()%>" class="btn btn-md d-flex align-items-center py-1 pe-1 btn-carrito">Añadir <i class="bi bi-cart-fill px-2"></i></a>
                     </div>
                     <% } %>

                  </div>
               </div>
            </div>

            <%
               count++;
               if (count % 4 == 0) {
            %>
         </div>
         <div class="row">
            <%
                  }
               }
            %>
         </div>
      </div>
      <!-- ***** Galeria fin ***** -->

      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
      <!--      <script >
               // Detectar cuándo se desplaza el usuario
               window.addEventListener("scroll", function () {
                  // Guardar la posición actual en sessionStorage
                  sessionStorage.setItem("scrollPosition", window.scrollY);
               });

               document.addEventListener("DOMContentLoaded", function () {
                  // Obtener la posición almacenada en sessionStorage
                  var scrollPosition = sessionStorage.getItem("scrollPosition");
                  // Si hay una posición almacenada, restaurarla
                  if (scrollPosition !== null) {
                     window.scrollTo(0, scrollPosition);
                  }
               });
            </script>-->
   </body>
</body>
</html>
