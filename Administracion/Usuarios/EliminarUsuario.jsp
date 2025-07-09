<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="Conexion.DAOUSUARIO" %>
<%@ page import="java.sql.Connection" %>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    
    Connection conn = null;
    try {
        conn = ConexionBD.conectar();
        DAOUSUARIO dao = new DAOUSUARIO(conn);
        
        boolean resultado = dao.eliminarUsuario(userId);
        
        if(resultado) {
            response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?success=Usuario eliminado correctamente");
        } else {
            response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?error=Error al eliminar usuario");
        }
        
    } catch(Exception e) {
        response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?error=Error al eliminar usuario: " + e.getMessage());
    } finally {
        if(conn != null) conn.close();
    }
%>
