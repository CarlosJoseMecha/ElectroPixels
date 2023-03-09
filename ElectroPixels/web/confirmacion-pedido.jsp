<%--
    Document   : confirmacion-pedido.jsp
    Created on : Feb 17, 2023, 6:15:03 PM
    Author     : Carlos José Mecha
--%>

<%@page import="org.hibernate.Hibernate"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page import="hibernate.GestionarPedidosHibernate"%>
<%@page import="hibernate.Pedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   GestionarPedidosHibernate gestionarPedidosHibernate = new GestionarPedidosHibernate();
   Pedido pedido = null;
   pedido = gestionarPedidosHibernate.obtenerPedidoPorId(Integer.parseInt(request.getParameter("id")));

   Hibernate.initialize(pedido.getProductos());

   List<Productos> productosPedido = pedido.getProductos();

   float totalPedido = 0;

   for (Productos producto : productosPedido) {
      totalPedido += producto.getPrecio();
   }

%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Pedido realizado</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-confirmacion-pedido.css" rel="stylesheet" />
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
      <!-- Seccion -->
      <section class="" >
         <div class="container py-5 ">
            <div class="row d-flex justify-content-center align-items-center h-100">
               <div class="col-lg-8 col-xl-6">
                  <div class="card border-top border-bottom border-4" style="border-color: #6f60b1 !important;">
                     <div class="card-body p-5">
                        <p class="lead fw-bold mb-3" style="color: #6f60b1;">Pedido realizado</p>
                        <div class="row">
                           <div class="col mb-3">
                              <p class="small text-muted mb-1">Fecha pedido</p>
                              <p><%=pedido.getFechaFormateada()%></p>
                           </div>
                           <div class="col mb-3">
                              <p class="small text-muted mb-1">Pedido No.</p>
                              <p>#<%=pedido.getId()%></p>
                           </div>
                        </div>

                        <hr/>

                        <div>
                           <!-- productos -->
                           <div class="row d-flex justify-content-around align-items-center py-4 text-center">
                              <div class="col-md-3" >
                                 <p class="text-dark fw-bold">NFT</p>
                              </div>
                              <div class="col-md-3" >
                                 <p class="text-dark fw-bold">Autor</p>
                              </div>
                              <div class="col-md-3" >
                                 <p class="text-dark fw-bold">Cantidad</p>
                              </div>
                              <div class="col-md-3 ">
                                 <p class="text-dark fw-bold">Precio</p>
                              </div>
                           </div>
                           <%  for (Productos producto : productosPedido) {%>
                           <div class="row d-flex justify-content-around align-items-center py-3 text-center">
                              <div class="col-md-3" >
                                 <img class="img-nft p-1"src="<%= producto.getURLimagen()%>" alt="alt"/>
                              </div>
                              <div class="col-md-3" >
                                 <p><%= producto.getAutor()%></p>
                              </div>
                              <div class="col-md-3" >
                                 <p><%= producto.getCantidad()%></p>
                              </div>
                              <div class="col-md-3 ">
                                 <p><%= producto.getPrecio()%>  ETH</p>
                              </div>
                           </div>
                           <%    }%>
                        </div>

                        <div class="row my-4">
                           <div class="col-md-5 offset-md-7 col-lg-5 offset-lg-7 d-flex justify-content-center align-items-center pb-2">
                              <span class="lead fw-bold mb-0" style="color: #6f60b1;">Total: <span class="fw-normal"><%= totalPedido%>  ETH</span></span><img src="assets/icons/ethereum.svg" class="ms-2 eth-icon" style="width:5%">
                           </div>
                        </div>
                        <div class="d-flex justify-content-center align-items-center">
                           <button class="btn-pedidos">
                              <a href="perfil-usuario.jsp" class="btn">Ir a pedidos</a>
                           </button>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!-- Seccion fin -->
      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</html>
