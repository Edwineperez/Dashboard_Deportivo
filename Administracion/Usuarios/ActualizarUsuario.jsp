<%@page import="Gestion.HashUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="Conexion.DAOUSUARIO" %>
<%@ page import="Gestion.Usuario" %>
<%@ page import="Gestion.Rol" %>
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
        
        if(password != null && !password.isEmpty()) {
            usuario.setPassword(HashUtil.hashSHA256(password));
            dao.actualizarUsuarioCompleto(usuario);
        } else {
            dao.actualizarUsuario(usuario);
        }
        
        response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?success=Usuario actualizado correctamente");
        
    } catch(Exception e) {
        response.sendRedirect("/Formulario/Administracion/Usuarios/EditarUsuario.jsp?id=" + userId + "&error=Error al actualizar usuario: " + e.getMessage());
    } finally {
        if(conn != null) conn.close();
    }
%>
