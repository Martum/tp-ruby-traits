class Trait
  def self.name(unNombre)
    puts "El nombre es"
    puts unNombre
  end

  def self.method(unNombre, unBloque)
    puts unNombre
  end

  def self.define(&unBloque)
    instance_eval &unBloque
  end
end

Trait.define do
  name :jose
end