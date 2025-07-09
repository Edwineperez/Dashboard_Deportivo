package Logica;

import java.util.regex.Pattern;
import java.time.LocalDate;
import java.time.Period;

public class Valida_Formulario {

    // Método para calcular la edad a partir de la fecha de nacimiento
    public int calcularEdad(String fechaNacimiento) {
        LocalDate fechaNac = LocalDate.parse(fechaNacimiento); // Convierte la fecha de nacimiento en un objeto LocalDate
        LocalDate hoy = LocalDate.now(); // Obtiene la fecha actual
        return Period.between(fechaNac, hoy).getYears(); // Calcula la diferencia en años
    }

    // Método para validar que la edad esté dentro del rango permitido (5 a 40 años)
    public boolean validarEdad(int edad) {
        return edad >= 5 && edad <= 40;
    }

    // Método para validar el formato de un correo electrónico usando una expresión regular
    public boolean validarCorreo(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@(.+)$"; // Expresión regular para validar correos electrónicos
        return Pattern.matches(regex, email); // Retorna true si el email coincide con el patrón
    }
    

    // Método para verificar si el usuario ha aceptado los términos y condiciones
    public boolean validarCondiciones(boolean aceptado) {
        return aceptado; // Retorna true si el usuario ha aceptado las condiciones
    }

    // Método para validar el estado del peso en función del índice de masa corporal (IMC)
    public String validarPesoAltura(double peso, double altura) {
        double imc = peso / (altura * altura); // Cálculo del IMC
        if (imc < 18.5) return "Bajo peso - Se recomienda valoración nutricional.";
        if (imc >= 18.5 && imc <= 24.9) return "Peso normal.";
        return "Sobrepeso - Se recomienda valoración nutricional.";
    }

    // Método para calcular el peso ideal con base en la altura, usando un IMC de referencia de 22
    public double calcularPesoIdeal(double altura) {
        return 22 * (altura * altura); // Retorna el peso ideal basado en un IMC óptimo
    }
}
