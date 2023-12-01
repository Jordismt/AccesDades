/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Usuario;
import ORM.HhibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class UsuarioDAO {

    public void saveOrUpdate(Usuario usuario) {
        Transaction transaction = null;
        Session session = HhibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();
            session.saveOrUpdate(usuario);
            transaction.commit();
            System.out.println("usuari añadit");
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

    public Usuario getById(Long id) {
        Session session = HhibernateUtil.getSessionFactory().openSession();
        try {
            return session.get(Usuario.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close(); // Cerrar la sesión de manera explícita al finalizar
        }
    }
}







