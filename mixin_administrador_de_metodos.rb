require './clase_estrategia'
module Administrador_de_metodos #Lo del mixin es porque pensé que lo iba a usar en open_class
                                #esto puede ir tranquilamente en la clase Trait

  attr_accessor :estrategia

  def initialize
    @estrategia = Estrategia.new
  end
  def dar_metodos
    self.singleton_methods(false)
  end

  def method(un_nombre,&un_bloque)
    self.define_singleton_method(un_nombre,&un_bloque)
    self.estrategia.set_estrategia_default(un_nombre)
    #De entrada se le agrega una estrategia al método por si llegara a ser conflictivo
  end

  def hay_metodos_en_comun(trait1,trait2)
    trait1.dar_metodos.select {|metodo| trait2.dar_metodos.include? metodo}
  end

  def agregar_metodos_nuevos(lista_de_nombres,otro_trait)
    lista_de_nombres.each do
    |nombre|
      metodo = otro_trait.singleton_method nombre
      self.method(nombre,&metodo)
      #Si el método es conflictivo, se trata después según la estrategia que tenga asignada
    end
  end

  def agregar_metodos_conflictivos(lista_de_nombres,otro_trait)
    lista_de_nombres.each do
    |nombre|
      self.estrategia.send nombre, nombre, self, otro_trait
    end
  end


  def agregar_metodos(otro_trait)
    metodos_conflictivos = hay_metodos_en_comun(self,otro_trait)
    nombres_metodos_nuevos = otro_trait.dar_metodos.delete_if {|metodo| metodos_conflictivos.include? metodo}
    agregar_metodos_nuevos(nombres_metodos_nuevos,otro_trait)
    agregar_metodos_conflictivos(metodos_conflictivos,otro_trait)
    self
  end

  def remover_metodo(nombre)
    self.singleton_class.send :remove_method, nombre
    self
  end

  def tengo_metodo?(un_metodo)
    self.singleton_methods.include? un_metodo
  end

  def crear_alias (lista_de_dos_nombres)
    nombre_metodo = lista_de_dos_nombres.at 0
    nombre_nuevo = lista_de_dos_nombres.at 1

    self.method(nombre_nuevo,&self.singleton_method(nombre_metodo))
  end


end