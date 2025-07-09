<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Gestion.Persona, Conexion.ClienteDAO, java.util.*, java.sql.*" %>
<%@ page session="true" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    List<String> permisos = (List<String>) session.getAttribute("permisos");

    if (usuario == null || rol == null || permisos == null) {
        response.sendRedirect("/Formulario/Login/Login.jsp");
        return;
    }

    String documento = request.getParameter("search") != null ? request.getParameter("search") : "";
    int paginaActual = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int registrosPorPagina = 10;
    int inicio = (paginaActual - 1) * registrosPorPagina;

    List<Persona> clientes = new ArrayList<>();
    int totalRegistros = 0;
    int totalPaginas = 1;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/administracion", "root", "990204");

        String countSql = "SELECT COUNT(*) FROM clientes WHERE documento LIKE ?";
        stmt = conn.prepareStatement(countSql);
        stmt.setString(1, "%" + documento + "%");
        rs = stmt.executeQuery();
        if (rs.next()) {
            totalRegistros = rs.getInt(1);
            totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);
        }
        rs.close();
        stmt.close();

        String sql = "SELECT * FROM clientes WHERE documento LIKE ? LIMIT ?, ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, "%" + documento + "%");
        stmt.setInt(2, inicio);
        stmt.setInt(3, registrosPorPagina);
        rs = stmt.executeQuery();

        while (rs.next()) {
            Persona p = new Persona();
              p.setId(rs.getInt("id"));
            p.setDocumento(rs.getString("documento"));
            p.setNombres(rs.getString("nombres"));
            p.setApellidos(rs.getString("apellidos"));
            p.setEdad(rs.getInt("edad"));
            p.setAltura(rs.getDouble("altura"));
            p.setPeso(rs.getDouble("peso"));
            p.setPesoIdeal(rs.getDouble("peso_ideal"));
            p.setDireccion(rs.getString("direccion"));
            p.setTelefono(rs.getString("telefono"));
            p.setCiudad(rs.getString("ciudad"));
            p.setEmail(rs.getString("email"));
            p.setPlan(rs.getString("tipo_plan"));
            p.setDuracion(rs.getInt("duracion_meses"));
            p.setMesesConPromociones(rs.getInt("promocion"));
            p.setAccesoSedes(rs.getString("sedes"));
            p.setmPago(rs.getString("metodo_pago"));
            p.setPrecioFinal(rs.getDouble("precio_final"));
            clientes.add(p);
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html> 
<html>
<head>
    <title>Real Academy</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
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
                    <% } %>
                </li>      
                <li>
                    <% if (permisos.contains("ver_clientes")) { %>
                    <a href="../../Administracion/Clientes/ConsultarCliente.jsp">
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
                <h2>Gestión De Clientes</h2>
            </div>
            <div class="user--info">
                <img src="../../Administracion/Usuarios/css/Perfil.jpeg" alt=""/>
            </div>
        </div> 

        <div class="tabular--wrapper">
            <h3 class="main--title">Filtrar Clientes</h3><br>
            <form method="get" action="../../Administracion/Clientes/ConsultarCliente.jsp" class="mb-3 row g-3 align-items-center">
                <div class="col-auto">
                    <input type="text" name="search" placeholder="Buscar por documento" value="<%= documento %>" class="form-control" required>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary">Buscar</button>
                    <a href="../../Administracion/Clientes/ConsultarCliente.jsp" class="btn btn-secondary">Mostrar todos</a>
                </div>
            </form>                                      
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Documento</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Edad</th>
                            <th>Altura(m)</th>
                            <th>Peso(kg)</th>
                            <th>Peso Ideal</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Ciudad</th>
                            <th>Email</th>
                            <th>Tipo de Plan</th>
                            <th>Meses con o sin Promo</th>
                            <th>Acceso a sedes</th>
                            <th>Medio de Pago</th>
                            <th>Precio Total</th>
                            <% if (permisos.contains("actualizar_clientes") || permisos.contains("eliminar_clientes")) { %>
                            <th>Accion</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (clientes.isEmpty()) { %>
                        <tr><td colspan="7" class="text-center">No se encontraron clientes</td></tr>
                        <% } else {
                            for (Persona cliente : clientes) { %>
                        <tr>
                            <td><%= cliente.getId() %></td>
                            <td><%= cliente.getDocumento() %></td>
                            <td><%= cliente.getNombres() %></td>
                            <td><%= cliente.getApellidos() %></td>
                            <td><%= cliente.getEdad()%></td>
                            <td><%= cliente.getAltura()%></td>
                            <td><%= cliente.getPeso()%></td>
                            <td><%= cliente.getPesoIdeal()%></td>
                            <td><%= cliente.getDireccion()%></td>
                            <td><%= cliente.getTelefono() != null ? cliente.getTelefono() : "N/A" %></td>
                            <td><%= cliente.getCiudad()%></td>
                            <td><%= cliente.getEmail() != null ? cliente.getEmail() : "N/A" %></td>
                            <td><%= cliente.getPlan()%></td>
                            <td><%= cliente.getMesesConPromociones()%></td>
                            <td><%= cliente.getAccesoSedes()%></td>
                            <td><%= cliente.getmPago()%></td>
                            <td><%= cliente.getPrecioFinal()%></td>
                            
                            
                            <% if (permisos.contains("actualizar_clientes") || permisos.contains("eliminar_clientes")) { %>
                            <td>
                                <% if (permisos.contains("actualizar_clientes")) { %>
                                <a href="EditarCliente.jsp?documento=<%= cliente.getDocumento() %>" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Editar
                                </a>
                                <% } %>
                                
                                <% if (permisos.contains("eliminar_clientes")) { %>
                                <button onclick="confirmarEliminacion('<%= cliente.getDocumento() %>')" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
                                <% } %>
                            </td>
                            <% } %>
                        </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>

            <% if (totalPaginas > 1) { %>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <% for (int i = 1; i <= totalPaginas; i++) { %>
                    <li class="page-item <%= i == paginaActual ? "active" : "" %>">
                        <a class="page-link" href="ConsultarCliente.jsp?page=<%= i %>&search=<%= documento %>"><%= i %></a>
                    </li>
                    <% } %>
                </ul>
            </nav>
            <% } %>
        </div>
    </div>

    <script>
        function confirmarEliminacion(documento) {
            if (confirm("¿Estás seguro de eliminar este cliente?")) {
                window.location.href = "/Formulario/Administracion/Clientes/EliminarCliente.jsp?documento=" + documento;
            }
        }
    </script>
</body>
</html>
