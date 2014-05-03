require 'rspec'
require '../src/trait'
require '../src/ejecutar_ambos_metodos_resolucion'

Trait.define do
  name :Primero1

  method :duplicated do
    puts 'hola'
  end
end

Trait.define do
  name :Segundo1

  method :duplicated do
    puts 'santi'
  end
end

describe 'Resolver conflictos' do
  it 'Ejecuta ambos metodos en row' do
    class MiClase
      uses Primero1 + (Segundo1 < {:duplicated => EjecutarAmbosMetodosResolucion.new})
    end

    instancia = MiClase.new
    instancia.duplicated #deberia imprimir 'hola'\n''santi'
  end

end