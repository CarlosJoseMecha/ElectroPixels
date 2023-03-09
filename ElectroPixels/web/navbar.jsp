<%--
    Document   : navbar
    Created on : Feb 13, 2023, 2:05:22 PM
    Author     : Carlos José Mecha
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- ***** Header ***** -->
<header>
   <!-- ***** Navbar ***** -->

   <%
      int cantidadProductos = 0;
      List<Productos> listaProductos = (List<Productos>) session.getAttribute("carro");
      if (listaProductos == null) {
         cantidadProductos = 0;
      } else {
         cantidadProductos = listaProductos.size();
      }

      Boolean usuarioLogueado = null;
      String rol = null;

      if (session.getAttribute("usuarioLogueado") != null) {
         usuarioLogueado = (Boolean) session.getAttribute("usuarioLogueado");

         if (session.getAttribute("rol") != null) {
            rol = (String) session.getAttribute("rol");
         } else {

         }
      } else {

      }
   %>
   <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
      <div class="container ps-4 ps-lg-5">
         <a class="navbar-brand" href="index.jsp"><img class="logo me-2" src="assets/logos/logoNFT.png" alt="ElectroPixels__NFT's">ELECTROPIXELS</a>
         <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse"
                 data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                 aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
         <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto my-2 my-lg-0">
               <%if (usuarioLogueado == null) {%>
               <li class="nav-item"><a class="nav-link" href="index.jsp">INICIO</a></li>
               <li class="nav-item"><a class="nav-link" href="galeria.jsp">GALERIA</a></li>
               <li class="nav-item"><a class="nav-link" href="registro.jsp">REGISTRAR</a></li>
               <li class="nav-item"><a class="nav-link" href="login.jsp">LOGIN</a></li>
                  <%} else if (usuarioLogueado && rol.equals("admin")) {%>
               <li class="nav-item"><a class="nav-link" href="index.jsp">INICIO</a></li>
               <li class="nav-item"><a class="nav-link" href="galeria.jsp">GALERIA</a></li>
               <li class="nav-item"><a class="nav-link" href="gestionar-productos.jsp">PRODUCTOS</a></li>
               <li class="nav-item"><a class="nav-link" href="gestionar-usuarios.jsp">USUARIOS</a></li>
               <li class="nav-item"><a class="nav-link" href="logout">CERRAR SESION</a></li>
                  <%} else if (usuarioLogueado && rol.equals("gestor")) {%>
               <li class="nav-item"><a class="nav-link" href="index.jsp">INICIO</a></li>
               <li class="nav-item"><a class="nav-link" href="galeria.jsp">GALERIA</a></li>
               <li class="nav-item"><a class="nav-link" href="gestionar-productos.jsp">GESTIONAR PRODUCTOS</a></li>
               <li class="nav-item"><a class="nav-link" href="logout">CERRAR SESION</a></li>
                  <%} else {%>
               <li class="nav-item"><a class="nav-link" href="index.jsp">INICIO</a></li>
               <li class="nav-item"><a class="nav-link" href="galeria.jsp">GALERIA</a></li>
               <button class="btn btn-outline-light py-1 btn-carrito">
                  <a class="nav-link text-light" href="carrito.jsp" >
                     <li class="nav-item">
                        <i class="bi-cart-fill me-1"></i>CARRITO <span class="badge bg-danger rounded-pill" ><%= cantidadProductos%></span>
                     </li>
                  </a>
               </button>
               <li class="nav-item"> <a class="nav-link perfil" href="perfil-usuario.jsp"> PERFIL <i class="bi bi-person-circle"></i></a></li>
               <li class="nav-item"><a class="nav-link" href="logout">CERRAR SESION</a></li>
                  <%}%>
            </ul>
         </div>
      </div>
   </nav>
   <!-- ***** Navbar Fin ***** -->
</header>
<!-- ***** Header Fin ***** -->
