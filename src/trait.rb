require '../src/open_object'
require '../src/open_symbol'
require '../src/trait_object'
require '../src/ejecutar_ambos_metodos'
# La magia
class Trait

  @@trait_name = nil
  #@@resolucion_de_conflictos = EjecutarAmbosMetodos

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

  #def self.resolucion_conflictos_segun(metodo_de_resolucion)
  #  @@resolucion_de_conflictos = metodo_de_resolucion
  #end

  #def self.resolver_conflicto (metodo_old, metodo_new)
  #  @@resolucion_de_conflictos.resolver_conflicto(metodo_old, metodo_new)
  #end
end