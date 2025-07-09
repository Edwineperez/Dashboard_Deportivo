<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Gestion.Usuario" %>
<%@ page import="Conexion.DAOUSUARIO" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Usuario</title>
        <link href="../../Administracion/Usuarios/css/styleU.css" rel="stylesheet" type="text/css" />
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
                    <img src="css/imag.png" alt="Imagen de Registro" style="width: 100%; max-width: 100%; height: auto;">

                </div>
            </div>

            <div class="form-container">

                <h1>Formulario de Registro</h1><br>

                <form name="form" action="../../Administracion/Usuarios/RegistroUsuario.jsp" method="POST" class="formRegistro">
                    <input type="hidden" name="accion" value="crear">
                
                                <!-- DATOS DE USUARIO -->

                                <button type="button" class="accordion-header">Datos de Usuario</button>
                                <div class="accordion-content">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="Usuario">Usuario</label>
                                            <input type="text" id="username" name="username" required><br>
                                        </div>
                                        <div class="form-group">
                                            <label for="clave">Contraseña</label>
                                            <input type="password" id="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}"
                                                   title="Debe tener al menos 8 caracteres, incluyendo una mayúscula, una minúscula, un número y un carácter especial." required>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="Rol">Rol</label>
                                            <select name="rol_id" required>
                                                <option disabled selected value="">Seleccione</option>
                                                <option value="1">Administrador</option>
                                                <option value="2">Empleado</option>
                                            </select>

                                        </div>

                                    </div>
                                </div>
                                <div class="boton-centrado">
                                    <button type="submit">Registrar</button>
                                </div>

                </form>

            </div>
                                <script>

                document.addEventListener('DOMContentLoaded', function () {
                    const headers = document.querySelectorAll(".accordion-header");

                    headers.forEach(header => {
                        header.addEventListener("click", function () {
                            const content = this.nextElementSibling;
                            document.querySelectorAll(".accordion-content").forEach(panel => {
                                if (panel !== content)
                                    panel.style.display = "none";
                            });
                            content.style.display = content.style.display === "block" ? "none" : "block";
                        });
                    });
                });

                function calcularEdad() {
                    let fechaNacimiento = document.getElementById("fnacimiento").value;
                    let edadInput = document.getElementById("edad");

                    if (fechaNacimiento) {
                        let fechaNac = new Date(fechaNacimiento);
                        let hoy = new Date();
                        let edad = hoy.getFullYear() - fechaNac.getFullYear();
                        let mes = hoy.getMonth() - fechaNac.getMonth();
                        let dia = hoy.getDate() - fechaNac.getDate();

                        // Si no ha cumplido años en el mes actual, resta 1 a la edad
                        if (mes < 0 || (mes === 0 && dia < 0)) {
                            edad--;
                        }

                        edadInput.value = edad;
                    } else {
                        edadInput.value = "";
                    }
                }
                
    </script>
                    
    </body>
</html>

                  

