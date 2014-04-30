require 'rspec'
require '../src/trait'

Trait.define do
  name :OperacionesMatematicas

  method :te_sumo_20 do |unNumerito|
    unNumerito + 20
  end

  method :te_resto_10 do |unNumerito|
    unNumerito - 10
  end
end

Trait.define do
  name :AlgunasOperacionesMatematicas

  method :te_sumo_30 do |unNumerito|
    unNumerito + 30
  end

end

Trait.define do
  name :PrimerTrait

  method :duplicated do |unArgumento|
    unArgumento + 20
  end
end

Trait.define do
  name :SegundoTrait

  method :duplicated do |unArgumento|
    unArgumento + 30
  end
end

Trait.define do
  name :ModificoEstadoVariable1

  method :modificar_estado do
    self.variable1 = 40
    puts "hola1"
  end
end

Trait.define do
  name :ModificoEstadoVariable2

  method :modificar_estado do
    self.variable2 = 50
    puts "hola2"
  end
end

describe 'Prueba suma tratis' do

  it 'sumar traits y poder usar los metodos de ambos' do

    class SuperClaseMagica
      uses OperacionesMatematicas + AlgunasOperacionesMatematicas
    end

    unaCosa = SuperClaseMagica.new

    unaCosa.te_sumo_20(10).should == 30
    unaCosa.te_sumo_30(20).should == 50
    unaCosa.te_resto_10(100).should == 90
  end

  it 'si hay dos metodos duplicados, los tiene que ejercutar ambos' do

    class ClasePrueba
      uses PrimerTrait + SegundoTrait
    end

    instancia = ClasePrueba.new

    instancia.duplicated(10).should == 40
  end

  it 'si hay dos metodos duplicados, los tiene que correr en row' do
    class TestModificanEstado
      attr_accessor :variable1, :variable2
      uses ModificoEstadoVariable1 + ModificoEstadoVariable2

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