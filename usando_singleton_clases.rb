# Clase de la que se instanciaran los objetos-clases Traits
class Trait
  attr_accessor :metodos 
  @trait_name	#Cada instancia de trait tiene su nombre, pero no sé cómo especificar que no se puede modificar
		#por eso no lo considere un accessor (lo otro sería nunca jamás usar el getter)

  def initialize
    @metodos = Hash.new
  end

  def agregar_metodo(nombre_metodo, &bloque)
    metodos[nombre_metodo] = bloque
  end

  def remover_metodo(nombre_metodo)
    metodos.delete(nombre_metodo)
  end

  def unir_metodos(otro_hash)
    self.metodos.merge!(otro_hash) { |key, oldval, newval| raise 'duplicated_method'}
  end

  def tengo_metodo?(un_metodo)
    metodos.member?(un_metodo)
  end

  def bloque_metodo(un_metodo)
    metodos[un_metodo]
  end

  # Clona este objeto
  def clonar()
    objeto_clon = self.class.new
    objeto_clon.metodos = self.metodos.clone
    objeto_clon
  end

  # Agrega un metodo nuevo como alias de uno ya existente
  def crear_alias_metodo(metodo_old, metodo_new)
    agregar_metodo(metodo_new, &bloque_metodo(metodo_old))
  end

  # Restar metodo a Trait
  def -(un_metodo)

    # No existe metodo, raise exception
    if not(self.tengo_metodo?(un_metodo)) then
      raise "method_does_not_exists"
    end

    # Crea una copia de este Objeto, remueve el metodo indicado y devuelve el nuevo objeto
    objeto_clon = self.clonar
    objeto_clon.remover_metodo(un_metodo)
    objeto_clon
  end

  # Suma de Traits
  def +(un_trait)
    objeto_clon = self.clonar
    objeto_clon.unir_metodos(un_trait.metodos)
    objeto_clon
  end

  # Alias
  def <<(array_metodos)

    metodo_old = array_metodos.at(0)
    metodo_new = array_metodos.at(1)

    # No existe metodo old, raise exception
    if not(self.tengo_metodo?(metodo_old)) then
      raise "old_method_does_not_exists"
    end

    # Existe metodo new, raise exception
    if self.tengo_metodo?(metodo_new) then
      raise "new_method_alias_already_exists"
    end

    # Crea una copia de este Objeto, aliasea el metodo indicado y devuelve el nuevo objeto
    objeto_clon = self.clonar
    objeto_clon.crear_alias_metodo(metodo_old, metodo_new)
    objeto_clon
  end

#Uso self.nombre_del_metodo porque en este caso self es la clase (Trait) entonces, estaría definiendo los métodos en la singleton class de Trait (o lo que es lo mismo, son métodos de clase)
  def self.dar_nombre 
	@trait_name
  end

  def self.name(un_nombre)
    @trait_name = un_nombre
    self.definir_constante(@trait_name, Trait.new) # Ata el objeto al nombre del Trait
  end

  def self.method(un_nombre, &un_bloque)
    Object.const_get(@trait_name).agregar_metodo(un_nombre, &un_bloque)
  end

  def self.define(&un_bloque)
    self.instance_eval &un_bloque
  end

  def self.definir_constante(nombre, objeto)
    Object.const_set(nombre, objeto)
  end
end
