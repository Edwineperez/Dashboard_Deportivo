package Gestion;

import java.io.Serializable;
import java.util.List;
        
public class Usuario implements Serializable {
    private int id;
    private String usuario;
    private String password;
    private Rol rol;
    private List<String> permisos;

    public Usuario() {}

    public Usuario(String usuario, String password, Rol rol, List<String> permisos) {
        this.usuario = usuario;
        this.password = password;
        this.rol = rol;
        this.permisos = permisos;
    }

    public Usuario(int id, String usuario, String password, Rol rol, List<String> permisos) {
        this.id = id;
        this.usuario = usuario;
        this.password = password;
        this.rol = rol;
        this.permisos = permisos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    public List<String> getPermisos() {
        return permisos;
    }

    public void setPermisos(List<String> permisos) {
        this.permisos = permisos;
    }
    
}