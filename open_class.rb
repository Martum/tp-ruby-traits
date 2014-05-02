class Class #class Saraza uses Trait => el receptor del mensaje uses es una clase

  def tengo_metodo?(un_metodo)
    self.methods.include?(un_metodo)
    #La reescribo porque en el caso de las clases, los métodos son de instancia, no singleton_methods
  end

  def uses(un_trait)
    un_trait.dar_metodos.each do
      |nombre_de_metodo|
      self.instance_eval do
        self.send :define_method, nombre_de_metodo, &un_trait.singleton_method(nombre_de_metodo) unless self.tengo_metodo? nombre_de_metodo
        #Si la clase ya tiene el método, tiene prioridad por sobre la del trait
      end
    end
  end

end
