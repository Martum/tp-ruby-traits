require 'rspec'
require '../src/trait'
require '../src/resoluciones/ejecutar_ambos_metodos_resolucion'
require '../src/resoluciones/fold_l_resolucion'
require '../src/resoluciones/primer_verdadero_resolucion'


Trait.define do
  name :Trait1

  # Suma 100
  method :agrego_100 do |un_valor|
    un_valor + 100
  end

  # Suma 10
  method :sumo_10 do |un_valor|
    un_valor + 10
  end

  method :ya_existo do |un_valor|
    false
  end

  method :duplicado_excepcion do
    true
  end

  method :no_existo do
    true
  end
end

Trait.define do
  name :Trait2

  # Suma 50
  method :agrego_100 do |un_valor|
    un_valor + 50
  end

  # Suma 10
  method :sumo_10 do |un_valor|
    un_valor + 10
  end

  method :duplicado_excepcion do
    false
  end

  method :aliaseame do
    true
  end
end

class Integradora
  uses (Trait1 - :no_existo) + (
    (Trait2 < {
        :agrego_100 => PrimerVerdaderoResolucion.new(lambda {|un_valor| un_valor > 100}),
        :sumo_10 => FoldLResolucion.new(lambda{|uno, dos| uno + dos})
      }) << (:aliaseame > :te_aliase))

  def ya_existo(algo)
    true
  end
end

integrador_obj = Integradora.new

describe 'Test integrador' do

  it 'al invocar agrego_100 deberia sumar 100 (por PrimerVerdaderoResolucion)' do
    integrador_obj.agrego_100(10).should == 110
  end

  it "al invocar sumo_10 se deberia sumar 20 + valor * 2 (por FoldL)" do
    integrador_obj.sumo_10(5).should == 30
  end

  it "al invocar duplicado_excepcion se deberia ejecutar la resolucion por default (excepcion)" do
    expect {
      integrador_obj.duplicado_excepcion
    }.to raise_error(RuntimeError)
  end

  it "al invocar un metodo inexistente, deberia fallar con excepcion" do
    expect {
      integrador_obj.no_existo
    }.to raise_error(NoMethodError)
  end

  it "al invocar un metodo aliaseado, este deberia seguir existiendo" do
    integrador_obj.aliaseame.should == true
  end

  it "al invocar un metodo alias, este deberia existir" do
    integrador_obj.te_aliase.should == true
  end

end