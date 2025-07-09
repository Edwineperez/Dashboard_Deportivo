
package Conexion;

import java.sql.Connection;

public class Comprobar {
    public static void main(String[] args) {
        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conexion a la base de datos exitosa.");
        } else {
            System.out.println("No se pudo establecer la conexion con la base de datos.");
        }
    }
}
