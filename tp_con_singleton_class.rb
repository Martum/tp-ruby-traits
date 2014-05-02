require './mixin_administrador_de_metodos'

class Trait
  include Administrador_de_metodos
  attr_accessor :nombre

  def self.define(&un_bloque)
    nuevo_trait = Trait.new
    nuevo_trait.instance_eval &un_bloque
    nuevo_trait
  end

  def name(nombre)
    Object.const_set(nombre,self)
    @nombre = nombre
  end

  def +(otro_trait)
    clon = self.clonarse
    clon.agregar_metodos(otro_trait)
    clon
  end

  def -(un_metodo)
    raise "No existe el método a remover" unless self.tengo_metodo? un_metodo
    clon = self.clonarse
    clon.remover_metodo(un_metodo)
    clon
  end

  def clonarse
    yo = self
    nombre = self.nombre
    Trait.define {agregar_metodos(yo)}
  end

  def <<(una_lista)
    raise "Un método ya tien ese nombre" if self.tengo_metodo? una_lista.at 1
    raise "No existe el método al cual hacer el alias" unless self.tengo_metodo? una_lista.at 0
    self.crear_alias(una_lista)

    clon = self.clonarse
    clon.crear_alias(una_lista)
    clon
  end


end

