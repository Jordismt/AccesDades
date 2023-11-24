/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.act_paging_jordi;

/**
 *
 * @author jordi
 */


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.List;
import java.util.Scanner;
import org.hibernate.cfg.Configuration;

public class Act_Paging_Jordi {

    private static final int PAGE_SIZE = 12;
    private static int currentPage = 1;
    private static int totalPages;

    public static void main(String[] args) {
        SessionFactory sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();

        try (Session session = sessionFactory.openSession()) {
            displayPage(session);

            Scanner scanner = new Scanner(System.in);
            String input;
            while (true) {
                System.out.println("Enter an option: <S> next, <A> previous, <G n> Go to n, <Q> quit");
                input = scanner.nextLine().trim().toUpperCase();

                if ("Q".equals(input)) {
                    break;
                } else if ("S".equals(input)) {
                    if (currentPage < totalPages) {
                        currentPage++;
                        displayPage(session);
                    } else {
                        System.out.println("You've reached the last page.");
                    }
                } else if ("A".equals(input)) {
                    if (currentPage > 1) {
                        currentPage--;
                        displayPage(session);
                    } else {
                        System.out.println("You're already on the first page.");
                    }
                } else if (input.startsWith("G ")) {
                    try {
                        int page = Integer.parseInt(input.substring(2));
                        if (page >= 1 && page <= totalPages) {
                            currentPage = page;
                            displayPage(session);
                        } else {
                            System.out.println("Invalid page number. Please enter a valid page.");
                        }
                    } catch (NumberFormatException | StringIndexOutOfBoundsException e) {
                        System.out.println("Invalid input. Please enter a valid page number.");
                    }
                } else {
                    System.out.println("Invalid input. Please enter a valid option.");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            sessionFactory.close();
        }
    }

    private static void displayPage(Session session) {
        List<Employee> employees = session.createQuery("FROM Employee", Employee.class)
                .setFirstResult((currentPage - 1) * PAGE_SIZE)
                .setMaxResults(PAGE_SIZE)
                .getResultList();

        for (Employee employee : employees) {
            System.out.println(employee); 
        }

        totalPages = (int) Math.ceil((double) getTotalRecords(session) / PAGE_SIZE);
        System.out.println("<Page " + currentPage + " of " + totalPages + ">");
    }

    private static long getTotalRecords(Session session) {
        return (Long) session.createQuery("SELECT COUNT(*) FROM Employee").uniqueResult();
    }
}

