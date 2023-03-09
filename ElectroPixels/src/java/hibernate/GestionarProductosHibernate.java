package hibernate;

import hibernate.Productos;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class GestionarProductosHibernate {

   public List<Productos> obtenerTodosProductos() {
      List<Productos> productos = new ArrayList<>();
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();

      Session session = sessionFactory.openSession();
      try {
         //Iniciar una transacción
         session.beginTransaction();
         //Ejecutar una consulta para obtener todos los productos
         productos = session.createQuery("FROM productos").list();
         //Finalizar la transacción y cerrar la sesión
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         // Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
         session.close();
         sessionFactory.close();
      }
      return productos;
   }

   public Productos obtenerProducto(int id) {
      Productos producto = null;
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();
      try {
         //Iniciar una transacción
         session.beginTransaction();
         //Ejecutar una consulta para obtener el producto con ese id
         producto = session.get(Productos.class, id);
         //Finalizar la transacción y cerrar la sesión
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         // Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
         session.close();
         sessionFactory.close();
      }
      return producto;
   }

   public List<Productos> filtrarProductos(String terminoBusqueda) {
      List<Productos> resultados = new ArrayList<>();
      SessionFactory sessionFactory = new Configuration()
              .configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();
      try {
         // Iniciar una transacción
         session.beginTransaction();
         // Crear una consulta para buscar productos por nombre de producto o autor
         Query<Productos> consulta = session.createQuery("FROM productos WHERE titulo LIKE :terminoBusqueda OR autor LIKE :terminoBusqueda", Productos.class);
         consulta.setParameter("terminoBusqueda", "%" + terminoBusqueda + "%");
         resultados = consulta.getResultList();
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         // Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
         session.close();
         sessionFactory.close();
      }

      return resultados;
   }

   public void insertarProducto(Productos producto) {
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();

      Session miSesion = sessionFactory.openSession();
      try {
         //Iniciar transaccion
         miSesion.beginTransaction();
         //Con esta acción se debería guardar además del producto la info relacionada.
         miSesion.save(producto);
         miSesion.getTransaction().commit();
         System.out.println("Producto correctamente insertado.");
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         sessionFactory.close();
         sessionFactory.close();
         sessionFactory.close();
      }
   }

   public void eliminarProducto(int id) {
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();
      try {
         //Iniciar una transacción
         session.beginTransaction();
         //Ejecutar una consulta para obtener el producto con ese id
         Productos producto = session.get(Productos.class, id);
         if (producto != null) {
            //Eliminar el producto de la tabla de datos
            session.delete(producto);
            out.println("El producto ha sido eliminado correctamente.");
         } else {
            out.println("No se pudo encontrar el producto con el ID proporcionado.");
         }
         session.getTransaction().commit();
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         // Finalizar la transacción y cerrar la sesión
         session.close();
         sessionFactory.close();
      }
   }

   public List<Productos> obtenerProductosAleatorios(int numProductos) {
      List<Productos> productos = new ArrayList<>();
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();
      try {
         // Iniciar una transacción
         session.beginTransaction();

         // Obtener el número total de productos
         Query queryCount = session.createQuery("SELECT COUNT(*) FROM productos");
         Long countResult = (Long) queryCount.uniqueResult();

         // Calcular una lista de índices aleatorios
         List<Integer> randomIndices = new ArrayList<>();
         Random random = new Random();
         for (int i = 0; i < numProductos; i++) {
            randomIndices.add(random.nextInt(countResult.intValue()));
         }

         // Obtener una lista de productos aleatorios basada en los índices
         Query queryProductos = session.createQuery("FROM productos");
         queryProductos.setFirstResult(randomIndices.get(0));
         queryProductos.setMaxResults(numProductos);
         productos = queryProductos.list();
      } catch (Exception e) {
         System.out.println(e.getMessage());
      } finally {
         // Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
         session.close();
         sessionFactory.close();
      }

      return productos;
   }

}
