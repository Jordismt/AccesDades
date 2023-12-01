/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Model.Empleado;
import ORM.HhibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
/**
 *
 * @author jordi
 */
public class EmpleadoDAO {
    public void saveOrUpdate(Empleado emp) {
        Transaction transaction = null;
        Session session = HhibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();
            session.saveOrUpdate(emp);
            transaction.commit();
            System.out.println("Empleat añadit");
        } catch (Exception e) {
            if (transaction != null) {
                System.out.println("ERROR "+e);
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close(); // Cerrar la sesión de manera explícita al finalizar
        }
    }

 
}
