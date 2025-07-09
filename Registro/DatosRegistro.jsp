<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@ page import="Logica.Valida_Formulario, Logica.Beneficios" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Gestion.Persona, Conexion.ConexionBD, Conexion.ClienteDAO" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    List<String> permisos = (List<String>) session.getAttribute("permisos");
        if (permisos == null) {
        permisos = new ArrayList<>();
    }

    if (usuario == null || rol == null || permisos == null) {
        response.sendRedirect("/Formulario/Login/login.jsp");
        return;
    }
    
        if (rol != null) {
        rol = rol.trim().toLowerCase();
    }
    
%>

<%
    // Captura de datos del formulario
    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");
    String sexo = request.getParameter("sexo");
    String tdocumento = request.getParameter("tdocumento");
    String documento = request.getParameter("documento");
    String Lnacimiento = request.getParameter("Lnacimiento");
    String pais = request.getParameter("pais");
    String RH = request.getParameter("RH");
    String fnacimiento = request.getParameter("fnacimiento");

    double altura = 0;
    double peso = 0;
    double promedio = 0;

        if (request.getParameter("Altura") != null && !request.getParameter("Altura").isEmpty()) {
            altura = Double.parseDouble(request.getParameter("Altura"));
        }
        if (request.getParameter("Peso") != null && !request.getParameter("Peso").isEmpty()) {
            peso = Double.parseDouble(request.getParameter("Peso"));
        }
        if (request.getParameter("Promedio") != null && !request.getParameter("Promedio").isEmpty()) {
            promedio = Double.parseDouble(request.getParameter("Promedio"));
        }

// Calcular automáticamente el peso ideal
    Valida_Formulario validador = new Valida_Formulario();
    double pesoIdeal = validador.calcularPesoIdeal(altura);

    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String ciudad = request.getParameter("ciudad");
    String email = request.getParameter("email");
    
    String club = request.getParameter("club");
    String deporte = request.getParameter("deporte");
    String categoria = request.getParameter("categoria");
    
    String P_nombres = request.getParameter("P_nombres");
    String P_apellidos = request.getParameter("P_apellidos");
    String parentesco = request.getParameter("parentesco");
    String ocupación = request.getParameter("ocupación");
    String telefono_1 = request.getParameter("telefono_1");
    String email_1 = request.getParameter("email_1");
    
    String A_nombres = request.getParameter("A_nombres");
    String A_apellidos = request.getParameter("A_apellidos");
    String telefono_2 = request.getParameter("telefono_2");
    
    String plan = request.getParameter("Plan");
    int meses = Integer.parseInt(request.getParameter("duracion"));
    boolean aceptaPoliticas = request.getParameter("politicas") != null;
    String metodoPago = request.getParameter("mPago");

    // Instanciar clases
    
    Beneficios beneficios = new Beneficios(plan, peso, altura, meses);

    // Validaciones
    int edad = validador.calcularEdad(fnacimiento);
    boolean edadValida = validador.validarEdad(edad);
    boolean emailValido = validador.validarCorreo(email);
    String mensajeIMC = validador.validarPesoAltura(peso, altura);

   

    // Beneficios
    int disciplinas = beneficios.cuantasDisciplinasPuedeAcceder();
    String accesoSedes = beneficios.accesoSedes();
    boolean entrenamientos = beneficios.accesoEntrenamientosPersonalizados();

    // Calcular precio base según plan y duración original
    int mesesOriginal = meses;
    double precioBase = 0;

    if (plan.equalsIgnoreCase("Premium")) {
        switch (mesesOriginal) {
            case 1: precioBase = 50; break;
            case 3: precioBase = 140; break;
            case 6: precioBase = 270; break;
            case 12: precioBase = 500; break;
        }
    } else if (plan.equalsIgnoreCase("Deluxe")) {
        switch (mesesOriginal) {
            case 1: precioBase = 80; break;
            case 3: precioBase = 220; break;
            case 6: precioBase = 420; break;
            case 12: precioBase = 750; break;
        }
    }

    // Aplicar promociones y descuentos desde Beneficios
    int mesesConPromociones = beneficios.aplicarPromocionPorDuracion(plan, mesesOriginal);
    boolean recibeKit = beneficios.recibeKitEntrenamiento(plan, mesesConPromociones);
    double precioFinal = beneficios.aplicarDescuentoPorPago(metodoPago, precioBase);

    // Crear objeto Persona
    Persona c = new Persona(nombres, apellidos, sexo, tdocumento, documento,
            Lnacimiento, pais, RH, fnacimiento, edad, altura, peso,
            promedio, pesoIdeal, direccion, telefono, ciudad, email, club, deporte, categoria,
            P_nombres, P_apellidos, parentesco, ocupación, telefono_1, email_1, A_nombres, A_apellidos,
            telefono_2, plan, meses, mesesConPromociones, accesoSedes, precioBase, metodoPago, precioFinal
    );
    

%>

    
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/styleR.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        
        <title>Registro</title>

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
                    <a href="../Administracion/Usuarios/ConsultarUsuario.jsp">
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
                    <img src="css/imag.png" alt="Imagen de Registro" style="width: 100%; max-width: 100%; height: auto;">

                </div>
            </div>

        <div class="form">
            
            <h1>Registro Deportivo</h1><br>
            
            <h1>Resumen de Registro de <%= request.getParameter("nombres") %> <%= request.getParameter("apellidos") %></h1><br>

        <button class="accordion-header">Información Personal</button>
        <div class="accordion-content">

            <table>
                <tr><th>Nombres:</th><td> <%= request.getParameter("nombres") %></td></tr>
                <tr><th>Apellidos:</th><td> <%= request.getParameter("apellidos") %></td></tr>
                <tr><th>Sexo:</th><td> <%= request.getParameter("sexo") %></td></tr>
                <tr><th>Tipo de Documento:</th><td> <%= request.getParameter("tdocumento") %></td></tr>
                <tr><th>Nº documento:</th><td> <%= request.getParameter("documento") %></td></tr>
                <tr><th>Lugar de nacimiento:</th><td> <%= request.getParameter("Lnacimiento") %></td></tr>
                <tr><th>País:</th><td> <%= request.getParameter("pais") %></td></tr>
                <tr><th>Grupo Sanguíneo:</th><td> <%= request.getParameter("RH") %></td></tr>
                <tr><th>Fecha de Nacimiento:</th><td> <%= request.getParameter("fnacimiento") %></td></tr>
                <tr><th>Edad:</th><td> <%= request.getParameter("edad") %></td></tr>
                <tr><th>Altura (m):</th><td> <%= request.getParameter("Altura") %></td></tr>
                <tr><th>Peso (kg):</th><td> <%= request.getParameter("Peso") %></td></tr>
                <tr><th>Promedio:</th><td> <%= request.getParameter("Promedio") %></td></tr>
                <tr><th>Peso Ideal:</th><td><%= String.format("%.2f", pesoIdeal) %> kg</td></tr>
            </table>
        </div>

        <button class="accordion-header">Información de Contacto</button>
        <div class="accordion-content">

            <table>
                <tr><th>Dirección:</th><td> <%= request.getParameter("direccion") %></td></tr>
                <tr><th>Teléfono:</th><td> <%= request.getParameter("telefono") %></td></tr>
                <tr><th>Ciudad:</th><td> <%= request.getParameter("ciudad") %></td></tr>
                <tr><th>Correo Electrónico:</th><td> <%= request.getParameter("email") %></td></tr>
            </table>
        </div>

        <button class="accordion-header">Información Deportiva</button>
        <div class="accordion-content">

            <table>
                <tr><th>Nombre del Club/Academia:</th><td> <%= request.getParameter("club") %></td></tr>
                <tr><th>Disciplina o Deporte:</th><td> <%= request.getParameter("deporte") %></td></tr>
                <tr><th>Categoria:</th><td> <%= request.getParameter("categoria") %></td></tr>
            </table>
        </div>

        <button class="accordion-header">Contacto de Emergencia</button>
        <div class="accordion-content">

            <table>
                <tr><th>Nombres:</th><td> <%= request.getParameter("P_nombres") %></td></tr>
                <tr><th>Apellidos:</th><td> <%= request.getParameter("P_apellidos") %></td></tr>
                <tr><th>Parentesco:</th><td> <%= request.getParameter("parentesco") %></td></tr>
                <tr><th>Ocupación:</th><td> <%= request.getParameter("ocupación") %></td></tr>
                <tr><th>Teléfono:</th><td> <%= request.getParameter("telefono_1") %></td></tr>
                <tr><th>Correo Electronico:</th><td> <%= request.getParameter("email_1") %></td></tr>
            </table>

                <h3>Segunda Persona de Contacto</h3>

                <table>
                    <tr><th>Nombres:</th><td> <%= request.getParameter("A_nombres") %></td></tr>
                    <tr><th>Apellidos:</th><td> <%= request.getParameter("A_apellidos") %></td></tr>
                    <tr><th>Teléfono:</th><td> <%= request.getParameter("telefono_2") %></td></tr>
                </table>
        </div>

        <button class="accordion-header">Planes y Pagos</button>
        <div class="accordion-content">

            <table>
                <tr><th>Tipos de Planes:</th><td> <%= request.getParameter("Plan") %></td></tr>
                <tr><th>Meses Adquiridos:</th><td> <%= request.getParameter("duracion") %></td></tr>
                <tr><th>Meses Adquiridos con Promoción:</th><td><%= mesesConPromociones %></td></tr>
                <tr><th>Tiene acceso a:</th><td> <%= accesoSedes %></td></tr>
                <tr><th>Estado de Peso:</th><td> <%= mensajeIMC %></td></tr>
                </table>
                
                <h3>Totales</h3>
                
                <table>
                <tr><th>Precio Total:</th><td> <%= precioBase %> USD</td></tr>
                <tr><th>Realiza el pago con:</th><td> <%= request.getParameter("mPago") %></td></tr>
                <tr><th>Precio Final con Descuentos:</th><td> <%= precioFinal %> USD</td></tr>
            </table>
        </div>    

        <%
            Connection conn = null;
            try {
                conn = Conexion.ConexionBD.conectar(); // Aquí llamas a tu método correcto
                if (conn == null) {
                    out.println("<p style='color:red;'>No se pudo conectar a la base de datos.</p>");
                } else {
                    ClienteDAO dao = new ClienteDAO(conn);
                    boolean exito = dao.registrarCliente(c);
                    if (exito) {
                        out.println("<p style='color:green;'>Registro exitoso</p>");
                    } else {
                        out.println("<p style='color:red;'>Ocurrió un error al registrar</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error inesperado: " + e.getMessage() + "</p>");
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        // Aquí podrías loguear el error de cierre
                    }
                }
            }
        %>

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