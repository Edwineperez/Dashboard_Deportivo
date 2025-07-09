<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Gestion.Persona" %>
<%@ page import="Conexion.ClienteDAO" %>
<%@ page import="Conexion.ConexionBD" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Connection" %>

<%
    request.setCharacterEncoding("UTF-8");

    // Obtener parámetros del formulario
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
    double pesoIdeal = 0;
    int edad = 0;

    try {
        if (request.getParameter("Altura") != null && !request.getParameter("Altura").isEmpty()) {
            altura = Double.parseDouble(request.getParameter("Altura").replace(",", "."));
        }
        if (request.getParameter("Peso") != null && !request.getParameter("Peso").isEmpty()) {
            peso = Double.parseDouble(request.getParameter("Peso").replace(",", "."));
        }
        if (request.getParameter("Promedio") != null && !request.getParameter("Promedio").isEmpty()) {
            promedio = Double.parseDouble(request.getParameter("Promedio").replace(",", "."));
        }
        if (request.getParameter("PesoIdeal") != null && !request.getParameter("PesoIdeal").isEmpty()) {
            // Extraer solo la parte numérica eliminando " kg" si existe
            String pesoIdealStr = request.getParameter("PesoIdeal").replace(" kg", "").replace(",", ".");
            pesoIdeal = Double.parseDouble(pesoIdealStr);
        }
        if (request.getParameter("edad") != null && !request.getParameter("edad").isEmpty()) {
            edad = Integer.parseInt(request.getParameter("edad"));
        }
    } catch (NumberFormatException e) {
%>
    <script>
        alert("Error en formato numérico: <%= e.getMessage().replace("\"", "\\\"")%>");
        history.back();
    </script>

<%
        return;
    }

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
    String ocupacion = request.getParameter("ocupacion");
    String telefono_1 = request.getParameter("telefono_1");
    String email_1 = request.getParameter("email_1");
    
    String A_nombres = request.getParameter("A_nombres");
    String A_apellidos = request.getParameter("A_apellidos");
    String telefono_2 = request.getParameter("telefono_2");
    
    String plan = request.getParameter("Plan");
    int duracion = request.getParameter("duracion") != null ? Integer.parseInt(request.getParameter("duracion")) : 0;
    int mesesConPromociones = request.getParameter("mesesConPromociones") != null ? Integer.parseInt(request.getParameter("mesesConPromociones")) : 0;
    String accesoSedes = request.getParameter("accesoSedes");
    double precioBase = request.getParameter("precioBase") != null ? Double.parseDouble(request.getParameter("precioBase")) : 0;
    String metodoPago = request.getParameter("mPago");
    double precioFinal = request.getParameter("precioFinal") != null ? Double.parseDouble(request.getParameter("precioFinal")) : 0;

    // Crear objeto Cliente
    Persona c = new Persona();
    c.setNombres(nombres);
    c.setApellidos(apellidos);
    c.setSexo(sexo);
    c.setTdocumento(tdocumento);
    c.setDocumento(documento);
    c.setLnacimiento(Lnacimiento);
    c.setPais(pais);
    c.setRH(RH);
    c.setFnacimiento(fnacimiento);
    c.setEdad(edad);
    c.setAltura(altura);
    c.setPeso(peso);
    c.setPromedio(promedio);
    c.setPesoIdeal(pesoIdeal);
    c.setDireccion(direccion);
    c.setTelefono(telefono);
    c.setCiudad(ciudad);
    c.setEmail(email);
    c.setClub(club);
    c.setDeporte(deporte);
    c.setCategoria(categoria);
    c.setP_nombres(P_nombres);
    c.setP_apellidos(P_apellidos);
    c.setParentesco(parentesco);
    c.setOcupacion(ocupacion);
    c.setTelefono_1(telefono_1);
    c.setEmail_1(email_1);
    c.setA_nombres(A_nombres);
    c.setA_apellidos(A_apellidos);
    c.setTelefono_2(telefono_2);
    c.setPlan(plan);
    c.setDuracion(duracion);
    c.setMesesConPromociones(mesesConPromociones);
    c.setAccesoSedes(accesoSedes);
    c.setPrecioBase(precioBase);
    c.setmPago(metodoPago);
    c.setPrecioFinal(precioFinal);

    try {
        Connection conn = ConexionBD.conectar();
        ClienteDAO dao = new ClienteDAO(conn);  
        boolean actualizado = dao.actualizarCliente(c);

        if (actualizado) {
%>
            <script>
                alert("Cliente actualizado correctamente.");
                window.location.href = "/Formulario/Administracion/Clientes/ConsultarCliente.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("Error al actualizar el cliente. Intente nuevamente.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert("Se produjo un error al procesar la solicitud: <%= e.getMessage().replace("\"", "\\\"")%>");
    history.back();
</script>

<%
    } 
%>

