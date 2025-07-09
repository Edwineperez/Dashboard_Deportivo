package Logica;

public class Beneficios {
    // Atributos de la clase
    private String plan;          // Tipo de plan del usuario
    private double peso;          // Peso del usuario en kilogramos
    private double altura;        // Altura del usuario en metros
    private int duracionPlan;     // Duración del plan en meses

    // Constructor
    public Beneficios(String plan, double peso, double altura, int duracionPlan) {
        this.plan = plan;
        this.peso = peso;
        this.altura = altura;
        this.duracionPlan = duracionPlan;
    }

    // Determina cuántas disciplinas puede practicar según su IMC
    public int cuantasDisciplinasPuedeAcceder() {
        double imc = peso / (altura * altura);
        if (imc < 18.5) return 1;
        if (imc <= 24.9) return 2;
        return 3;
    }

    // Determina acceso a sedes según tipo de plan
    public String accesoSedes() {
        return plan.equalsIgnoreCase("Premium") ? "3 sedes" : "6 sedes";
    }

    // Verifica si tiene acceso a entrenamientos personalizados
    public boolean accesoEntrenamientosPersonalizados() {
        return duracionPlan > 6;
    }

    // Descuentos y promociones

    // Aplica 10% de descuento si el pago es en efectivo o por transferencia
    public double aplicarDescuentoPorPago(String metodoPago, double precioBase) {
        if (metodoPago.equalsIgnoreCase("Efectivo") || metodoPago.equalsIgnoreCase("Transferencia/PSE")) {
            return precioBase * 0.90;
        }
        return precioBase;
    }

    // Aplica promoción por duración del plan
    public int aplicarPromocionPorDuracion(String plan, int mesesPagados) {
        if (plan.equalsIgnoreCase("Premium") && (mesesPagados == 6 || mesesPagados == 12)) {
            return mesesPagados + 1;
        }
        if (plan.equalsIgnoreCase("Deluxe") && (mesesPagados == 6 || mesesPagados == 12)) {
            return mesesPagados + 2;
        }
        return mesesPagados;
    }

    // Verifica si recibe kit de entrenamiento
    public boolean recibeKitEntrenamiento(String plan, int mesesPagados) {
        return (plan.equalsIgnoreCase("Premium") || plan.equalsIgnoreCase("Deluxe")) && mesesPagados == 12;
    }
}

