<%@page import="Gestion.HashUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Conexion.ConexionBD" %>
<%@ page import="Conexion.DAOUSUARIO, Gestion.Usuario, Gestion.Permiso" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="java.util.ArrayList" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/administracion", "root", "990204");

        String sql = "SELECT u.id, u.username, u.password, r.nombre AS rol " +
                     "FROM usuarios u " +
                     "JOIN roles r ON u.rol_id = r.id " +
                     "WHERE u.username = ?";

        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();

        if (rs.next()) {
            String storedHash = rs.getString("password");
            String inputHash = HashUtil.hashSHA256(password);
            
            if (storedHash.equals(inputHash)) {
                int userId = rs.getInt("id");
                String rolRaw = rs.getString("rol");
                String rol = "";

                if (rolRaw.equalsIgnoreCase("administrador")) {
                    rol = "administrador";
                } else if (rolRaw.equalsIgnoreCase("empleado")) {
                    rol = "empleado";
                }

                // Obtener permisos del rol
                String permisosSql = "SELECT p.nombre " +
                                   "FROM rol_permiso rp " +
                                   "JOIN permisos p ON rp.permiso_id = p.id " +
                                   "WHERE rp.rol_id = (SELECT rol_id FROM usuarios WHERE id = ?)";

                PreparedStatement permisosStmt = conn.prepareStatement(permisosSql);
                permisosStmt.setInt(1, userId);
                ResultSet permisosRs = permisosStmt.executeQuery();

                List<String> permisos = new ArrayList<>();
                while (permisosRs.next()) {
                    permisos.add(permisosRs.getString("nombre"));
                }

                session.setAttribute("usuario", username);
                session.setAttribute("rol", rol);
                session.setAttribute("permisos", permisos);

                response.sendRedirect("/Formulario/Dashboard/Panel.jsp");
            } else {
                out.println("<p style='color:red'>Contraseña incorrecta.</p>");
            }
        } else {
            out.println("<p style='color:red'>Usuario no encontrado.</p>");
        }

    } catch (Exception e) {
        out.println("<p style='color:red'>Error en login: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>




