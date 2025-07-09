<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="Gestion.Rol"%>
<%@page import="java.math.BigDecimal"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Conexion.ConexionBD, Conexion.DAOUSUARIO, Gestion.Usuario" %>
<%@ page import="java.sql.Connection" %>

<%
    String mensaje = "";
    boolean exito = false;

    Connection conn = null;
    try {
        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            String usuario = request.getParameter("username");
            String password = request.getParameter("password");
            int rolId = Integer.parseInt(request.getParameter("rol_id"));

            // Validaciones básicas
            if (usuario == null || usuario.trim().isEmpty()) {
                throw new Exception("El nombre de usuario es requerido");
            }
            if (password == null || password.trim().isEmpty()) {
                throw new Exception("La contraseña es requerida");
            }

            String passwordSegura = BCrypt.hashpw(password, BCrypt.gensalt());
            Usuario nuevo = new Usuario();
            nuevo.setUsuario(usuario);
            nuevo.setPassword(passwordSegura);
            nuevo.setRol(new Rol(rolId, ""));

            conn = ConexionBD.conectar();
            DAOUSUARIO dao = new DAOUSUARIO(conn);
            exito = dao.crearUsuario(nuevo);
            mensaje = exito ? "Usuario registrado con éxito." : "Error al registrar usuario.";
        }
    } catch (SQLException e) {
        mensaje = "Error de base de datos: " + e.getMessage();
    } catch (NumberFormatException e) {
        mensaje = "El rol seleccionado no es válido";
    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
    
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../../Administracion/Usuarios/css/styleR.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        
        <title>Registro</title>

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
                    <img src="../../Administracion/Usuarios/css/imag.png" alt="Imagen de Registro" style="width: 100%; max-width: 100%; height: auto;">

                </div>
            </div>

        <div class="form">
            
            <h1>Registro de Usuario</h1><br>
            
            <%
                String usuarioResumen = request.getParameter("username");
                String rolResumen = request.getParameter("rol_id");
            %>

            <h2>Resumen de Registro</h2><br>

            <button class="accordion-header">Datos de Usuario</button>
            <div class="accordion-content">
                <table>
                    <tr><th>Nombre de Usuario</th><td><%= usuarioResumen%></td></tr>
                    <tr><th>Rol</th><td><%= "1".equals(rolResumen) ? "Administrador" : "Empleado"%></td></tr>
                </table>
            </div><br><br>

                    <div class="message-container <%= exito ? "success" : "error"%>">
                        <%= mensaje%>
                    </div>
        </div>
        
        </div>

        <script>
    
                document.addEventListener('DOMContentLoaded', function () {
            const headers = document.querySelectorAll(".accordion-header");

            headers.forEach(header => {
                header.addEventListener("click", function () {
                    const content = this.nextElementSibling;
                    document.querySelectorAll(".accordion-content").forEach(panel => {
                        if (panel !== content) panel.style.display = "none";
                    });
                    content.style.display = content.style.display === "block" ? "none" : "block";
                });
            });
        });
        
        
        </script>

    </body>
</html>