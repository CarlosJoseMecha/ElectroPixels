package hibernate;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "pedidos")
public class Pedido {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private int id;

   @Column(name = "fecha_pedido")
   private Date fecha;

   @Column(name = "estado")
   private String estado;

   @Column(name = "total_pedido")
   private Float totalPedido;
   //Con esto establecemos la dirección de la relación varios a uno, tendremos que hacer lo contrario
   //es decir 1 a varios en Cliente
   @ManyToOne(cascade = CascadeType.ALL)
   @JoinColumn(name = "id_usuario")
   private Usuario usuario;

   @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
   @JoinTable(
           name = "pedidos_productos",
           joinColumns = @JoinColumn(name = "id_pedido"),
           inverseJoinColumns = @JoinColumn(name = "id_producto")
   )
   private List<Productos> productos = new ArrayList<>();

   public Pedido() {
   }

   public Pedido(Date fecha, List<Productos> carrito, float totalPedido) {
      this.fecha = fecha;
      this.estado = generarEstadoAleatorio();
      this.totalPedido = totalPedido;
      this.productos = carrito;
   }

   private String generarEstadoAleatorio() {
      String[] estados = {"procesado", "enviado", "recibido"};
      int indice = (int) (Math.random() * 3);
      return estados[indice];
   }

   public void setProductos(List<Productos> productos) {
      this.productos = productos;
   }

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public Date getFecha() {
      return fecha;
   }

   public String getFechaFormateada() {
      SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
      return formatoFecha.format(fecha);
   }

   public void setFecha(Date fecha) {
      this.fecha = fecha;
   }

   public String getEstado() {
      return estado;
   }

   public void setEstado(String estado) {
      this.estado = estado;
   }

   public Usuario getUsuario() {
      return usuario;
   }

   public void setUsuario(Usuario usuario) {
      this.usuario = usuario;
   }

   public List<Productos> getProductos() {
      return productos;
   }

   @Override
   public String toString() {
      return "Pedido{" + "id=" + id + ", fecha=" + fecha + ", estado=" + estado + ", totalPedido=" + totalPedido + ", usuario=" + usuario + ", productos=" + productos + '}';
   }

   public Float getTotalPedido() {
      return totalPedido;
   }

   public void setTotalPedido(Float totalPedido) {
      this.totalPedido = totalPedido;
   }

}
