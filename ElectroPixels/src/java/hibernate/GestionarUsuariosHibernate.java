package hibernate;

import static java.lang.System.out;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class GestionarUsuariosHibernate {

   List<Usuario> listaUsuarios = new ArrayList<>();

   public List<Usuario> getTodosUsuarios() {
      SessionFactory sessionFactory = new Configuration()
              .configure("hibernate.cfg.xml")
              .addAnnotatedClass(Usuario.class)
              .addAnnotatedClass(Pedido.class)
              .buildSessionFactory();

      Session session = sessionFactory.openSession();
      try {
         //Iniciar una transacción
         session.beginTransaction();
         //Ejecutar una consulta para obtener todos los productos
         listaUsuarios = session.createQuery("FROM usuarios").list();
         //Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         session.close();
         sessionFactory.close();
      }
      return listaUsuarios;
   }

   public void insertarUsuario(Usuario usuario) {
      SessionFactory sessionFactory = new Configuration()
              .configure("hibernate.cfg.xml")
              .addAnnotatedClass(Usuario.class)
              .addAnnotatedClass(Pedido.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();

      try {
         session.beginTransaction();
         session.save(usuario);
         session.getTransaction().commit();
      } catch (Exception e) {
         e.printStackTrace();
         session.getTransaction().rollback();
      } finally {
         session.close();
         sessionFactory.close();
      }
   }

   public void eliminarUsuario(int id) {
      SessionFactory sessionFactory = new Configuration()
              .configure("hibernate.cfg.xml")
              .addAnnotatedClass(Usuario.class)
              .addAnnotatedClass(Pedido.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();
      try {
         out.println("BUSCANDO PARA ELIMINAR EL ID: " + id);
         // Carga el objeto usuario correspondiente al ID
         Usuario usuario = session.get(Usuario.class, id);

         // Elimina el objeto usuario
         session.beginTransaction();
         session.delete(usuario);
         session.getTransaction().commit();
      } catch (Exception e) {
         out.println("ERROR AL ELIMINAR USUARIO DE elextorpixels_db_hibernate");
         e.printStackTrace();
         session.getTransaction().rollback();
      } finally {
         session.close();
         sessionFactory.close();
      }
   }
}
