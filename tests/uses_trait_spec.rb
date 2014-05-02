require 'rspec'
require '../src/trait'

# Definir el trait
Trait.define do
  name :OperacionesMatematicas2

  method :te_sumo_20 do |unNumerito|
    unNumerito + 20
  end

  method :te_resto_10 do |unNumerito|
    unNumerito - 10
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

  it 'Usar el metodo definido en el trait' do

    class SuperClaseMagica
      uses OperacionesMatematicas2
    end

    unaCosa = SuperClaseMagica.new

    unaCosa.te_sumo_20(10).should == 30
    unaCosa.te_resto_10(2).should == -8

  end
end

describe 'Usando uses en otros objetos' do
  it 'un numero intenta usar uses' do
      expect{
        9.uses OperacionesMatematicas2
      }.to raise_error(NoMethodError)
  end
end