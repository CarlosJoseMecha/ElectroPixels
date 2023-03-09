<%--
    Document   : carrito.jsp
    Created on : Feb 13, 2023, 4:10:42 PM
    Author     : Carlos José Mecha
--%>

<%@page import="handlers.GestionarUsuarios"%>
<%@page import="java.util.List"%>
<%@page import="hibernate.Productos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<%
   GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
   float saldoUsuario = gestionarUsuarios.getSaldo((int) session.getAttribute("id_usuario"));
   int cantidadProductos = 0;
   float total = 0;
   List<Productos> listaProductos = (List<Productos>) session.getAttribute("carro");
   if (listaProductos == null) {
      cantidadProductos = 0;
   } else {
      cantidadProductos = listaProductos.size();
      //calcular el valor del carro
      for (Productos producto : listaProductos) {
         total += producto.getPrecio();
      }
   };
%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Carrito</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
      <!--  CSS -->
      <link href="css/style-carrito.css" rel="stylesheet" />
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

      <!-- ***** Carrito  ***** -->
      <div class="cart_section">
         <div class="container-fluid">
            <div class="row">
               <div class="col-lg-10 offset-lg-1">
                  <div class="cart_container">
                     <div class="cart_title">Carrito<small> (<%= cantidadProductos%> producto/s en tu carrito) </small></div>
                     <%if (session.getAttribute("carro") == null) {%>
                     <div class="row d-flex align-items-center p-4 cart-empty">
                        <div class="col-sm-12  text-center">
                           <i class="bi bi-cart p-0" style="font-size:6.8rem;"></i>
                           <h3 class="fw-bold">Tu carrito esta vacío</h3>
                           <h4 class="fw-semibold">Añade algo para realizar un pedido</h4>
                        </div>
                     </div>
                     <%} else {%>
                     <div class="cart_items">
                        <ul class="cart_list">
                           <%
                              if (listaProductos != null) {
                                 for (Productos producto : listaProductos) {
                           %>
                           <div class="row p-4">
                              <div class="col-sm-1">
                                 <div class="cart_item_image"><img src="<%= producto.getURLimagen()%>" alt=""></div>
                              </div>
                              <div class="col-sm-10 d-flex justify-content-around align-items-center text-center">
                                 <div class="cart_item_name cart_info_col">
                                    <div class="cart_item_title">Titulo</div>
                                    <div class="cart_item_text"><%= producto.getTitulo()%></div>
                                 </div>
                                 <div class="cart_item_color cart_info_col">
                                    <div class="cart_item_title">Autor</div>
                                    <div class="cart_item_text"><%= producto.getAutor()%></div>
                                 </div>
                                 <div class="cart_item_quantity cart_info_col">
                                    <div class="cart_item_title">Cantidad</div>
                                    <div class="cart_item_text"><%= producto.getCantidad()%></div>
                                 </div>
                                 <div class="cart_item_price cart_info_col">
                                    <div class="cart_item_title">Precio</div>
                                    <div class="cart_item_text"><%= producto.getPrecio()%><img src="assets/icons/ethereum.svg" class="eth-icon"></div>
                                 </div>
                              </div>
                              <div class="d-flex justify-content-center align-items-center col-sm-1 btn-delete-container">
                                 <a href="eliminar-item-carrito?id=<%=producto.getId()%>" class='btn btn-delete pt-5'><i class=" bi bi-x-lg" style="font-size:1.5rem;"></i></a>
                              </div>
                           </div>
                           <%}
                              }%>
                        </ul>
                     </div>
                     <%}%>
                     <div class="order_total">
                        <div class="order_total_content text-md-right d-flex">
                           <div class="col-6">
                              <div class="order_total_title">Saldo:</div>
                              <%if (saldoUsuario < total) {%>
                              <div class="order_total_amount" style="color:red !important;"><%=saldoUsuario%>  ETH | Saldo insuficiente</div>
                              <%} else {%>
                              <div class="order_total_amount"><%=saldoUsuario%>  ETH</div>
                              <%}%>
                           </div>
                           <div class="col-6 d-flex justify-content-end">
                              <div class="order_total_title">Total pedido:</div>
                              <div class="order_total_amount"><%=total%>  ETH</div>
                           </div>
                        </div>
                     </div>
                     <div class="cart_buttons">
                        <a href="galeria.jsp" type="button" class="button ">Seguir comprando</a>
                        <% if (listaProductos != null && saldoUsuario >= total) {%>
                        <a href="insertar-pedido?total=<%=total%>" type="button" class="button ">Pedir</a>
                        <% } else { %>
                        <a  href="javascript:void(0);" type="button" class="button btn-pedir pedir-disabled"disabled>Pedir</a>
                        <% }%>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- ***** Carrito Fin ***** -->

      <!-- ***** Footer ***** -->
      <jsp:include page="footer.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
      <script>
         // Seleccionar el elemento
         const btnPedir = document.querySelector('.btn-pedir');

         // Agregar una escucha de eventos para detectar cambios en la propiedad 'disabled'
         btnPedir.addEventListener('change', () => {
            // Verificar si el botón está deshabilitado
            if (btnPedir.disabled) {
               // Si está deshabilitado, agregar la clase 'pedir-disabled' al botón
               btnPedir.classList.add('pedir-disabled');
            } else {
               // Si no está deshabilitado, eliminar la clase 'pedir-disabled' del botón
               btnPedir.classList.remove('pedir-disabled');
            }
         });
      </script>
   </body>
</body>
</html>
