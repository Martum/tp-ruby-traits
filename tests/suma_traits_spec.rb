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

Trait.define do
  name :AlgunasOperacionesMatematicas

  method :te_sumo_30 do |unNumerito|
    unNumerito + 30
  end

end

Trait.define do
  name :PrimerTrait

  method :duplicated do |unArgumento|
    unArgumento + 20
  end
end

Trait.define do
  name :SegundoTrait

  method :duplicated do |unArgumento|
    unArgumento + 30
  end
end

describe 'Prueba suma tratis' do

  it 'sumar traits y poder usar los metodos de ambos' do

    class SuperClaseMagica
      uses OperacionesMatematicas + AlgunasOperacionesMatematicas
    end

    unaCosa = SuperClaseMagica.new

    unaCosa.te_sumo_20(10).should == 30
    unaCosa.te_sumo_30(20).should == 50
    unaCosa.te_resto_10(100).should == 90
  end
end