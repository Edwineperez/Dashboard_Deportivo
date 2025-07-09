package Gestion;

public class Persona {
    // Datos personales
    private int id;
    private String nombres;
    private String apellidos;
    private String sexo;
    private String tdocumento;
    private String documento;
    private String Lnacimiento;
    private String pais;
    private String RH;
    private String fnacimiento;
    private int edad;
    private double Altura;
    private double Peso;
    private double Promedio;
    private double pesoIdeal;

    // Información de contacto
    private String direccion;
    private String telefono;
    private String ciudad;
    private String email;

    // Información deportiva
    private String club;
    private String deporte;
    private String categoria;

    // Contacto de emergencia 1
    private String P_nombres;
    private String P_apellidos;
    private String parentesco;
    private String ocupacion;
    private String telefono_1;
    private String email_1;

    // Contacto de emergencia 2
    private String A_nombres;
    private String A_apellidos;
    private String telefono_2;

    // Planes y pagos
    private String Plan;
    private int duracion;
    private int mesesConPromociones;
    private String accesoSedes;
    private double precioBase;
    private String mPago;
    private double precioFinal;
    
    public Persona() {
}

    public Persona(String nombres, String apellidos, String sexo, String tdocumento, String documento, String Lnacimiento, String pais, String RH, String fnacimiento, int edad, double Altura, double Peso, double Promedio, double pesoIdeal, String direccion, String telefono, String ciudad, String email, String club, String deporte, String categoria, String P_nombres, String P_apellidos, String parentesco, String ocupacion, String telefono_1, String email_1, String A_nombres, String A_apellidos, String telefono_2, String Plan, int duracion, int mesesConPromociones, String accesoSedes, double precioBase, String mPago, double precioFinal) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.tdocumento = tdocumento;
        this.documento = documento;
        this.Lnacimiento = Lnacimiento;
        this.pais = pais;
        this.RH = RH;
        this.fnacimiento = fnacimiento;
        this.edad = edad;
        this.Altura = Altura;
        this.Peso = Peso;
        this.Promedio = Promedio;
        this.pesoIdeal = pesoIdeal;
        this.direccion = direccion;
        this.telefono = telefono;
        this.ciudad = ciudad;
        this.email = email;
        this.club = club;
        this.deporte = deporte;
        this.categoria = categoria;
        this.P_nombres = P_nombres;
        this.P_apellidos = P_apellidos;
        this.parentesco = parentesco;
        this.ocupacion = ocupacion;
        this.telefono_1 = telefono_1;
        this.email_1 = email_1;
        this.A_nombres = A_nombres;
        this.A_apellidos = A_apellidos;
        this.telefono_2 = telefono_2;
        this.Plan = Plan;
        this.duracion = duracion;
        this.mesesConPromociones = mesesConPromociones;
        this.accesoSedes = accesoSedes;
        this.precioBase = precioBase;
        this.mPago = mPago;
        this.precioFinal = precioFinal;
    }

    public Persona(int id, String nombres, String apellidos, String sexo, String tdocumento, String documento, String Lnacimiento, String pais, String RH, String fnacimiento, int edad, double Altura, double Peso, double Promedio, double pesoIdeal, String direccion, String telefono, String ciudad, String email, String club, String deporte, String categoria, String P_nombres, String P_apellidos, String parentesco, String ocupacion, String telefono_1, String email_1, String A_nombres, String A_apellidos, String telefono_2, String Plan, int duracion, int mesesConPromociones, String accesoSedes, double precioBase, String mPago, double precioFinal) {
        this.id = id;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.tdocumento = tdocumento;
        this.documento = documento;
        this.Lnacimiento = Lnacimiento;
        this.pais = pais;
        this.RH = RH;
        this.fnacimiento = fnacimiento;
        this.edad = edad;
        this.Altura = Altura;
        this.Peso = Peso;
        this.Promedio = Promedio;
        this.pesoIdeal = pesoIdeal;
        this.direccion = direccion;
        this.telefono = telefono;
        this.ciudad = ciudad;
        this.email = email;
        this.club = club;
        this.deporte = deporte;
        this.categoria = categoria;
        this.P_nombres = P_nombres;
        this.P_apellidos = P_apellidos;
        this.parentesco = parentesco;
        this.ocupacion = ocupacion;
        this.telefono_1 = telefono_1;
        this.email_1 = email_1;
        this.A_nombres = A_nombres;
        this.A_apellidos = A_apellidos;
        this.telefono_2 = telefono_2;
        this.Plan = Plan;
        this.duracion = duracion;
        this.mesesConPromociones = mesesConPromociones;
        this.accesoSedes = accesoSedes;
        this.precioBase = precioBase;
        this.mPago = mPago;
        this.precioFinal = precioFinal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getTdocumento() {
        return tdocumento;
    }

    public void setTdocumento(String tdocumento) {
        this.tdocumento = tdocumento;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getLnacimiento() {
        return Lnacimiento;
    }

    public void setLnacimiento(String Lnacimiento) {
        this.Lnacimiento = Lnacimiento;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getRH() {
        return RH;
    }

    public void setRH(String RH) {
        this.RH = RH;
    }

    public String getFnacimiento() {
        return fnacimiento;
    }

    public void setFnacimiento(String fnacimiento) {
        this.fnacimiento = fnacimiento;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getAltura() {
        return Altura;
    }

    public void setAltura(double Altura) {
        this.Altura = Altura;
    }

    public double getPeso() {
        return Peso;
    }

    public void setPeso(double Peso) {
        this.Peso = Peso;
    }

    public double getPromedio() {
        return Promedio;
    }

    public void setPromedio(double Promedio) {
        this.Promedio = Promedio;
    }

    public double getPesoIdeal() {
        return pesoIdeal;
    }

    public void setPesoIdeal(double pesoIdeal) {
        this.pesoIdeal = pesoIdeal;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getClub() {
        return club;
    }

    public void setClub(String club) {
        this.club = club;
    }

    public String getDeporte() {
        return deporte;
    }

    public void setDeporte(String deporte) {
        this.deporte = deporte;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getP_nombres() {
        return P_nombres;
    }

    public void setP_nombres(String P_nombres) {
        this.P_nombres = P_nombres;
    }

    public String getP_apellidos() {
        return P_apellidos;
    }

    public void setP_apellidos(String P_apellidos) {
        this.P_apellidos = P_apellidos;
    }

    public String getParentesco() {
        return parentesco;
    }

    public void setParentesco(String parentesco) {
        this.parentesco = parentesco;
    }

    public String getOcupacion() {
        return ocupacion;
    }

    public void setOcupacion(String ocupacion) {
        this.ocupacion = ocupacion;
    }

    public String getTelefono_1() {
        return telefono_1;
    }

    public void setTelefono_1(String telefono_1) {
        this.telefono_1 = telefono_1;
    }

    public String getEmail_1() {
        return email_1;
    }

    public void setEmail_1(String email_1) {
        this.email_1 = email_1;
    }

    public String getA_nombres() {
        return A_nombres;
    }

    public void setA_nombres(String A_nombres) {
        this.A_nombres = A_nombres;
    }

    public String getA_apellidos() {
        return A_apellidos;
    }

    public void setA_apellidos(String A_apellidos) {
        this.A_apellidos = A_apellidos;
    }

    public String getTelefono_2() {
        return telefono_2;
    }

    public void setTelefono_2(String telefono_2) {
        this.telefono_2 = telefono_2;
    }

    public String getPlan() {
        return Plan;
    }

    public void setPlan(String Plan) {
        this.Plan = Plan;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public int getMesesConPromociones() {
        return mesesConPromociones;
    }

    public void setMesesConPromociones(int mesesConPromociones) {
        this.mesesConPromociones = mesesConPromociones;
    }

    public String getAccesoSedes() {
        return accesoSedes;
    }

    public void setAccesoSedes(String accesoSedes) {
        this.accesoSedes = accesoSedes;
    }

    public double getPrecioBase() {
        return precioBase;
    }

    public void setPrecioBase(double precioBase) {
        this.precioBase = precioBase;
    }

    public String getmPago() {
        return mPago;
    }

    public void setmPago(String mPago) {
        this.mPago = mPago;
    }

    public double getPrecioFinal() {
        return precioFinal;
    }

    public void setPrecioFinal(double precioFinal) {
        this.precioFinal = precioFinal;
    }

}