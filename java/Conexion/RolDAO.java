package Conexion;

import Gestion.Rol;
import java.sql.*;
import java.util.*;

public class RolDAO {
    
    private Connection con;

    public RolDAO(Connection con) {
        this.con = con;
    }

    public List<Rol> obtenerTodos() throws SQLException {
        List<Rol> roles = new ArrayList<>();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM roles");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            roles.add(new Rol(rs.getInt("id"), rs.getString("nombre")));
        }
        return roles;
    }

    public Rol obtenerPorId(int id) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM roles WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return new Rol(rs.getInt("id"), rs.getString("nombre"));
        }
        return null;
    }

    public void insertar(Rol rol) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("INSERT INTO roles(nombre) VALUES(?)");
        stmt.setString(1, rol.getNombre());
        stmt.executeUpdate();
    }

    public void actualizar(Rol rol) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("UPDATE roles SET nombre = ? WHERE id = ?");
        stmt.setString(1, rol.getNombre());
        stmt.setInt(2, rol.getId());
        stmt.executeUpdate();
    }

    public void eliminar(int id) throws SQLException {
        PreparedStatement stmt = con.prepareStatement("DELETE FROM roles WHERE id = ?");
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}

