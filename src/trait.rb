require '../src/open_object'
require '../src/open_symbol'
require '../src/trait_object'
require_relative 'excepciones/method_already_exists_error'
require '../src/resoluciones/arrojar_excepcion_resolucion'
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

  def self.resolver_conflicto_default(nombre_metodo, old_metodo, new_metodo)
    resolvedor = ArrojarExcepcionResolucion.new
    resolvedor.resolver_conflicto(nombre_metodo, old_metodo, new_metodo)
  end
end