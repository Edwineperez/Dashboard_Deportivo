<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Conexion.DAOUSUARIO, Gestion.Usuario, Conexion.ConexionBD" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Inicializar variables de error
    String errorMessage = null;
    
    // Verificar si hay parámetros de login enviados
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection conn = null;
        try {
            conn = ConexionBD.conectar();
            DAOUSUARIO dao = new DAOUSUARIO(conn);
            Usuario usuario = dao.autenticar(username, password);
            
            if (usuario != null) {
                // Iniciar sesión y redirigir
                session.setAttribute("usuario", usuario.getUsuario());
                session.setAttribute("rol", usuario.getRol().getNombre());
                session.setAttribute("permisos", usuario.getPermisos());
                response.sendRedirect("/Formulario/Dashboard/Panel.jsp");
                return;
            } else {
                errorMessage = "Usuario o contraseña incorrectos";
            }
        } catch(Exception e) {
            errorMessage = "Error en el sistema: " + e.getMessage();
        } finally {
            if (conn != null) conn.close();
        }
    }
    
    // Invalidar sesión existente si es necesario
    if (session.getAttribute("usuario") != null) {
        session.invalidate();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Usuarios</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background: linear-gradient(135deg, #c9d6ff, #e2e2e2);
            }

            .container {
                width: 400px;
                background: #ffffff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
                padding: 40px 30px;
                transition: all 0.3s ease;
            }

            h1 {
                text-align: center;
                font-size: 32px;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            .input-box {
                position: relative;
                margin-bottom: 25px;
            }

            .input-box input {
                width: 100%;
                padding: 14px 45px 14px 15px;
                background: #f0f0f0;
                border: none;
                border-radius: 10px;
                font-size: 15px;
                color: #333;
                outline: none;
                transition: background 0.2s ease;
            }

            .input-box input:focus {
                background: #eaeaea;
            }

            .input-box i {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #888;
                font-size: 18px;
            }

            .forgot-link {
                text-align: center;
                margin-bottom: 20px;
            }

            .forgot-link a {
                font-size: 14px;
                color: #555;
                text-decoration: none;
                transition: color 0.3s;
            }

            .forgot-link a:hover {
                color: #7494ec;
            }

            .btn {
                width: 100%;
                padding: 12px;
                border: none;
                background-color: #7494ec;
                color: #fff;
                font-size: 16px;
                border-radius: 10px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .btn:hover {
                background-color: #5c7dd9;
            }
            
            .error-message {
                color: #e74c3c;
                text-align: center;
                margin-bottom: 20px;
                padding: 10px;
                background-color: #ffebee;
                border-radius: 5px;
                border-left: 4px solid #e74c3c;
                animation: fadeIn 0.5s;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>
    </head>

<body>
    <div class="container">
        <div class="form-login">
            <form action="/Formulario/Login/Login.jsp" method="post"> 
                <h1>Login</h1>
                
                <%-- Mostrar mensaje de error si existe --%>
                <% if (errorMessage != null) { %>
                    <div class="error-message">
                        <i class='bx bx-error-circle'></i> <%= errorMessage %>
                    </div>
                <% } %>
                
                <div class="input-box">
                    <input type="text" name="username" placeholder="Username" required value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                    <i class="bx bx-user"></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password" required>
                    <i class='bx bx-lock'></i> 
                </div>
                <button type="submit" class="btn">Ingresar</button>
            </form>
        </div>
    </div>
</body>
</html>


