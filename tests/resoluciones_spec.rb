require 'rspec'
require '../src/trait'

Trait.define do
  name :Primero

  method :duplicated do
    puts 'hola'
  end
end

Trait.define do
  name :Segundo

  method :duplicated do
    puts 'santi'
  end
end

describe 'Prueba de resoluciones' do

  it 'deberia resolver el conflicto de metodos duplicados con la resolucion que se pasa por parametro' do

    class MiClase
      resoluciones (:duplicated, :ejecutar_todos)
      uses Primero + Segundo
    end

    instancia = MiClase.new

    instancia.duplicated #deberia imprimir 'hola'\n''santi'
  end
end