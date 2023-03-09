package hibernate;

import javax.persistence.*;

/**
 *
 * @author Carlos José Mecha
 */
@Entity(name = "productos")
@Table(name = "productos")
public class Productos {

   /**
    *
    */
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private int id;

   /**
    *
    */
   @Column(name = "titulo")
   private String titulo;

   /**
    *
    */
   @Column(name = "precio")
   private float precio;

   /**
    *
    */
   @Column(name = "autor")
   private String autor;

   /**
    *
    */
   @Column(name = "URLimagen")
   private String URLimagen;

   /**
    *
    */
   @Column(name = "URLperfil")
   private String URLperfil;

   /**
    *
    */
   @Column(name = "cantidad")
   private int cantidad;

   /**
    *
    */
   public Productos() {
   }

   /**
    *
    * @param titulo
    * @param precio
    * @param autor
    * @param URLimagen
    * @param URLperfil
    * @param cantidad
    */
   public Productos(String titulo, float precio, String autor, String URLimagen, String URLperfil, int cantidad) {
      this.titulo = titulo;
      this.precio = precio;
      this.autor = autor;
      this.URLimagen = URLimagen;
      this.URLperfil = URLperfil;
      this.cantidad = cantidad;
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
   public String getTitulo() {
      return titulo;
   }

   /**
    *
    * @param titulo
    */
   public void setTitulo(String titulo) {
      this.titulo = titulo;
   }

   /**
    *
    * @return
    */
   public float getPrecio() {
      return precio;
   }

   /**
    *
    * @param precio
    */
   public void setPrecio(float precio) {
      this.precio = precio;
   }

   /**
    *
    * @return
    */
   public String getAutor() {
      return autor;
   }

   /**
    *
    * @param autor
    */
   public void setAutor(String autor) {
      this.autor = autor;
   }

   /**
    *
    * @return
    */
   public String getURLimagen() {
      return URLimagen;
   }

   /**
    *
    * @param URLimagen
    */
   public void setURLimagen(String URLimagen) {
      this.URLimagen = URLimagen;
   }

   /**
    *
    * @return
    */
   public String getURLperfil() {
      return URLperfil;
   }

   /**
    *
    * @param URLperfil
    */
   public void setURLperfil(String URLperfil) {
      this.URLperfil = URLperfil;
   }

   /**
    *
    * @return
    */
   public int getCantidad() {
      return cantidad;
   }

   /**
    *
    * @param cantidad
    */
   public void setCantidad(int cantidad) {
      this.cantidad = cantidad;
   }

   /**
    *
    * @return
    */
   @Override
   public String toString() {
      return "Productos{" + "id=" + id + ", titulo=" + titulo + ", precio=" + precio + ", autor=" + autor + ", URLimagen=" + URLimagen + ", URLperfil=" + URLperfil + ", cantidad=" + cantidad + '}';
   }

}
