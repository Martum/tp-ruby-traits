require 'rspec'

describe 'Prueba de splats' do
  it 'probar pasarle argumentos a un bloque con un splat' do
    un_bloque = lambda { |uno, dos, tres| puts "#{uno} + #{dos} + #{tres}" }
    otro_bloque = lambda { |uno, dos, tres| puts "#{uno} * #{dos} * #{tres}" }

    tercer_bloque = lambda { |*campos|
      un_bloque.call(*campos)
      otro_bloque.call(*campos)
    }

    tercer_bloque.call(5,3,2)

    suma_bloque = lambda { |primero, segundo| primero + segundo }
    multiplica_bloque = lambda { |primero, segundo| primero * segundo }

    opera_con_bloques = lambda { |unNumero, otroNumero|
      multiplica_bloque.call(suma_bloque.call(unNumero, otroNumero), otroNumero)
    }

    opera_con_bloques.call(2,3).should == 15

  end
end