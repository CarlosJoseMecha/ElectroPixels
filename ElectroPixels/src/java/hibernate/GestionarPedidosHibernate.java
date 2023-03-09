package hibernate;

import static java.lang.System.out;
import java.util.Date;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class GestionarPedidosHibernate {

   public int insertarPedido(List<Productos> listaProductos, int id, float totalPedido) {
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Productos.class)
              .buildSessionFactory();

      Session session = sessionFactory.openSession();
      try {
         //Obtenemos el Usuario
         Usuario usuario = session.get(Usuario.class, id);
         // Genera la fecha actual
         Date fechaActual = new Date();
         // Convierte la fecha a un objeto java.sql.Date
         java.sql.Date fecha = new java.sql.Date(fechaActual.getTime());
         //Crea el pedido
         Pedido nuevoPedido = new Pedido(fecha, listaProductos, totalPedido);
         //Agrega el pedido al cliente
         usuario.agregarPedido(nuevoPedido);
         //Iniciar una transacción
         session.beginTransaction();
         //Ejecutar una consulta
         session.save(nuevoPedido);
         //Obtener el ID del nuevo pedido
         int idPedido = nuevoPedido.getId();
         //Finalizar la transacción y cerrar la sesión
         session.getTransaction().commit();
         out.println("PEDIDO INSERTADO CON EXITO");
         return idPedido;
      } catch (Exception e) {
         out.println("ERROR AL INSERTAR EL PEDIDO");
         out.println(e.getMessage());
         out.println(e.getStackTrace());
         return -1; // valor por defecto en caso de fallo
      } finally {
         session.close();
         sessionFactory.close();
      }
   }

   public List<Pedido> obtenerTodosPedidos(int id_usuario) {
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Pedido.class)
              .buildSessionFactory();

      Session session = sessionFactory.openSession();

      List<Pedido> pedidos = null;
      try {
         Query<Pedido> query = session.createQuery(
                 "SELECT p FROM Pedido p JOIN FETCH p.usuario u WHERE u.id = :idUsuario",
                 Pedido.class);
         query.setParameter("idUsuario", id_usuario);

         pedidos = query.getResultList();
      } finally {
         session.close();
         sessionFactory.close();
      }

      return pedidos;
   }

   public Pedido obtenerPedidoPorId(int idPedido) {
      SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml")
              .addAnnotatedClass(Pedido.class)
              .buildSessionFactory();
      Session session = sessionFactory.openSession();

      Pedido pedido = null;
      try {
         session.beginTransaction();
         pedido = session.get(Pedido.class, idPedido);
         Hibernate.initialize(pedido.getProductos());
         session.getTransaction().commit();
      } catch (Exception e) {
         e.printStackTrace();
         session.getTransaction().rollback();
      }

      return pedido;
   }

   public void cerrarSesion(Session session, SessionFactory sessionFactory) {
      try {
         session.getTransaction().commit();
      } catch (Exception e) {
         session.getTransaction().rollback();
      } finally {
         if (session != null) {
            session.close();
         }
         if (sessionFactory != null) {
            sessionFactory.close();
         }
      }
   }

}
