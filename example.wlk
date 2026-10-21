class Persona {
  var celulas = 0
  var gradosTemperatura = 0
  const enfermedades = []
  
  method contraer(enfermedad) {
    if (self.cantEnfermedades() >= 7) {
      throw new DomainException(
        message = "Una persona no puede tener mas de 7 enfermedades"
      )
    }
    enfermedades.add(enfermedad)
  }
  
  method cantEnfermedades() = enfermedades.size()
  
  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.aplicarEfecto(self) })
  }
  
  method aumentarTemperatura(grados) {
    gradosTemperatura = 45.min(grados + gradosTemperatura)
  }
  
  method destruirCelulas(celulasAmenazadas) {
    celulas = 0.max(celulas - celulasAmenazadas)
  }
  
  method recibirDosis(dosis) {
    enfermedades.forEach({ enfermedad => enfermedad.atenuarse(dosis * 15) })
  }
}

class Infecciosa inherits EnfermedadAtenuable {
  method reproducirse() {
    cantAmenazadas *= 2
  }
  
  method aplicarEfecto(persona) {
    persona.aumentarTemperatura(cantAmenazadas / 1000)
  }
}

class Autoinmune inherits EnfermedadAtenuable {
  method aplicarEfecto(persona) {
    persona.destruirCelulas(cantAmenazadas)
  }
} // ## Clase Herencia, Redefinicion, Clase abstracta

// superclase !!
class EnfermedadAtenuable {
  var cantAmenazadas = 0
  
  method atenuarse(celulasCuradas) {
    cantAmenazadas = 0.max(cantAmenazadas - celulasCuradas)
  }
}

class Medico inherits Persona {
  var dosis = 100
  
  method atender(persona) {
    persona.recibirDosis(dosis)
  }
}