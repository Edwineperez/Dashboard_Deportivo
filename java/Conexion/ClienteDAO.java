package Conexion;

import Gestion.Persona;
import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    private Connection conn;

    public ClienteDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean registrarCliente(Persona c) {
        String sql = "INSERT INTO clientes (nombres, apellidos, sexo, tipo_documento, documento, lugar_nacimiento, pais, grupo_sanguineo, fecha_nacimiento, edad, altura, peso, promedio, peso_ideal, direccion, telefono, ciudad, email, club, deporte, categoria, p_nombres, p_apellidos, parentesco, ocupacion, telefono_1, email_1, a_nombres, a_apellidos, telefono_2, tipo_plan, duracion_meses, promocion, sedes, precio_total, metodo_pago, precio_final) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNombres());
            stmt.setString(2, c.getApellidos());
            stmt.setString(3, c.getSexo());
            stmt.setString(4, c.getTdocumento());
            stmt.setString(5, c.getDocumento());
            stmt.setString(6, c.getLnacimiento());
            stmt.setString(7, c.getPais());
            stmt.setString(8, c.getRH());
            stmt.setString(9, c.getFnacimiento());
            stmt.setInt(10, c.getEdad());
            stmt.setDouble(11, c.getAltura());
            stmt.setDouble(12, c.getPeso());
            stmt.setDouble(13, c.getPromedio());
            stmt.setDouble(14, c.getPesoIdeal());
            stmt.setString(15, c.getDireccion());
            stmt.setString(16, c.getTelefono());
            stmt.setString(17, c.getCiudad());
            stmt.setString(18, c.getEmail());
            stmt.setString(19, c.getClub());
            stmt.setString(20, c.getDeporte());
            stmt.setString(21, c.getCategoria());
            stmt.setString(22, c.getP_nombres());
            stmt.setString(23, c.getP_apellidos());
            stmt.setString(24, c.getParentesco());
            stmt.setString(25, c.getOcupacion());
            stmt.setString(26, c.getTelefono_1());
            stmt.setString(27, c.getEmail_1());
            stmt.setString(28, c.getA_nombres());
            stmt.setString(29, c.getA_apellidos());
            stmt.setString(30, c.getTelefono_2());
            stmt.setString(31, c.getPlan());
            stmt.setInt(32, c.getDuracion());
            stmt.setInt(33, c.getMesesConPromociones());
            stmt.setString(34, c.getAccesoSedes());
            stmt.setDouble(35, c.getPrecioBase());
            stmt.setString(36, c.getmPago());
            stmt.setDouble(37, c.getPrecioFinal());

            int filas = stmt.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            System.err.println("Error al registrar cliente: " + e.getMessage());
            return false;
        }
    }

public List<Persona> buscarCliente(String search, int offset, int registrosPorPagina) {
    List<Persona> lista = new ArrayList<>();
    String sql = "SELECT * FROM clientes WHERE documento = ? LIMIT ?, ?";
    
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, search); // Búsqueda exacta por documento
        ps.setInt(2, offset);
        ps.setInt(3, registrosPorPagina);
        
        ResultSet rs = ps.executeQuery();
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
            lista.add(p);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}


public int contarClientes(String search) {
    int total = 0;
    String sql = "SELECT COUNT(*) FROM clientes WHERE documento = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, search);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return total;
}

public Persona editarCliente(String documento) {
    String sql = "SELECT * FROM clientes WHERE documento = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, documento);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Persona p = new Persona();
            p.setId(rs.getInt("id"));
            p.setNombres(rs.getString("nombres"));
            p.setApellidos(rs.getString("apellidos"));
            p.setSexo(rs.getString("sexo"));
            p.setTdocumento(rs.getString("tipo_documento"));
            p.setDocumento(rs.getString("documento"));
            p.setLnacimiento(rs.getString("lugar_nacimiento"));
            p.setPais(rs.getString("pais"));
            p.setRH(rs.getString("grupo_sanguineo"));
            p.setFnacimiento(rs.getString("fecha_nacimiento"));
            p.setEdad(rs.getInt("edad"));
            p.setAltura(rs.getDouble("altura"));
            p.setPeso(rs.getDouble("peso"));
            p.setPromedio(rs.getDouble("promedio"));
            p.setPesoIdeal(rs.getDouble("peso_ideal"));
            p.setDireccion(rs.getString("direccion"));
            p.setTelefono(rs.getString("telefono"));
            p.setCiudad(rs.getString("ciudad"));
            p.setEmail(rs.getString("email"));
            p.setClub(rs.getString("club"));
            p.setDeporte(rs.getString("deporte"));
            p.setCategoria(rs.getString("categoria"));
            p.setP_nombres(rs.getString("p_nombres"));
            p.setP_apellidos(rs.getString("p_apellidos"));
            p.setParentesco(rs.getString("parentesco"));
            p.setOcupacion(rs.getString("ocupacion"));
            p.setTelefono_1(rs.getString("telefono_1"));
            p.setEmail_1(rs.getString("email_1"));
            p.setA_nombres(rs.getString("a_nombres"));
            p.setA_apellidos(rs.getString("a_apellidos"));
            p.setTelefono_2(rs.getString("telefono_2"));
            p.setPlan(rs.getString("tipo_plan"));
            p.setDuracion(rs.getInt("duracion_meses"));
            p.setMesesConPromociones(rs.getInt("promocion"));
            p.setAccesoSedes(rs.getString("sedes"));
            p.setPrecioBase(rs.getDouble("precio_total"));
            p.setmPago(rs.getString("metodo_pago"));
            p.setPrecioFinal(rs.getDouble("precio_final"));

            return p;
        }
    } catch (SQLException e) {
        System.err.println("Error al obtener cliente por documento: " + e.getMessage());
        e.printStackTrace();
    }
    return null;
}

    public boolean actualizarCliente(Persona c) {
        String sql = "UPDATE clientes SET "
                + "nombres = ?, "
                + "apellidos = ?, "
                + "sexo = ?, "
                + "tipo_documento = ?, "
                + "documento = ?, "
                + "lugar_nacimiento = ?, "
                + "pais = ?, "
                + "grupo_sanguineo = ?, "
                + "fecha_nacimiento = ?, "
                + "edad = ?, "
                + "altura = ?, "
                + "peso = ?, "
                + "promedio = ?, "
                + "peso_ideal = ?, "
                + "direccion = ?, "
                + "telefono = ?, "
                + "ciudad = ?, "
                + "email = ?, "
                + "club = ?, "
                + "deporte = ?, "
                + "categoria = ?, "
                + "p_nombres = ?, "
                + "p_apellidos = ?, "
                + "parentesco = ?, "
                + "ocupacion = ?, "
                + "telefono_1 = ?, "
                + "email_1 = ?, "
                + "a_nombres = ?, "
                + "a_apellidos = ?, "
                + "telefono_2 = ?, "
                + "tipo_plan = ?, "
                + "duracion_meses = ?, "
                + "promocion = ?, "
                + "sedes = ?, "
                + "precio_total = ?, "
                + "metodo_pago = ?, "
                + "precio_final = ? "
                + "WHERE documento = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getNombres());
            ps.setString(2, c.getApellidos());
            ps.setString(3, c.getSexo());
            ps.setString(4, c.getTdocumento());
            ps.setString(5, c.getDocumento());
            ps.setString(6, c.getLnacimiento());
            ps.setString(7, c.getPais());
            ps.setString(8, c.getRH());
            ps.setString(9, c.getFnacimiento());
            ps.setInt(10, c.getEdad());
            ps.setDouble(11, c.getAltura());
            ps.setDouble(12, c.getPeso());
            ps.setDouble(13, c.getPromedio());
            ps.setDouble(14, c.getPesoIdeal());
            ps.setString(15, c.getDireccion());
            ps.setString(16, c.getTelefono());
            ps.setString(17, c.getCiudad());
            ps.setString(18, c.getEmail());
            ps.setString(19, c.getClub());
            ps.setString(20, c.getDeporte());
            ps.setString(21, c.getCategoria());
            ps.setString(22, c.getP_nombres());
            ps.setString(23, c.getP_apellidos());
            ps.setString(24, c.getParentesco());
            ps.setString(25, c.getOcupacion());
            ps.setString(26, c.getTelefono_1());
            ps.setString(27, c.getEmail_1());
            ps.setString(28, c.getA_nombres());
            ps.setString(29, c.getA_apellidos());
            ps.setString(30, c.getTelefono_2());
            ps.setString(31, c.getPlan());
            ps.setInt(32, c.getDuracion());
            ps.setInt(33, c.getMesesConPromociones());
            ps.setString(34, c.getAccesoSedes());
            ps.setDouble(35, c.getPrecioBase());
            ps.setString(36, c.getmPago());
            ps.setDouble(37, c.getPrecioFinal());
            // Parámetro para el WHERE
            ps.setString(38, c.getDocumento());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean eliminarCliente(String documento) {
    String sql = "DELETE FROM clientes WHERE documento = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, documento);
        int filasAfectadas = stmt.executeUpdate();
        return filasAfectadas > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

}









