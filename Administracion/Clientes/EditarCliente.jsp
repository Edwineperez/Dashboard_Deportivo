<%@ page import="Gestion.Persona, Conexion.ClienteDAO, java.util.*, java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="java.sql.Connection" %>

<%
    String documento = request.getParameter("documento");
    List<String> permisos = (List<String>) session.getAttribute("permisos");

    if (documento == null || documento.isEmpty()) {
        response.sendRedirect("ConsultarCliente.jsp");
        return;
    }

    if (permisos == null || !permisos.contains("actualizar_clientes")) {
        out.println("<p style='color:red;'>No tienes permiso para editar clientes.</p>");
        return;
    }

    Connection conn = ConexionBD.conectar();
    ClienteDAO dao = new ClienteDAO(conn);   

    Persona persona = dao.editarCliente(documento);

    if (persona == null) {
        out.println("<p style='color:red;'>Cliente no encontrado.</p>");
        return;
    }
    
    // Calcular datos adicionales
    double pesoIdeal = 22 * (persona.getAltura() * persona.getAltura());
    String mensajeIMC = "";
    if (persona.getPeso() > 0 && persona.getAltura() > 0) {
        double imc = persona.getPeso() / (persona.getAltura() * persona.getAltura());
        if (imc < 18.5) {
            mensajeIMC = "Bajo peso";
        } else if (imc < 25) {
            mensajeIMC = "Peso normal";
        } else if (imc < 30) {
            mensajeIMC = "Sobrepeso";
        } else {
            mensajeIMC = "Obesidad";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Cliente</title>
        <link href="../../Administracion/Clientes/styless.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    </head>
    <body>

        <div class="sidebar">
            <div class="logo"></div>
            <ul class="menu">
                <li class="active">
                    <a href="../Dashboard/Panel.jsp">
                        <i class="fa-solid fa-house"></i>
                        <span>Inicio</span>
                    </a>
                </li>
                <li>
                    <% if (permisos.contains("crear_clientes")) { %>
                    <a href="../Registro/FormRegistro.html">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>Cliente Nuevo</span>
                    </a>
                    <% } %>
                </li>      
                <li>
                    <% if (permisos.contains("ver_clientes")) { %>
                    <a href="../Administracion/Clientes/ConsultarCliente.jsp">
                        <i class="fa-solid fa-users"></i>
                        <span>Gestión Clientes</span>
                    </a>
                    <% } %>
                </li>
                <li>
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
                    <img src="../../Administracion/Clientes/imag.png" alt="Imagen de Registro" style="width: 100%; max-width: 100%; height: auto;">
                </div>
            </div>

            <div class="form-container">
                <h1>Editar Cliente</h1><br>
                <h2>Datos de <%= persona.getNombres() %> <%= persona.getApellidos() %></h2><br>

                <form name="form" action="ActualizarCliente.jsp" method="POST" class="formRegistro">

                    <!-- INFORMACIÓN PERSONAL -->
                    <button type="button" class="accordion-header">Información Personal</button>
                    <div class="accordion-content">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="nombres">Nombres</label>
                                <input type="text" id="nombres" name="nombres" value="<%= persona.getNombres() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="apellidos">Apellidos</label>
                                <input type="text" id="apellidos" name="apellidos" value="<%= persona.getApellidos() %>" required>
                            </div>
                        </div>

                                <label>Sexo:</label><br><br>
                                <label><input type="radio" name="sexo" value="Masculino" <%= "Masculino".equals(persona.getSexo()) ? "checked" : "" %> required> Masculino</label><br>
                                <label><input type="radio" name="sexo" value="Femenino" <%= "Femenino".equals(persona.getSexo()) ? "checked" : "" %>> Femenino</label><br><br>


                        <div class="form-row">
                            <div class="form-group">
                                <label for="tdocumento">Tipo Documento</label>
                                <select id="tdocumento" name="tdocumento" required>
                                    <option disabled value="">Seleccione</option>
                                    <option value="Cedula Ciudadana" <%= "Cedula Ciudadana".equals(persona.getTdocumento()) ? "selected" : "" %>>Cédula Ciudadana</option>
                                    <option value="Tarjeta Identidad" <%= "Tarjeta Identidad".equals(persona.getTdocumento()) ? "selected" : "" %>>Tarjeta Identidad</option>
                                    <option value="Pasaporte" <%= "Pasaporte".equals(persona.getTdocumento()) ? "selected" : "" %>>Pasaporte</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="documento">Nº Documento</label>
                                <input type="text" id="documento" name="documento" value="<%= persona.getDocumento() %>" required readonly>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="Lnacimiento">Lugar de Nacimiento</label>
                                <input type="text" id="Lnacimiento" name="Lnacimiento" value="<%= persona.getLnacimiento() %>">
                            </div>
                            <div class="form-group">
                                <label for="pais">País</label>
                                <input type="text" id="pais" name="pais" value="<%= persona.getPais() %>" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="RH">Grupo Sanguíneo</label>
                                <input type="text" id="RH" name="RH" value="<%= persona.getRH() %>">
                            </div>
                            <div class="form-group">
                                <label for="fnacimiento">Fecha de Nacimiento</label>
                                <input type="date" id="fnacimiento" name="fnacimiento" value="<%= persona.getFnacimiento() %>" required oninput="calcularEdad()">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="edad">Edad</label>
                                <input type="number" id="edad" name="edad" value="<%= persona.getEdad() %>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="Altura">Altura (m)</label>  
                                <input type="number" id="Altura" name="Altura" step="0.01" value="<%= persona.getAltura() %>" required oninput="calcularDatos()">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="Peso">Peso (kg)</label>
                                <input type="number" id="Peso" name="Peso" step="0.1" value="<%= persona.getPeso() %>" required oninput="calcularDatos()">
                            </div>
                            <div class="form-group">
                                <label for="Promedio">Promedio</label>
                                <input type="text" id="Promedio" name="Promedio" value="<%= persona.getPromedio() %>" readonly>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="PesoIdeal">Peso Ideal</label>
                                <input type="text" id="PesoIdeal" name="PesoIdeal" value="<%= String.format("%.2f", pesoIdeal) %>" readonly>
                            </div>
                            <div class="form-group">
                                <label>Estado IMC:</label>
                                <input type="text" value="<%= mensajeIMC %>" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- DATOS DE CONTACTO -->
                    <button type="button" class="accordion-header">Información de Contacto</button>
                    <div class="accordion-content">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="direccion">Dirección</label>
                                <input type="text" id="direccion" name="direccion" value="<%= persona.getDireccion() %>">
                            </div>
                            <div class="form-group">
                                <label for="telefono">Teléfono</label>
                                <input type="tel" id="telefono" name="telefono" pattern="[0-9]{10}" placeholder="10 dígitos" value="<%= persona.getTelefono() %>" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="ciudad">Ciudad</label>
                                <input type="text" id="ciudad" name="ciudad" value="<%= persona.getCiudad() %>">
                            </div>
                            <div class="form-group">
                                <label for="email">Correo Electrónico</label>
                                <input type="email" id="email" name="email" value="<%= persona.getEmail() %>">
                            </div>
                        </div>
                    </div>

                    <!-- INFORMACIÓN DEPORTIVA -->
                    <button type="button" class="accordion-header">Información Deportiva</button>
                    <div class="accordion-content">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="club">Nombre del Club/Academia</label>
                                <input type="text" id="club" name="club" value="<%= persona.getClub() %>">
                            </div>
                            <div class="form-group">
                                <label for="deporte">Disciplina o Deporte</label>
                                <select id="deporte" name="deporte" required>
                                    <option disabled value="">Seleccione</option>
                                    <option value="Fútbol" <%= "Fútbol".equals(persona.getDeporte()) ? "selected" : "" %>>Fútbol</option>
                                    <option value="Rugby" <%= "Rugby".equals(persona.getDeporte()) ? "selected" : "" %>>Rugby</option>    
                                    <option value="Natación" <%= "Natación".equals(persona.getDeporte()) ? "selected" : "" %>>Natación</option>
                                    <option value="Voleibol" <%= "Voleibol".equals(persona.getDeporte()) ? "selected" : "" %>>Voleibol</option>
                                    <option value="Baloncesto" <%= "Baloncesto".equals(persona.getDeporte()) ? "selected" : "" %>>Baloncesto</option>
                                    <option value="Karate" <%= "Karate".equals(persona.getDeporte()) ? "selected" : "" %>>Karate</option>
                                    <option value="Tenis" <%= "Tenis".equals(persona.getDeporte()) ? "selected" : "" %>>Tenis</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="categoria">Categoría</label>
                                <select id="categoria" name="categoria" required>
                                    <option disabled value="">Seleccione</option>
                                    <option value="SUB-BABY" <%= "SUB-BABY".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-BABY</option>
                                    <option value="SUB-10" <%= "SUB-10".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-10</option>
                                    <option value="SUB-15" <%= "SUB-15".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-15</option>
                                    <option value="SUB-18" <%= "SUB-18".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-18</option>
                                    <option value="SUB-20" <%= "SUB-20".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-20</option>
                                    <option value="SUB-VETERANOS" <%= "SUB-VETERANOS".equals(persona.getCategoria()) ? "selected" : "" %>>SUB-VETERANOS</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- CONTACTO DE EMERGENCIA -->
                    <button type="button" class="accordion-header">Contacto de Emergencia</button>
                    <div class="accordion-content">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="P_nombres">Nombres</label>
                                <input type="text" id="P_nombres" name="P_nombres" value="<%= persona.getP_nombres() %>">
                            </div>
                            <div class="form-group">
                                <label for="P_apellidos">Apellidos</label>
                                <input type="text" id="P_apellidos" name="P_apellidos" value="<%= persona.getP_apellidos() %>">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="parentesco">Parentesco</label>
                                <input type="text" id="parentesco" name="parentesco" value="<%= persona.getParentesco() %>">
                            </div>
                            <div class="form-group">
                                <label for="ocupacion">Ocupación</label>
                                <input type="text" id="ocupacion" name="ocupacion" value="<%= persona.getOcupacion() %>">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="telefono_1">Teléfono</label>
                                <input type="tel" id="telefono_1" name="telefono_1" value="<%= persona.getTelefono_1() %>" pattern="[0-9]{10}" placeholder="10 dígitos" required>
                            </div>
                            <div class="form-group">
                                <label for="email_1">Correo Electrónico</label>
                                <input type="email" id="email_1" name="email_1" value="<%= persona.getEmail_1() %>">
                            </div>
                        </div>

                        <h3>Segunda Persona de Contacto</h3>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="A_nombres">Nombres</label>
                                <input type="text" id="A_nombres" name="A_nombres" value="<%= persona.getA_nombres() %>">
                            </div>
                            <div class="form-group">
                                <label for="A_apellidos">Apellidos</label>
                                <input type="text" id="A_apellidos" name="A_apellidos" value="<%= persona.getA_apellidos() %>">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="telefono_2">Teléfono</label>
                                <input type="tel" id="telefono_2" name="telefono_2" value="<%= persona.getTelefono_2() %>" pattern="[0-9]{10}" placeholder="10 dígitos" required>
                            </div>
                        </div>
                    </div>

                    <!-- PLANES Y PAGOS -->
                    <button type="button" class="accordion-header">Planes y Pagos</button>
                    <div class="accordion-content">
                        <div class="form-group">
                            <label for="Plan">Tipos de Planes</label>
                            <select id="Plan" name="Plan" required>
                                <option disabled value="">Seleccione</option>
                                <option value="Premium" <%= "Premium".equals(persona.getPlan()) ? "selected" : "" %>>Plan Premium</option>
                                <option value="Deluxe" <%= "Deluxe".equals(persona.getPlan()) ? "selected" : "" %>>Plan Deluxe</option>
                            </select>
                        </div>

                        <div class="duracion-container">
                            <label>Duración:</label>
                            <label><input type="radio" name="duracion" value="1" <%= persona.getDuracion() == 1 ? "checked" : "" %> required> 1 Mes</label>
                            <label><input type="radio" name="duracion" value="3" <%= persona.getDuracion() == 3 ? "checked" : "" %>> 3 Meses</label>
                            <label><input type="radio" name="duracion" value="6" <%= persona.getDuracion() == 6 ? "checked" : "" %>> 6 Meses</label>
                            <label><input type="radio" name="duracion" value="12" <%= persona.getDuracion() == 12 ? "checked" : "" %>> 12 Meses</label>
                        </div>

                        <div class="duracion-container">
                            <label>Método de Pago:</label>
                            <label><input type="radio" name="mPago" value="Efectivo" <%= "Efectivo".equals(persona.getmPago()) ? "checked" : "" %> required> Efectivo</label>
                            <label><input type="radio" name="mPago" value="Tarjeta" <%= "Tarjeta".equals(persona.getmPago()) ? "checked" : "" %>> Tarjeta</label>
                            <label><input type="radio" name="mPago" value="Transferencia/PSE" <%= "Transferencia/PSE".equals(persona.getmPago()) ? "checked" : "" %>> Transferencia/PSE</label>
                        </div>

                        <input type="hidden" name="mesesConPromociones" value="<%= persona.getMesesConPromociones() %>">
                        <input type="hidden" name="accesoSedes" value="<%= persona.getAccesoSedes() != null ? persona.getAccesoSedes() : "" %>">
                        <input type="hidden" name="precioBase" value="<%= persona.getPrecioBase() %>">
                        <input type="hidden" name="precioFinal" value="<%= persona.getPrecioFinal() %>">
                    </div>

                    <div class="boton-centrado">
                        <button type="submit" class="btn-submit">Guardar Cambios</button>
                        <button type="button" class="btn-cancel" onclick="history.back()">Cancelar</button>
                    </div>
                </form>
            </div>
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

            // Cálculo de edad
            function calcularEdad() {
                const fechaNacimiento = document.getElementById("fnacimiento").value;
                const edadInput = document.getElementById("edad");
                
                if (fechaNacimiento) {
                    const fechaNac = new Date(fechaNacimiento);
                    const hoy = new Date();
                    let edad = hoy.getFullYear() - fechaNac.getFullYear();
                    const mes = hoy.getMonth() - fechaNac.getMonth();
                    const dia = hoy.getDate() - fechaNac.getDate();
                    
                    if (mes < 0 || (mes === 0 && dia < 0)) {
                        edad--;
                    }
                    
                    edadInput.value = edad;
                } else {
                    edadInput.value = "";
                }
            }

            // Cálculo de datos físicos
            function calcularDatos() {
                const altura = parseFloat(document.getElementById("Altura").value);
                const peso = parseFloat(document.getElementById("Peso").value);
                
                if (!isNaN(altura) && !isNaN(peso)) {
                    const promedio = (altura + peso) / 2;
                    document.getElementById("Promedio").value = promedio.toFixed(2);
                    
                    const pesoIdeal = 22 * (altura * altura);
                    document.getElementById("PesoIdeal").value = pesoIdeal.toFixed(2) + " kg";
                } else {
                    document.getElementById("Promedio").value = "";
                    document.getElementById("PesoIdeal").value = "";
                }
            }

            // Validación del formulario antes de enviar
            document.querySelector("form").addEventListener("submit", function(e) {
                const email = document.getElementById("email").value;
                if (email && !email.includes("@")) {
                    alert("Correo electrónico no válido.");
                    e.preventDefault();
                    return;
                }
                
                const requiredFields = document.querySelectorAll("[required]");
                let isValid = true;
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.style.border = "1px solid red";
                        isValid = false;
                    } else {
                        field.style.border = "";
                    }
                });
                
                if (!isValid) {
                    alert("Por favor complete todos los campos requeridos.");
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>


