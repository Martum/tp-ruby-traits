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

# Una clase que lo use
class Matematica
  uses (OperacionesMatematicas - :te_sumo_20)

  # Pisa la definida en el Trait por estar mas abajo
  def te_sumo_20(unNumero)
    unNumero + 10
  end
end

class Matematica2
  uses OperacionesMatematicas
end

# Ejemplos de uso
objetito = Matematica.new
puts objetito.te_resto_10(6) # => -4

otroObjetito = Matematica.new
puts otroObjetito.te_sumo_20(1) # => 11 (Esta sobrescrito)

otroObjetito3 = Matematica2.new
puts otroObjetito3.te_sumo_20(1) # => 21

describe 'Trait Framework' do

  it 'should do something' do

    true.should == false
  end
end