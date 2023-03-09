<%--
    Document   : registro
    Created on : Feb 9, 2023, 11:09:12 AM
    Author     : Carlos José Mecha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>ELECTROPIXELS - Registrar</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/logos/logoNFT.png" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" />
      <!--  CSS -->
      <link href="css/style-registrar.css" rel="stylesheet" />
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
      <!-- ***** Form  ***** -->
      <video class="video-background" preload="auto" autoplay loop muted playsinline="playsinline">
         <source src="assets/videos/bg-login.mp4" type="video/mp4">
      </video>

      <div class="video-foreground">
         <div class="bg-contact3" style="background-image: url('images/bg-01.jpg');">
            <div class="container-contact3">
               <div class="wrap-contact3">
                  <form method="post" action="registrar" class="contact3-form form-control text-center">
                     <span class="contact3-form-title" style="font-family: 'Alien Encounters' !important;">REGISTRAR</span>
                     <div class="wrap-input3">
                        <input class="input3" type="text" name="usuario" placeholder="Usuario" autocomplete="off" required>
                        <span class="focus-input3"></span>
                     </div>
                     <div class="wrap-input3">
                        <input class="input3" type="email" name="email" placeholder="Email" autocomplete="off" required>
                        <span class="focus-input3"></span>
                     </div>
                     <div class="wrap-input3">
                        <input class="input3" type="password" name="password" placeholder="Contraseña" autocomplete="off" required>
                        <span class="focus-input3"></span>
                     </div>
                     <div class="wrap-input3">
                        <input class="input3" type="password" name="passconfirm" placeholder="Repite contraseña" autocomplete="off" required>
                        <span class="focus-input3"></span>
                     </div>
                     <div class="container-contact3-form-btn d-flex justify-content-center">
                        <button type="submit" class="btn contact3-form-btn">Registrar</button>
                     </div>
                     <div class="d-flex justify-content-center text-center mt-4 pt-1 socials">
                        <a href="#!" class="text-white"><i class="bi bi-facebook mx-3" style="font-size: 2rem"></i></a>
                        <a href="#!" class="text-white social"><i class="bi bi-twitter mx-3" style="font-size: 2rem"></i></a>
                        <a href="#!" class="text-white social"><i class="bi bi-google mx-3" style="font-size: 2rem"></i></a>
                     </div>
                     <div class="d-flex justify-content-center redirect">
                        <p class="mt-3">¿Ya tienes cuenta?<a href="login.jsp" id="linkLogin" class="text-white-50 fw-bold ps-1">Login</a></p>
                     </div>
                  </form>
               </div>
            </div>
         </div>
         <!-- ***** Form Fin ***** -->
         <!-- ***** Footer ***** -->
         <jsp:include page="footer.jsp" />
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
   </body>
</div>
</body>
</html>
