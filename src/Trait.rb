class Trait
  def self.name(unNombre)
    puts "El nombre del Trait es: #{unNombre}"
  end

  def self.method(unNombre, &unBloque)
    puts "Un metodo es: #{unNombre}"
  end

  def self.define(&unBloque)
    instance_eval &unBloque
  end
end

Trait.define do
  name :jose

  method :te_sumo_20 do |unNumerito|
    unNumerito + 20
  end

  method :te_resto_10 do |unNumerito|
    unNumerito - 10
  end
end