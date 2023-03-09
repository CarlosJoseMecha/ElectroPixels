<%--
    Document   : gestionar-usuarios
    Created on : Feb 13, 2023, 7:47:12 PM
    Author     : Carlos José Mecha
--%>

<%@page import="handlers.GestionarUsuarios"%>
<%@page import="hibernate.Usuario"%>
<%@page import="java.util.Map"%>
<%@page import="hibernate.GestionarUsuariosHibernate"%>
<%@page import="hibernate.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
   GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
   //Traer todos los usuarios de la base de datos.
   List<Usuario> datosUsuarios = gestionarUsuarios.getTodosUsuarios();

%>


<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Administrar usuarios</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-gestionar-usuarios.css" rel="stylesheet" />
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
                        <h2>ADMINISTRAR USUARIOS</h2>
                     </div>
                     <div class="col-sm-6">
                        <a href="#añadirUsuarioModal" class="btn btn btn-success rounded-3 d-flex justify-content-center align-items-center " data-bs-toggle="modal" data-bs-target="#añadirUsuarioModal">
                           <i class="bi bi-person-plus-fill"></i> <span class="fw-bold p-1">AÑADIR USUARIO</span>
                        </a>
                     </div>
                  </div>
               </div>
               <table class="table table-striped table-hover">
                  <thead>
                     <tr>
                        <th>Usuario</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Saldo</th>
                        <th>Rol</th>
                        <th>Acciones</th>
                     </tr>
                  </thead>
                  <tbody>

                     <% if (datosUsuarios != null) {
                           for (Usuario usuario : datosUsuarios) {
                     %>
                     <tr>
                        <td><%=usuario.getNombre()%></td>
                        <td><%=usuario.getEmail()%></td>
                        <td><%=usuario.getPassword()%></td>
                        <td><%=usuario.getSaldo()%></td>
                        <td><%=usuario.getRol()%></td>
                        <td>
                           <a href="#editarUsuarioModal" class="edit" data-bs-toggle="modal" data-bs-target="#editarUsuarioModal" onclick="seleccionarUsuario(<%=usuario.getId()%>)"><i class="bi bi-pencil-fill" style="color:#D91EBA;"></i></a>
                           <a href="#eliminarUsuarioModal" class="delete" data-bs-toggle="modal" data-bs-target="#eliminarUsuarioModal" onclick="seleccionarUsuario(<%=usuario.getId()%>)"><i class="bi bi-trash3-fill"></i></a>
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
      <div class="modal fade" id="añadirUsuarioModal" tabindex="-1" aria-labelledby="añadirUsuarioModalLabel" aria-hidden="true">
         <div class="modal-dialog ">
            <div class="modal-content">
               <div class="modal-header">
                  <h1 class="modal-title fs-5" id="exampleModalLabel">Añadir usuario</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <!-- ***** Form ***** -->
                  <div class="container-gestionar">
                     <div class="wrap-gestionar">
                        <form action="insertar-usuario" method="post" >
                           <div class="form-group py-2">
                              <label for="usuario">Nombre usuario</label>
                              <input type="text" class="form-control" id="usuario" name="usuario" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="email">Email</label>
                              <input type="text" class="form-control" id="email" name="email" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="autor">Contraseña</label>
                              <input type="password" class="form-control" id="password" name="password" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="rol">Rol</label>
                              <select class="form-select" aria-label="Selecciona el rol" name="rol">
                                 <option value="user">user</option>
                                 <option value="gestor">gestor</option>
                                 <option value="admin">admin</option>
                              </select>
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                              <button type="submit" class="btn btn-primary">Añadir usuario</button>
                           </div>
                        </form>
                     </div>
                  </div>
                  <!-- ***** Form Fin ***** -->
               </div>
            </div>
         </div>
      </div>
      <!-- Editar Modal HTML -->
      <div class="modal fade" id="editarUsuarioModal" tabindex="-1" aria-labelledby="editarUsuarioModal" aria-hidden="true">
         <div class="modal-dialog ">
            <div class="modal-content">
               <div class="modal-header">
                  <h1 class="modal-title fs-5" id="exampleModalLabel">Editar usuario</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <!-- ***** Form ***** -->
                  <div class="container-gestionar">
                     <div class="wrap-gestionar">
                        <form action="editar-usuario" method="post">
                           <div class="form-group py-2">
                              <label for="usuario">Nombre usuario</label>
                              <input type="text"  class="form-control" id="usuario" name="usuario" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="email">Email</label>
                              <input type="email"  class="form-control" id="email" name="email" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="autor">Contraseña</label>
                              <input type="password"  class="form-control" id="password" name="password" required>
                           </div>
                           <div class="form-group py-2">
                              <label for="rol">Rol</label>
                              <select class="form-select"  aria-label="Selecciona el rol" name="rol">
                                 <option selected></option>
                                 <option value="user">user</option>
                                 <option value="gestor">gestor</option>
                                 <option value="admin">admin</option>
                              </select>
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                              <button type="submit" class="btn btn-primary">Añadir usuario</button>
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
      <div class="modal fade" id="eliminarUsuarioModal" tabindex="-1" aria-labelledby="eliminarUsuarioModal" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
               <form action='eliminar-usuario' method="post"  id="eliminarUsuarioForm">
                  <div class="modal-header">
                     <h4 class="modal-title">Eliminar usuario</h4>
                     <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="bi bi-x-lg" style='font-size: 1.5rem;'></i></button>
                  </div>
                  <div class="modal-body">
                     <p>¿Estas seguro de que quieres eliminar el usuario?</p>
                     <p class="text-warning"><small>Esta acción no se puede deshacer.</small></p>
                  </div>
                  <div class="modal-footer text-center">
                     <input type="button" class="btn btn-default" data-bs-dismiss="modal" value="Cancelar">
                     <input type="submit" class="btn btn-danger" value="Eliminar" onclick="eliminarUsuario()">
                  </div>
               </form>
            </div>
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
