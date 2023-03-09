<%--
    Document   : registro
    Created on : Feb 9, 2023, 11:09:12 AM
    Author     : Carlos JosÃ© Mecha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Confirmacion login</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-confirmacion.css" rel="stylesheet" />
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
      <!-- ***** Video background ***** -->
      <video class="video-background" preload="auto" autoplay loop muted playsinline="playsinline">
         <source src="assets/videos/bg-login.mp4" type="video/mp4">
      </video>
      <!-- ***** Video background ***** -->
      <div class="video-foreground">
         <!-- ***** Mensaje confirmacion ***** -->
         <div class="bg-contact3" style="background-image: url('images/bg-01.jpg');">
            <div class="container-contact3">
               <div class="wrap-contact3 text-center">
                  <h3 class="text-light mb-2">¡ENHORABUENA!</h3>
                  <i class="bi bi-check-circle-fill" style="font-size: 3rem; color:#e8ff04"></i>
                  <h5 class="text-light my-3">Te has registrado con éxito. Ahora puedes loguear en la aplicación.</h5>
                  <div class="container-contact3-form-btn d-flex justify-content-center  btn-login">
                     <a href="login.jsp" class="btn py-0 px-5" tabindex="-1" role="button" aria-disabled="true">Login</a>
                  </div>
               </div>
            </div>
         </div>
         <!-- ***** Mensaje confirmacion fin ***** -->
         <!-- ***** Footer ***** -->
         <jsp:include page="footer.jsp" />
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</body>
</html>
