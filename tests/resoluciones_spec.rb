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

Trait.define do
  name :ModificoEstadoVariable1

  method :modificar_estado do
    self.variable1 = 40
  end
end

Trait.define do
  name :ModificoEstadoVariable2

  method :modificar_estado do
    self.variable2 = 50
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


  it 'si hay dos metodos duplicados, los tiene que correr en row' do
    class TestModificanEstado
      attr_accessor :variable1, :variable2
      uses ModificoEstadoVariable1 + (ModificoEstadoVariable2 < {:modificar_estado => EjecutarAmbosMetodosResolucion.new})

      def initialize
        @variable1 = 1
        @variable2 = 2
      end
    end


    instancia = TestModificanEstado.new
    instancia.modificar_estado

    instancia.variable1.should == 40
    instancia.variable2.should == 50
  end

end