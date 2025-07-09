<%@page import="Conexion.DAOUSUARIO"%>
<%@page import="Conexion.ConexionBD"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@page import="Gestion.Usuario, Gestion.Permiso, Gestion.Rol"%>
<%@ page import="java.sql.Connection" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    List<String> permisos = (List<String>) session.getAttribute("permisos");
    if (permisos == null) {
        permisos = new ArrayList<>();
    }

    if (usuario == null || rol == null || permisos == null) {
        response.sendRedirect("/Formulario/Login/Login.jsp");
        return;
    }

    if (rol != null) {
        rol = rol.trim().toLowerCase();
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <title>SportPlus</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style_Dash.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <style>
            .metrics-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .metric-card {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border-left: 4px solid #715fba;
            }

            .metric-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0,0,0,0.12);
            }

            .metric-title {
                font-size: 16px;
                color: #555;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .metric-value {
                font-size: 28px;
                font-weight: 700;
                color: #333;
                margin-bottom: 5px;
            }

            .metric-change {
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .positive {
                color: #4CAF50;
            }

            .negative {
                color: #F44336;
            }

            .promo-highlight {
                background: linear-gradient(135deg, #715fba, #9c88ff);
                color: white;
                padding: 25px;
                border-radius: 12px;
                margin-bottom: 30px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .promo-highlight h3 {
                margin-bottom: 15px;
                font-size: 22px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .promo-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
            }

            .promo-card {
                background: rgba(255,255,255,0.15);
                backdrop-filter: blur(5px);
                border-radius: 10px;
                padding: 20px;
                transition: transform 0.3s ease;
            }

            .promo-card:hover {
                transform: translateY(-5px);
            }

            .promo-card h4 {
                margin-bottom: 10px;
                font-size: 18px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .promo-card p {
                margin: 0;
                font-size: 14px;
                line-height: 1.5;
            }

            .client-activity {
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }

            .client-activity h2 {
                margin-bottom: 20px;
                color: #333;
                font-size: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .client-stats {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 20px;
            }

            .client-stat {
                flex: 1;
                min-width: 200px;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: #715fba;
                margin-bottom: 5px;
            }

            .stat-label {
                font-size: 14px;
                color: #666;
            }

        </style>
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
                <li class="logout">
                    <a href="../Login/Logout.jsp">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Salir</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main--content">
            <div class="header--wrapper">
                <div class="header--title">
                    <h1><i class="fas fa-dumbbell"></i> Panel Administrativo - SportPlus</h1>
                    <h1>Bienvenido, <%= usuario%></h1>
                </div>
                <div class="user--info">
                    <p class="mb-0">Último acceso: <%= new java.util.Date()%></p>
                    <img src="Perfil.jpeg" alt=""/>
                </div>
            </div>

            <div class="container-dat">

                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-title">
                            <i class="fas fa-users"></i> Clientes Activos
                        </div>
                        <div class="metric-value">248</div>
                        <div class="metric-change positive">
                            <i class="fas fa-arrow-up"></i> 15 este mes
                        </div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-title">
                            <i class="fas fa-user-plus"></i> Nuevos Registros
                        </div>
                        <div class="metric-value" id="nuevosRegistros">20</div>
                        <div class="metric-change positive">
                            <i class="fas fa-arrow-up"></i> 5% vs mes anterior
                        </div>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-title">
                        <i class="fas fa-calendar-check"></i> Renovaciones
                    </div>
                    <div class="metric-value">78%</div>
                    <div class="metric-change negative">
                        <i class="fas fa-arrow-down"></i> 2% vs mes anterior
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-title">
                        <i class="fas fa-dumbbell"></i> Clases Hoy
                    </div>
                    <div class="metric-value">14</div>
                    <div class="metric-change">
                        <i class="fas fa-users"></i> 78% capacidad
                    </div>
                </div>

                <!-- Actividad de clientes -->
                <div class="client-activity">
                    <h2><i class="fas fa-chart-line"></i> Estadísticas de Clientes</h2>
                    <div class="client-stats">
                        <div class="client-stat">
                            <div class="stat-value">248</div>
                            <div class="stat-label">Clientes Activos</div>
                        </div>

                        <div class="client-stat">
                            <div class="stat-value">32</div>
                            <div class="stat-label">Nuevos este mes</div>
                        </div>

                        <div class="client-stat">
                            <div class="stat-value">78%</div>
                            <div class="stat-label">Tasa de renovación</div>
                        </div>

                        <div class="client-stat">
                            <div class="stat-value">14</div>
                            <div class="stat-label">Clases hoy</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Promociones destacadas -->
            <div class="promo-highlight">
                <h3><i class="fas fa-star"></i> Promociones y Beneficios del Mes</h3>
                <div class="promo-grid">
                    <div class="promo-card">
                        <h4><i class="fas fa-dumbbell"></i> Entrenamientos Personalizados</h4>
                        <p>Plan mayor a 6 meses → ¡Entrenamientos exclusivos con nuestros expertos!</p>
                    </div>

                    <div class="promo-card">
                        <h4><i class="fas fa-gift"></i> Mes Adicional Gratis</h4>
                        <p>¡Por cada referido que se una, ambos obtienen 1 mes adicional de membresía!</p>
                    </div>

                    <div class="promo-card">
                        <h4><i class="fas fa-percentage"></i> Descuento por Pago</h4>
                        <p>10% OFF en tu membresía si pagas en efectivo o por transferencia bancaria.</p>
                    </div>

                    <div class="promo-card">
                        <h4><i class="fas fa-medal"></i> Bonos por Duración</h4>
                        <p>Premium (6+ meses): +1 mes gratis • Deluxe (6+ meses): +2 meses gratis</p>
                    </div>

                    <div class="promo-card">
                        <h4><i class="fas fa-tshirt"></i> Kit de Entrenamiento</h4>
                        <p>Membresías Premium/Deluxe de 12 meses incluyen kit de entrenamiento SportPlus.</p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Actualizar datos en tiempo real (simulado)
            function updateClientCount() {
                fetch('/api/clientes/activos')
                        .then(response => response.json())
                        .then(data => {
                            document.querySelector('.metric-value').textContent = data.total;
                            document.querySelector('.stat-value').textContent = data.total;
                        });
            }
            
        </script>
    </body>
</html>