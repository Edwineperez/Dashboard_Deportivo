<%@page import="Gestion.Rol"%>
<%@page import="Gestion.Usuario"%>
<%@page import="Gestion.HashUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="Conexion.DAOUSUARIO" %>
<%@ page import="java.sql.Connection" %>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    String username = request.getParameter("username");
    int rolId = Integer.parseInt(request.getParameter("rol_id"));
    String password = request.getParameter("password");
    
    Connection conn = null;
    try {
        conn = ConexionBD.conectar();
        DAOUSUARIO dao = new DAOUSUARIO(conn);
        
        Usuario usuario = new Usuario();
        usuario.setId(userId);
        usuario.setUsuario(username);
        usuario.setRol(new Rol(rolId, ""));
        
        // Solo actualizar contraseña si se proporcionó una nueva
        if(password != null && !password.trim().isEmpty()) {
            String hashedPassword = HashUtil.hashSHA256(password);
            usuario.setPassword(hashedPassword);
            dao.actualizarUsuarioCompleto(usuario);
            response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?success=Usuario y contraseña actualizados correctamente");
        } else {
            dao.actualizarUsuario(usuario);
            response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?success=Usuario actualizado correctamente (contraseña no cambiada)");
        }
        
    } catch(Exception e) {
        response.sendRedirect("/Formulario/Administracion/Usuarios/EditarUsuario.jsp?id=" + userId + "&error=Error al actualizar usuario: " + e.getMessage());
    } finally {
        if(conn != null) conn.close();
    }
%>
