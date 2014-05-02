class Estrategia
  def crear_nombre_por_conflicto(nombre_metodo,trait)
    "#{nombre_metodo}_#{trait.nombre}"
  end

  def estrategia_ejecutar_ambos_metodos
    lambda do
    |nombre_metodo, trait_a_entregar, otro_trait|
      nombre_por_conflicto = crear_nombre_por_conflicto(nombre_metodo,otro_trait)
      trait_a_entregar.send :method, nombre_por_conflicto, &otro_trait.singleton_method(nombre_metodo)
      metodo_actual = trait_a_entregar.singleton_method(nombre_metodo)
      trait_a_entregar.method nombre_metodo do
        |*argumentos|
        trait_a_entregar.instance_exec(*argumentos, &metodo_actual)
        trait_a_entregar.instance_exec(*argumentos, &self.singleton_method(nombre_por_conflicto))
      end
    end
  end

  def estrategia_aplicar_funcion
    #No sé cómo hacer para pasarle la función por parámetro a este método
    #(desde el mixin se llama con tres parámetros fijos)
  end

  def set_estrategia(un_metodo,&estrategia)
    self.define_singleton_method un_metodo,&estrategia
    #Cada estrategia es un método nuevo en esta clase y hay uno para cada método del trait a usar
  end

  def set_estrategia_default(un_metodo)
    self.set_estrategia(un_metodo,&estrategia_ejecutar_ambos_metodos)
  end

end