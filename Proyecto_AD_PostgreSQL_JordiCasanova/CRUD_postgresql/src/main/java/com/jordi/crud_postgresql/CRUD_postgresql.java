/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.jordi.crud_postgresql;

import DAO.EmpleadoDAO;
import DAO.UsuarioDAO;
import Model.Empleado;
import Model.Usuario;
import ORM.HhibernateUtil;

import java.util.Scanner;

public class CRUD_postgresql {

    public static void main(String[] args) {
        try{
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            EmpleadoDAO empDAO= new EmpleadoDAO();
            Scanner scanner = new Scanner(System.in);

            boolean continuar = true;
            while (continuar) {
                System.out.println("Opciones:");
                System.out.println("1. Agregar usuario");
                System.out.println("2. Buscar usuario por ID");
                System.out.println("3. Salir");
                System.out.println("4. Agregar empleado");
                System.out.print("Seleccione una opción: ");

                int opcion = scanner.nextInt();
                scanner.nextLine(); // Limpiar el buffer de entrada

                switch (opcion) {
                    case 1:
                        System.out.print("Ingrese el ID: ");
                        Long id = scanner.nextLong();
                        scanner.nextLine();
                        System.out.print("Ingrese el nombre: ");
                        String nombre = scanner.nextLine();
                        System.out.print("Ingrese el apellido: ");
                        String apellido = scanner.nextLine();
                        System.out.print("Ingrese el email: ");
                        String email = scanner.nextLine();

                        Usuario nuevoUsuario = new Usuario();
                        nuevoUsuario.setId(id);
                        nuevoUsuario.setNombre(nombre);
                        nuevoUsuario.setApellido(apellido);
                        nuevoUsuario.setEmail(email);

                        usuarioDAO.saveOrUpdate(nuevoUsuario);
                        //System.out.println("Usuario agregado exitosamente.");
                        break;
                    case 2:
                        System.out.print("Ingrese el ID del usuario a buscar: ");
                        Long idBuscar = scanner.nextLong();
                        scanner.nextLine(); // Limpiar el buffer de entrada

                        Usuario usuarioRecuperado = usuarioDAO.getById(idBuscar);
                        if (usuarioRecuperado != null) {
                            System.out.println("Usuario encontrado:");
                            System.out.println("ID: " + usuarioRecuperado.getId());
                            System.out.println("Nombre: " + usuarioRecuperado.getNombre());
                            System.out.println("Apellido: " + usuarioRecuperado.getApellido());
                            System.out.println("Email: " + usuarioRecuperado.getEmail());
                        } else {
                            System.out.println("No se encontró el usuario con el ID especificado.");
                        }
                        break;
                    case 3:
                        continuar = false;
                        HhibernateUtil.getSessionFactory().close();
                        scanner.close();
                        break;
                    case 4:
                        System.out.print("Ingrese el ID: ");
                        Long idemp = scanner.nextLong();
                        scanner.nextLine();
                        System.out.print("Ingrese el nombre: ");
                        String nombremp = scanner.nextLine();
                        System.out.print("Ingrese el apellido: ");
                        String apellidoemp = scanner.nextLine();
                        System.out.print("Ingrese el email: ");
                        String emailemp = scanner.nextLine();
                         Empleado emp=new Empleado();
                         emp.setId(idemp);
                         emp.setNombre(nombremp);
                         emp.setApellido(apellidoemp);
                         emp.setEmail(emailemp);
                         
                         empDAO.saveOrUpdate(emp);
                         break;
                    default:
                        System.out.println("Opción no válida. Intente nuevamente.");
                        break;
                }
            }
        }
        catch(Exception e){
            System.out.println("ERROR"+e);
        }

       
    }
}

