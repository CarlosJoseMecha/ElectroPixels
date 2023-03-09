package hibernate;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author Carlos José Mecha
 */
@Entity
@Table(name = "usuarios")
public class Usuario {

   /**
    *
    */
   @Id
   @Column(name = "id")
   private int id;

   /**
    *
    */
   @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
   private List<Pedido> pedidos;

   /**
    *
    */
   @Column(name = "nombre")
   private String nombre;

   /**
    *
    */
   @Column(name = "email")
   private String email;

   /**
    *
    */
   @Transient
   private String password;

   /**
    *
    */
   @Transient
   private Float saldo;

   /**
    *
    */
   @Transient
   private String rol;

   /**
    *
    */
   public Usuario() {
   }

   /**
    *
    * @param id
    * @param nombre
    * @param email
    */
   public Usuario(int id, String nombre, String email) {
      this.id = id;
      this.nombre = nombre;
      this.email = email;
   }

   /**
    *
    * @param id
    * @param nombre
    * @param email
    * @param password
    * @param saldo
    * @param rol
    */
   public Usuario(int id, String nombre, String email, String password, Float saldo, String rol) {
      this.id = id;
      this.nombre = nombre;
      this.email = email;
      this.password = password;
      this.saldo = saldo;
      this.rol = rol;
   }

   /**
    *
    * @param pedido
    */
   public void agregarPedido(Pedido pedido) {
      if (this.pedidos == null) {
         this.pedidos = new ArrayList<>();
      }
      this.pedidos.add(pedido);
      //Con esto hacemos que el pedido asocie al este cliente
      pedido.setUsuario(this);
   }

   /**
    *
    * @return
    */
   public int getId() {
      return id;
   }

   /**
    *
    * @param id
    */
   public void setId(int id) {
      this.id = id;
   }

   /**
    *
    * @return
    */
   public List<Pedido> getPedidos() {
      return pedidos;
   }

   /**
    *
    * @param pedidos
    */
   public void setPedidos(List<Pedido> pedidos) {
      this.pedidos = pedidos;
   }

   /**
    *
    * @return
    */
   public String getNombre() {
      return nombre;
   }

   /**
    *
    * @param nombre
    */
   public void setNombre(String nombre) {
      this.nombre = nombre;
   }

   /**
    *
    * @return
    */
   public String getEmail() {
      return email;
   }

   /**
    *
    * @param email
    */
   public void setEmail(String email) {
      this.email = email;
   }

   /**
    *
    * @return
    */
   public String getPassword() {
      return password;
   }

   /**
    *
    * @param password
    */
   public void setPassword(String password) {
      this.password = password;
   }

   /**
    *
    * @return
    */
   public Float getSaldo() {
      return saldo;
   }

   /**
    *
    * @param saldo
    */
   public void setSaldo(Float saldo) {
      this.saldo = saldo;
   }

   /**
    *
    * @return
    */
   public String getRol() {
      return rol;
   }

   /**
    *
    * @param rol
    */
   public void setRol(String rol) {
      this.rol = rol;
   }

   /**
    *
    * @return
    */
   @Override
   public String toString() {
      return "Usuario{" + "id=" + id + ", pedidos=" + pedidos + ", nombre=" + nombre + ", email=" + email + ", password=" + password + ", saldo=" + saldo + ", rol=" + rol + '}';
   }

}
