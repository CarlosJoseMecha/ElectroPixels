<%--
    Document   : index
    Created on : Feb 9, 2023, 10:42:37 AM
    Author     : Carlos José Mecha
--%>

<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page import="hibernate.GestionarProductosHibernate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   GestionarProductosHibernate gestionarProductosHibernate = new GestionarProductosHibernate();
   List<Productos> listaProductosTrending = gestionarProductosHibernate.obtenerProductosAleatorios(4);
%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Inicio</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-index.css" rel="stylesheet" />
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
      <!-- ***** Seccion 1 ***** -->
      <section class="d-flex align-items-center" id="section-1">
         <video id="bg-video" autoplay loop muted playsinline="playsinline">
            <source src="assets/videos/bg-main.mp4" type="video/mp4">
         </video>
         <div class=" d-flex align-items-center justify-content-center banner p-5">
            <div class="row align-items-center justify-content-center text-center ">
               <div class="container main-banner">
                  <h1 class="text-light" style="font-family: 'Roboto'; font-weight: 400;">DESCUBRE EL FUTURO, </br>
                     CON <span class="neon-text" style="font-family: 'Alien Encounters' !important;">NFT's</span>.</h1>
               </div>
               <%if (session.getAttribute("usuarioLogueado") != null) {%>
               <div class="container-contact3-form-btn d-flex justify-content-center btn-login mt-3">
                  <a href="galeria.jsp" class="btn py-0 px-5" tabindex="-1" role="button" aria-disabled="true">Ver colección</a>
               </div>
               <%} else {%>
               <div class="container-contact3-form-btn d-flex justify-content-center btn-login mt-3">
                  <a href="login.jsp" class="btn py-0 px-5" tabindex="-1" role="button" aria-disabled="true">Login</a>
               </div>
               <%}%>
            </div>
         </div>
      </section>
      <!-- ***** Seccion 1 Fin ***** -->

      <!-- ***** Seccion 2 ***** -->
      <section class="d-flex align-items-center justify-content-center" id="section-2">
         <div class="overlay-2 d-flex align-items-center justify-content-center">
            <div class="row align-items-center justify-content-center ">
               <h2 class="text-light text-center z-3">¿QUE ES UN NFT?</h2>
               <div class="container text-center container-descripcion z-3 px-5">
                  <p class="text-light ">Un NFT es un token no fungible, es decir, una unidad única y
                     exclusiva de propiedad digital que representa un bien o activo único en el mundo virtual.
                     Estos tokens son emitidos en blockchain, una tecnología de registro descentralizado que
                     permite la creación de registros permanentes e inmutables de transacciones y propiedad.La
                     propiedad de un NFT es verificable y comprobable gracias a su
                     registro en blockchain, lo
                     que significa que no puede ser falsificado o duplicado. Además, su naturaleza
                     descentralizada permite la eliminación de intermediarios en la transacción y comercio de
                     estos bienes, lo que reduce los costos y la complejidad de las transacciones y mejora la
                     eficiencia.</p>
               </div>
            </div>
         </div>
      </section>
      <!-- ***** Seccion 2 Fin ***** -->

      <!-- ***** Seccion 3 ***** -->
      <div class="container main-container">
         <div class="container">
            <h2 class="display-6 text-light py-3 ps-0">Trending</h2>
         </div>
         <div class="row">
            <%if (listaProductosTrending != null) {%>
            <% for (Productos producto : listaProductosTrending) {%>
            <div class="col-sm-3">
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
                           <h6 class="precio ps-0 py-1"><%= producto.getPrecio()%>  ETH</h6><img src="assets/icons/ethereum.svg" class="mt-1 eth-icon">
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <%
                  }
               }
            %>
         </div>
         <div class="container container-btn-galeria d-flex justify-content-center ">
            <a href="galeria.jsp" class="btn btn-galeria">Visitar galería</a>
         </div>
      </div>
      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</body>
</html>
