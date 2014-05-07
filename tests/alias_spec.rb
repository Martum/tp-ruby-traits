require 'rspec'
require '../src/trait'

Trait.define do
  name :OperacionesMatematicas

  method :te_sumo_20 do |unNumerito|
    unNumerito + 20
  end

  method :te_resto_10 do |unNumerito|
    unNumerito - 10
  end
end

describe 'Prueba alias de metodos' do

  it 'alias a un metodo existente por uno inexistente' do
    class Matematica
      uses OperacionesMatematicas << (:te_sumo_20 > :te_agrego_20)
    end

    objetoMatematica = Matematica.new

    objetoMatematica.te_sumo_20(2).should be 22
    objetoMatematica.te_agrego_20(3).should be 23
  end

  it 'alias a un metodo inexistente por uno inexistente' do
    expect {
      class Matematica2
        uses OperacionesMatematicas << (:te_sumo_300 > :te_agrego_20)
      end
    }.to raise_exception(NoMethodError)
  end

  it 'alias de un metodo existente por uno existente' do
    expect {
      class Matematica3
        uses OperacionesMatematicas << (:te_sumo_20 > :te_resto_10)
      end
    }.to raise_error(MethodAlreadyExistsError)
  end
end