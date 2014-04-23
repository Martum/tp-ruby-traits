require 'rspec'
require '../src/trait'
# Temporalmente ACA - Falta ordenar y probar
# Definir el trait
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
  name :Algunas

  method :te_sumo_20 do |unNumerito|
    "ogmfdo"
  end
end

# Una clase que lo use
#class Matematica
# uses (OperacionesMatematicas - :te_sumo_20)
#end

#class Matematica2
#  uses OperacionesMatematicas
#end

# Ejemplos de uso
#objetito = Matematica.new
#puts objetito.te_resto_10(6) # => -4

#otroObjetito = Matematica.new
#puts otroObjetito.te_sumo_20(1) # => 11 (Esta sobrescrito)

#otroObjetito3 = Matematica2.new
#puts otroObjetito3.te_sumo_20(1) # => 21

describe 'Prueba del uses' do

  it 'poder usar el metodo definido en el trait' do

    class SuperClaseMagica
      uses OperacionesMatematicas
    end

    unaCosa = SuperClaseMagica.new

    unaCosa.te_sumo_20(10).should == 30
    unaCosa.te_resto_10(2).should == -8

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

  it 'suma cuando hay metodos duplicados' do

    expect {
      class Super_Clase_Magica
        uses OperacionesMagicas + Algunas
      end
    }.to raise_exception
  end
end

describe 'Prueba resta de metodos' do

  it 'resta cuando el metodo fue removido' do

    class Matematica
      uses (OperacionesMatematicas - :te_sumo_20)
    end

    otroObjetito = Matematica.new

    expect {otroObjetito.te_sumo_20(1)}.to raise_exception
  end
end

describe 'Prueba alias de metodos' do
  it 'alias a un metodo existente por uno inexistente' do
    class Matematica
      uses OperacionesMatematicas << (:te_sumo_20 > :te_agrego_20)
    end

    objetoMatematica = Matematica.new

    objetoMatematica.te_sumo_20(2).should be 22
    objetoMatematica.te_agrego_20(3).should be 23
  end

  it 'alias a un metodo inexistente por uno inexistente' do
    expect {
      class Matematica
        uses OperacionesMatematicas << (:te_sumo_300 > :te_agrego_20)
      end
    }.to raise_exception
  end

  it 'alias de un metodo existente por uno existente' do
    expect {
      class Matematica
        uses OperacionesMatematicas << (:te_sumo_20 > :te_resto_10)
      end
    }.to raise_exception
  end
end