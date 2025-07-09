package Conexion;

import Gestion.HashUtil;
import Gestion.Usuario;
import Gestion.Rol;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DAOUSUARIO {
    private Connection conn;

    // Constructor que recibe la conexión
    public DAOUSUARIO(Connection conn) {
        this.conn = conn;
    }


public Usuario autenticar(String usuario, String password) {
        Usuario u = null;
        String sql = "SELECT u.id, u.username, u.password, r.id AS rol_id, r.nombre AS rol_nombre " +
                     "FROM usuarios u JOIN roles r ON u.rol_id = r.id " +
                     "WHERE u.username = ?";
        
        try (Connection con = ConexionBD.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, usuario);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("password");
                String inputHash = HashUtil.hashSHA256(password);
                
                if (storedHash.equals(inputHash)) {
                    u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setUsuario(rs.getString("username"));
                    u.setPassword(storedHash);
                    
                    Rol rol = new Rol();
                    rol.setId(rs.getInt("rol_id"));
                    rol.setNombre(rs.getString("rol_nombre"));
                    u.setRol(rol);
                    
                    List<String> permisos = obtenerPermisosPorRol(rol.getId(), con);
                    u.setPermisos(permisos);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en login: " + e.getMessage());
        }
        return u;
    }
    
       private List<String> obtenerPermisosPorRol(int rolId, Connection con) throws SQLException {
        List<String> permisos = new ArrayList<>();

        String sql = "SELECT p.nombre " +
                     "FROM permisos p " +
                     "JOIN rol_permiso rp ON p.id = rp.permiso_id " +
                     "WHERE rp.rol_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, rolId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                permisos.add(rs.getString("nombre"));
            }
        }

        return permisos;
    }
       
       
public List<Usuario> listarUsuariosConRol() {
    List<Usuario> usuarios = new ArrayList<>();
    String sql = "SELECT u.id, u.username, u.password, r.id AS rol_id, r.nombre AS rol_nombre " +
                 "FROM usuarios u " +
                 "LEFT JOIN roles r ON u.rol_id = r.id";

    try (PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Rol rol = new Rol(rs.getInt("rol_id"), rs.getString("rol_nombre"));

            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setUsuario(rs.getString("username"));
            u.setRol(rol);

            usuarios.add(u);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return usuarios;
}

    public boolean crearUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuarios (username, password, rol_id) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String hashed = HashUtil.hashSHA256(usuario.getPassword());
            stmt.setString(1, usuario.getUsuario());
            stmt.setString(2, hashed);
            stmt.setInt(3, usuario.getRol().getId());
            int filas = stmt.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

public boolean actualizarUsuario(Usuario usuario) throws SQLException {
    String sql = "UPDATE usuarios SET username = ?, rol_id = ? WHERE id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, usuario.getUsuario());
        stmt.setInt(2, usuario.getRol().getId());
        stmt.setInt(3, usuario.getId());
        return stmt.executeUpdate() > 0;
    }
}

public boolean actualizarUsuarioCompleto(Usuario usuario) throws SQLException {
    String sql = "UPDATE usuarios SET username = ?, password = ?, rol_id = ? WHERE id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, usuario.getUsuario());
        stmt.setString(2, usuario.getPassword());
        stmt.setInt(3, usuario.getRol().getId());
        stmt.setInt(4, usuario.getId());
        return stmt.executeUpdate() > 0;
    }
}

public boolean eliminarUsuario(int id) {
    String sql = "DELETE FROM usuarios WHERE id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, id);
        stmt.executeUpdate();
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public void actualizarContraseñasASHA256() throws SQLException {
    String selectSql = "SELECT id, password FROM usuarios";
    String updateSql = "UPDATE usuarios SET password = ? WHERE id = ?";
    
    try (PreparedStatement selectStmt = conn.prepareStatement(selectSql);
         PreparedStatement updateStmt = conn.prepareStatement(updateSql);
         ResultSet rs = selectStmt.executeQuery()) {
        
        while (rs.next()) {
            String plainPassword = rs.getString("password");
            // Si la contraseña ya está hasheada (empieza con $2a$), la saltamos
            if (plainPassword.startsWith("$2a$")) continue;
            
            String hashed = HashUtil.hashSHA256(plainPassword);
            updateStmt.setString(1, hashed);
            updateStmt.setInt(2, rs.getInt("id"));
            updateStmt.executeUpdate();
        }
    }
}

// Añade estos métodos a tu clase DAOUSUARIO

public Usuario obtenerUsuarioPorId(int id) throws SQLException {
    String sql = "SELECT u.id, u.username, u.password, r.id AS rol_id, r.nombre AS rol_nombre " +
                 "FROM usuarios u JOIN roles r ON u.rol_id = r.id " +
                 "WHERE u.id = ?";
    
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setUsuario(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            
            Rol rol = new Rol();
            rol.setId(rs.getInt("rol_id"));
            rol.setNombre(rs.getString("rol_nombre"));
            u.setRol(rol);
            
            return u;
        }
    }
    return null;
}

}



