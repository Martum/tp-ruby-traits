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

describe 'Rsta de metodos' do

  it 'resta cuando el metodo fue removido' do

    class Matematica4
      uses (OperacionesMatematicas - :te_sumo_20)
    end

    otroObjetito = Matematica4.new

    expect {otroObjetito.te_sumo_20(1)}.to raise_error
  end
end