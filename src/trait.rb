# Clase de la que se instanciaran los objetos-clases Traits
class ElTrait
  attr_accessor :metodos

  def initialize
    @metodos = Hash.new
  end

  def agregar_metodo(nombre_metodo, &bloque)
    metodos[nombre_metodo] = bloque
  end
end

# La magia
class Trait

  @@trait_name = nil
  @@objTrait = nil

  def self.name(unNombre)
    @@trait_name = unNombre
    @@objTrait = ElTrait.new
  end

  def self.method(unNombre, &unBloque)
    @@objTrait.agregar_metodo(unNombre, &unBloque)
  end

  def self.define(&unBloque)
    instance_eval &unBloque
    definir_constante
  end

  def self.definir_constante()
    Object.const_set(@@trait_name, @@objTrait)
  end
end

# Agregar 'uses' a Object
class Object
  def uses(unTrait)
    unTrait.metodos.each do |unMetodo, unBloque|
      self.send(:define_method, unMetodo, unBloque)
    end
  end
end

# Definir el trait
Trait.define do
  name :Jose

  method :te_sumo_20 do |unNumerito|
    unNumerito + 20
  end

  method :te_resto_10 do |unNumerito|
    unNumerito - 10
  end
end

# Una clase que lo use
class UnTrait
  uses Jose
end

# Ejemplos de uso
objetito = UnTrait.new
puts objetito.te_resto_10(5)

otroObjetito = UnTrait.new
puts otroObjetito.te_sumo_20(1)