package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/* Esta clase es creada con el fin de realizar la conexion con la base de datos de MySQL y 
 de esta forma se enlace con la tabla registro y se puedan guardar los datos basicos del registro.*/
public class ConexionBD {
/* Estas líneas definen tres constantes que contienen la información de conexión a la base de datos.*/
    
    private static final String BASEDATOS = "administracion";
    private static final String URL = "jdbc:mysql://localhost:3306/" + BASEDATOS;
    private static final String USER = "root";
    private static final String PASSWORD = "990204";

    // Método para obtener conexión
    public static Connection conectar() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); /* Class.forName() es un método utilizado para cargar la clase Driver de forma dinámica. */
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        /* De esta manera, el driver se registra automáticamente y se establece la conexión con la base de datos 
         sin necesidad de crear un objeto explícito de la clase Driver.
         El driver se encarga de gestionar la comunicación entre la aplicación Java y el servidor de la base de datos MySQL. */
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de conexión" + e.getMessage());
        }
        return conn;
    }
}



