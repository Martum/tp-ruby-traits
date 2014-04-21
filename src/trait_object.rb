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

  def unir_tabla_de_metodos(una_tabla_de_metodos, otra_tabla_de_metodos)
    una_tabla_de_metodos.merge(otra_tabla_de_metodos) { |key, oldval, newval| raise 'duplicated_method'}
  end

  # Clona este objeto
  def clonar()
    objeto_clon = self.class.new
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

  def +(un_trait)
    objeto_clon = self.clonar
    objeto_clon.metodos = self.unir_tabla_de_metodos(objeto_clon.metodos, un_trait.metodos)
    objeto_clon
  end
end