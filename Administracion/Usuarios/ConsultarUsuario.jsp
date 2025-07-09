<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Gestion.Usuario" %>
<%@ page import="Gestion.Rol" %>
<%@ page import="Conexion.DAOUSUARIO" %>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="java.sql.Connection" %>

<%
    
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    List<String> permisos = (List<String>) session.getAttribute("permisos");

    if (usuario == null || rol == null || permisos == null) {
        response.sendRedirect("/Formulario/Login/login.jsp");
        return;
    }
    
    Connection conn = ConexionBD.conectar();
    DAOUSUARIO dao = new DAOUSUARIO(conn);
    List<Usuario> lista = dao.listarUsuariosConRol();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Real Academy</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../Administracion/Usuarios/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>

    <div class="sidebar">
        <div class="logo"></div>
        <ul class="menu">
            <li class="active">
                <a href="../../Dashboard/Panel.jsp">
                    <i class="fa-solid fa-house"></i>
                    <span>Inicio</span>
                </a>
            </li>
                <li>
                    <% if (permisos.contains("crear_clientes")) { %>
                    <a href="../../Registro/FormRegistro.html">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>Cliente Nuevo</span>
                    </a>
                    <% }%>
                </li>      
                <li>
                    
            <%-- Acceso: gestionar clientes (ambos, pero distinto comportamiento) --%>
            <% if (permisos.contains("ver_clientes")) { %>
            <a href="../../Administracion/Clientes/ConsultarCliente.jsp">
                        <i class="fa-solid fa-users"></i>
                        <span>Gestión Clientes</span>
                    </a>
                    <% }%>
                </li>
                <li>
                    <%-- Acceso: gestión de usuarios (solo admin) --%>
                    <% if (permisos.contains("ver_empleados")) { %>
                    <a href="../../Administracion/Usuarios/ConsultarUsuario.jsp">
                        <i class="fa-solid fa-users-gear"></i>
                        <span>Gestion Usuarios</span>
                    </a>
                    <% }%>
                </li>
        </ul>
    </div>

    <div class="main--content">
        <div class="header--wrapper">
            <div class="header--title">
                <h2>Gestión De Usuarios</h2>
            </div>
            <div class="user--info">
                <img src="../../Administracion/Usuarios/css/Perfil.jpeg" alt="Perfil"/>
            </div>
        </div>

        <div class="tabular--wrapper">

            <form action="actualizarUsuario.jsp" method="post" class="mb-3 row g-3 align-items-center">

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Rol</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (lista == null || lista.isEmpty()) {
                            %>
                            <tr>
                                <td colspan="5" class="text-center">No se encontraron usuarios</td>
                            </tr>
                            <%
                            } else {
                                for (Usuario u : lista) {
                            %>
                            <tr>
                                <td><%= u.getId()%></td>
                                <td><%= u.getUsuario()%></td>
                                <td><%= u.getRol() != null ? u.getRol().getNombre() : "Sin rol"%></td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="../../Administracion/Usuarios/EliminarUsuario.jsp?id=<%= u.getId()%>" class="btn btn-danger btn-sm"
                                           onclick="return confirm('¿Seguro que deseas eliminar este usuario?')">
                                            <i class="fas fa-trash"></i> Eliminar
                                        </a>
                                           </div>
                                           <div class="btn-group" role="group">
                                               <a href="../../Administracion/Usuarios/EditarUsuario.jsp?id=<%= u.getId()%>" class="btn btn-warning btn-sm">
                                            <i class="fas fa-key"></i> Editar
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table><br>
                    
                    <div class="text-end">
                    <a href="../../Administracion/Usuarios/CrearUsuario.jsp" class="btn btn-success">Crear Usuario</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
