# Agregar 'uses' a Object
class Object
  def uses(un_trait)
    un_trait.metodos.each do |un_metodo, un_bloque|
      self.send(:define_method, un_metodo, un_bloque)
    end
  end
end