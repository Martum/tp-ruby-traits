# Clase de la que se instanciaran los objetos-clases Traits
class TraitObject
  attr_accessor :metodos

  def initialize
    @metodos = Hash.new
  end

  def agregar_metodo(nombre_metodo, &bloque)
    metodos[nombre_metodo] = bloque
  end

  def remover_metodo(nombre_metodo)
    metodos.delete(nombre_metodo)
  end

  # Clona este objeto
  def clonar()
    objeto_clon = TraitObject.new
    objeto_clon.metodos = self.metodos.clone
    objeto_clon
  end

  def -(un_metodo)

    # No existe metodo, raise exception
    if not (metodos.member?(un_metodo)) then
      raise "method_does_not_exists"
    end

    # Crea una copia de este Objeto, remueve el metodo indicado y devuelve el nuevo objeto
    objeto_clon = self.clonar
    objeto_clon.remover_metodo(un_metodo)

    objeto_clon
  end
end

# La magia
class Trait

  @@trait_name = nil

  def self.name(un_nombre)
    @@trait_name = un_nombre
    definir_constante(@@trait_name, TraitObject.new) # Ata el objeto al nombre del Trait
  end

  def self.method(un_nombre, &un_bloque)
    Object.const_get(@@trait_name).agregar_metodo(un_nombre, &un_bloque)
  end

  def self.define(&un_bloque)
    instance_eval &un_bloque
  end

  def self.definir_constante(nombre, objeto)
    Object.const_set(nombre, objeto)
  end
end

# Agregar 'uses' a Object
class Object
  def uses(un_trait)
    un_trait.metodos.each do |un_metodo, un_bloque|
      self.send(:define_method, un_metodo, un_bloque)
    end
  end
end

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
puts objetito.te_resto_10(6)

otroObjetito = Matematica.new
puts otroObjetito.te_sumo_20(1)

otroObjetito3 = Matematica2.new
puts otroObjetito3.te_sumo_20(1)