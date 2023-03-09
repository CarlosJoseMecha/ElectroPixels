<%--
    Document   : perfil-usuario.jsp
    Created on : Feb 17, 2023, 6:47:58 PM
    Author     : Carlos José Mecha
--%>


<%@page import="org.hibernate.Hibernate"%>
<%@page import="hibernate.Productos"%>
<%@page import="handlers.GestionarUsuarios"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hibernate.GestionarPedidosHibernate"%>
<%@page import="hibernate.Pedido"%>
<%@page import="java.util.List"%>
<%
   GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
   GestionarPedidosHibernate gestionarPedidosHibernate = new GestionarPedidosHibernate();
   //Datos
   float saldoUsuario = gestionarUsuarios.getSaldo((int) session.getAttribute("id_usuario"));
   int id_usuario = (int) session.getAttribute("id_usuario");
   String nombre_usuario = (String) session.getAttribute("nombre_usuario");
   String email_usuario = (String) session.getAttribute("email_usuario");
   //Listas
   List<Pedido> historialPedidos = new ArrayList<>();
   historialPedidos = gestionarPedidosHibernate.obtenerTodosPedidos(id_usuario);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - <%=nombre_usuario%> - Perfil</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-perfil.css" rel="stylesheet" />
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
      <!-- Perfil -->
      <div class="container p-5 mt-5">
         <div class="main-body">

            <div class="row gutters-sm">
               <div class="col-md-3 mb-3">
                  <div class="card">
                     <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                           <img src="assets/images/profile.png" alt="Admin" class="rounded-circle" width="150">
                           <div class="mt-3">
                              <h4><%= nombre_usuario%></h4>
                              <p class="text-secondary my-2"><%= email_usuario%></p>
                              <h5 class="text-secondary mb-1 fw-normal">Saldo: <%= saldoUsuario%> ETH</h5>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col-md-9">
                  <div class="card mb-3">
                     <div class="card-body">
                        <div class="row">
                           <div class="col-sm-5">
                              <h6 class="mb-0">HISTORIAL DE PEDIDOS</h6>
                           </div>
                        </div>
                        <hr>
                        <% for (Pedido pedido : historialPedidos) {
                              //obtiene la lista de productos dentro de un pedido

                              Pedido pedidoActual = gestionarPedidosHibernate.obtenerPedidoPorId(pedido.getId());
                              Hibernate.initialize(pedidoActual.getProductos());
                              List<Productos> productosPedido = pedidoActual.getProductos();
                        %>

                        <div class="accordion accordion-flush" id="accordion<%= pedido.getId()%>">
                           <div class="accordion-item">
                              <h2 class="accordion-header" id="heading<%= pedido.getId()%>">
                                 <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%= pedido.getId()%>" aria-expanded="false" aria-controls="collapse<%= pedido.getId()%>">
                                    <div class="col-sm-2 me-1">
                                       <h6 class="mb-0 fw-semibold">Nº #<%= pedido.getId()%></h6>
                                    </div>
                                    <div class="col-sm-4">
                                       <h6 class="mb-0 fw-light">Fecha Pedido: <%= pedido.getFechaFormateada()%></h6>
                                    </div>
                                    <div class="col-sm-3 d-flex align-items-center">
                                       <% switch (pedido.getEstado()) {
                                             case "procesado":%>
                                       <h6 class="mb-0 fw-normal" >Estado: <%= pedido.getEstado()%></h6><div class="led-red ms-2"></div>
                                       <% break;
                                          case "enviado":%>
                                       <h6 class="mb-0 fw-normal" >Estado: <%= pedido.getEstado()%></h6><div class="led-yellow ms-2"></div>
                                       <% break;
                                          case "recibido":%>
                                       <h6 class="mb-0 fw-normal" >Estado: <%= pedido.getEstado()%></h6><div class="led-green ms-2"></div>
                                       <% break;
                                          default:%>
                                       <h6 class="mb-0 fw-normal" >Estado: <%= pedido.getEstado()%></h6><div class="led-green ms-2"></div>
                                       <% break;
                                          }%>

                                    </div>
                                    <div class="col-sm-2">
                                       <h6 class="mb-0 fw-normal">Total: <%= pedido.getTotalPedido()%>  ETH</h6>
                                    </div>
                                 </button>
                              </h2>
                              <div id="collapse<%= pedido.getId()%>" class="accordion-collapse collapse" aria-labelledby="heading<%= pedido.getId()%>" data-bs-parent="#accordion<%= pedido.getId()%>">
                                 <div class="accordion-body">

                                    <!-- contenido del acordeón aquí -->
                                    <div class="container px-1 px-md-4 pb-3 mx-auto">
                                       <!-- Estado pedido -->
                                       <div class="card pb-3">
                                          <div class="row d-flex justify-content-between px-3 top">
                                             <div class="col-6">
                                                <h5>PEDIDO <span class="text-primary font-weight-bold">#<%= pedido.getId()%></span></h5>
                                             </div>
                                             <div class="col-6 d-flex justify-content-end">
                                                <p class="mb-0 text-dark fw-bold">Fecha de pedido:   <span class="fw-normal ms-2" style="color:#afafaf !important;"> <%= pedido.getFechaFormateada()%></span></p>
                                             </div>
                                          </div>

                                          <div class="row d-flex justify-content-center">
                                             <div class="col-12">
                                                <!-- Barra progreso -->
                                                <ul id="progressbar" class="text-center d-flex justify-content-center">
                                                   <% switch (pedido.getEstado()) {
                                                         case "procesado": %>
                                                   <li class="active step0"></li>
                                                   <li class="step0"></li>
                                                   <li class="step0"></li>
                                                      <% break;
                                                         case "enviado": %>
                                                   <li class="active step0"></li>
                                                   <li class="active step0"></li>
                                                   <li class="step0"></li>
                                                      <% break;
                                                         case "recibido": %>
                                                   <li class="active step0"></li>
                                                   <li class="active step0"></li>
                                                   <li class="active step0"></li>
                                                      <% break;
                                                         default: %>
                                                   <li class="step0"></li>
                                                   <li class="step0"></li>
                                                   <li class="step0"></li>
                                                      <% break;
                                                         }%>
                                                </ul>

                                             </div>
                                          </div>
                                          <!-- barra progreso fin -->
                                          <div class="row justify-content-between ">
                                             <div class="col-4 d-flex justify-content-center align-items-center">
                                                <i class="bi bi-clipboard-check me-3" style="font-size: 2rem"></i>
                                                <div class="d-flex flex-column">
                                                   <p class="font-weight-bold">Pedido<br>procesado</p>
                                                </div>
                                             </div>
                                             <div class="col-4 d-flex justify-content-center align-items-center">
                                                <i class="bi bi-send me-3" style="font-size: 2rem"></i>
                                                <div class="d-flex flex-column">
                                                   <p class="font-weight-bold">Pedido<br>enviado</p>
                                                </div>
                                             </div>
                                             <div class="col-4 d-flex justify-content-center align-items-center">
                                                <i class="bi bi-patch-check me-3" style="font-size: 2rem"></i>
                                                <div class="d-flex flex-column">
                                                   <p class="font-weight-bold">Pedido<br>recibido</p>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                       <!-- Estado pedido fin -->
                                       <!-- Lista productos -->
                                       <div class="container py-5 ">
                                          <div class="row d-flex justify-content-center align-items-center h-100">
                                             <div class="col">
                                                <div class="card">
                                                   <div class="card-body p-5">
                                                      <p class="lead fw-bold mb-3" style="color: #6f60b1;">Pedido realizado</p>
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

                                                   </div>
                                                </div>
                                             </div>
                                          </div>
                                       </div>

                                    </div>
                                    <!-- contenido del acordeón fin -->

                                 </div>
                              </div>
                           </div>
                        </div>
                        <% }%>
                     </div>
                  </div>
               </div>
            </div>

         </div>
      </div>
      <!-- Perfil fin -->
      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</html>
