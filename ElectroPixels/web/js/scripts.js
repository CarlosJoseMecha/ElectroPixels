let usuarioSeleccionado;

function seleccionarUsuario(id) {
   return (usuarioSeleccionado = id);
}
function eliminarUsuario() {
   let form = document.getElementById("eliminarUsuarioForm");
   form.setAttribute("action", "eliminar-usuario?id=" + usuarioSeleccionado);
   form.submit();
}
function eliminarProducto() {
   let form = document.getElementById("eliminarProductoForm");
   form.setAttribute("action", "eliminar-producto?id=" + usuarioSeleccionado);
   form.submit();
}

function editarUsuario(id) {
   let form = document.getElementById("editarUsuarioModal");
   form.setAttribute("data-bs-target", "editarUsuarioModal?idUsuario=" + id);
}

function setearID(id) {
   console.log("id seleccionado: " + id);
   var xhr = new XMLHttpRequest();
   xhr.open("POST", "gestionar-usuarios.jsp?id=" + id, true);
   xhr.send();
}


