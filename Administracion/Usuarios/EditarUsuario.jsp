<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="Conexion.DAOUSUARIO" %>
<%@ page import="Conexion.RolDAO" %>
<%@ page import="Gestion.Usuario" %>
<%@ page import="Gestion.Rol" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    Usuario usuario = null;
    List<Rol> roles = null;

    Connection conn = null;
    try {
        conn = ConexionBD.conectar();
        DAOUSUARIO dao = new DAOUSUARIO(conn);
        usuario = dao.obtenerUsuarioPorId(userId);

        RolDAO rolDao = new RolDAO(conn);
        roles = rolDao.obtenerTodos();

        String error = request.getParameter("error");
        String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Editar Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../../Administracion/Usuarios/css/styless.css">
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

                    <a href="../../Registro/FormRegistro.html">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>Cliente Nuevo</span>
                    </a>

                </li>      
                <li>

                    <a href="../../Administracion/Clientes/ConsultarCliente.jsp">
                        <i class="fa-solid fa-users"></i>
                        <span>Gestión Clientes</span>
                    </a>

                </li>
                <li>

                    <a href="../../Administracion/Usuarios/ConsultarUsuario.jsp">
                        <i class="fa-solid fa-users-gear"></i>
                        <span>Gestion Usuarios</span>
                    </a>

                </li>
            </ul>
        </div>

        <div class="main--content">
            <div class="header--wrapper">
                <div class="header--title">
                    <img src="../../Administracion/Clientes/imag.png" alt="Imagen de Registro" style="width: 100%; max-width: 100%; height: auto;">
                </div>
            </div>


            <div class="form-container">
                <% if (error != null) {%>
                <div class="alert alert-danger"><%= error%></div>
                <% } %>

                <% if (success != null) {%>
                <div class="alert alert-success"><%= success%></div>
                <% }%>

                <h1>Editar Usuario</h1>

                <form action="../../Administracion/Usuarios/ActualizarUsuario.jsp" method="post" onsubmit="return validarFormulario()">
                    <input type="hidden" name="id" value="<%= usuario.getId()%>">

                    <div class="mb-3">
                        <label class="form-label">Nombre de usuario:</label>
                        <input type="text" class="form-control" name="username" value="<%= usuario.getUsuario()%>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rol:</label>
                        <select class="form-select" name="rol_id" required>
                            <% for (Rol rol : roles) {%>
                            <option value="<%= rol.getId()%>" <%= usuario.getRol().getId() == rol.getId() ? "selected" : ""%>>
                                <%= rol.getNombre()%>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nueva contraseña:</label>
                        <div class="position-relative">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Dejar vacío para mantener la actual">
                            <i class="fa fa-eye password-toggle" onclick="togglePassword()"></i>

                            <small class="text-muted">Mínimo 8 caracteres, incluir mayúsculas, minúsculas y números</small>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Confirmar contraseña:</label>
                        <input type="password" class="form-control" id="confirmPassword" placeholder="Repite la nueva contraseña">
                    </div>

                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                    <a href="../../Administracion/Usuarios/ConsultarUsuario.jsp" class="btn btn-secondary">Cancelar</a>
                </form>
            </div>
        </div>

        <script>
            function togglePassword() {
                const passwordField = document.getElementById('password');
                const icon = document.querySelector('.password-toggle');

                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordField.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }

            function validarFormulario() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                // Si se ingresó contraseña, validar
                if (password !== '') {
                    // Validar longitud mínima
                    if (password.length < 8) {
                        alert('La contraseña debe tener al menos 8 caracteres');
                        return false;
                    }

                    // Validar coincidencia
                    if (password !== confirmPassword) {
                        alert('Las contraseñas no coinciden');
                        return false;
                    }

                    // Validar complejidad
                    const hasUpperCase = /[A-Z]/.test(password);
                    const hasLowerCase = /[a-z]/.test(password);
                    const hasNumbers = /\d/.test(password);

                    if (!hasUpperCase || !hasLowerCase || !hasNumbers) {
                        alert('La contraseña debe contener mayúsculas, minúsculas y números');
                        return false;
                    }
                }

                return true;
            }
        </script>

    </body>
</html>

<%
    } catch (Exception e) {
        response.sendRedirect("/Formulario/Administracion/Usuarios/ConsultarUsuario.jsp?error=Error al cargar usuario: " + e.getMessage());
    } finally {
        if (conn != null) {
            conn.close();
        }
    }
%>
