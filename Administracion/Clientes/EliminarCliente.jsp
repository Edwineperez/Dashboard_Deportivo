<%@page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="Gestion.Persona, Conexion.ConexionBD, Conexion.ClienteDAO" %>
<%@ page import="java.sql.Connection" %>

<%
    String documento = request.getParameter("documento");

    if (documento == null || documento.trim().isEmpty()) {
%>
        <script>
            alert("No se proporcionó el documento del cliente.");
            history.back();
        </script>
<%
        return;
    }

    try {
        Connection conn = ConexionBD.conectar();
        ClienteDAO dao = new ClienteDAO(conn);
        boolean eliminado = dao.eliminarCliente(documento);

        if (eliminado) {
%>
            <script>
                alert("Cliente eliminado correctamente.");
                window.location.href = "/Formulario/Administracion/Clientes/ConsultarCliente.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("No se pudo eliminar el cliente. Verifique que el documento exista.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Error al intentar eliminar el cliente: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    }
%>
