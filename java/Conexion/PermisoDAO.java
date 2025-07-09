package Conexion;

import Gestion.Permiso;
import java.sql.*;
import java.util.*;

public class PermisoDAO {
    
    private Connection con;

    public PermisoDAO(Connection con) {
        this.con = con;
    }

    public List<Permiso> obtenerTodos() throws SQLException {
        List<Permiso> lista = new ArrayList<>();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM permisos");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            lista.add(new Permiso(rs.getInt("id"), rs.getString("nombre")));
        }
        return lista;
    }

    public void insertar(Permiso permiso) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("INSERT INTO permisos(nombre) VALUES(?)");
        stmt.setString(1, permiso.getNombre());
        stmt.executeUpdate();
    }

    public void actualizar(Permiso permiso) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("UPDATE permisos SET nombre = ? WHERE id = ?");
        stmt.setString(1, permiso.getNombre());
        stmt.setInt(2, permiso.getId());
        stmt.executeUpdate();
    }

    public void eliminar(int id) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("DELETE FROM permisos WHERE id = ?");
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}
