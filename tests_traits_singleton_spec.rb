require 'rspec'
require './tp_con_singleton_class'
require './open_symbol'

Trait.define do
  name 'Saludador'
  method 'decir_hola' do
    'Hola!'
  end
  method 'decir_chau' do
    'Chau!'
  end
  method 'decir_algo' do
    |mensaje|
    mensaje
  end
end

Trait.define do
  name 'Buda'
  method 'meditar' do
    'Om'
  end
end

Trait.define do
  name 'Charlatán'
  method 'decir_hola' do
    'Qué?'
  end
end


describe 'Manipulación de traits' do
require './open_class' #Si lo pongo arriba me da un error con la palabra 'describe' (WTF?)

  it 'Crear un trait y verificar su nombre' do
    Saludador.class.should == Trait
  end

  it 'Crear un trait y asignarle un método' do
      Saludador.decir_hola.should == 'Hola!'
    end

  it 'En todo trait con métodos hay singleton_methods' do
    Saludador.singleton_methods.should == [:decir_hola, :decir_chau, :decir_algo]
  end

  it 'Un trait puede agregar métodos de otro trait' do
    Nuevo_trait = Saludador + Buda
    Nuevo_trait.meditar.should == 'Om'
  end

  it 'Un trait agrega de otros traits y estos siguen teniendo sus métodos' do
    Nuevo_trait = Buda + Saludador
    Saludador.decir_algo('Bleh').should == 'Bleh'
  end

  it 'Un trait agrega de otros traits y los metodos que agrega son singleton_methods'do
    Nuevo_trait = Buda + Saludador
    Nuevo_trait.singleton_methods.should == [:meditar,:decir_hola,:decir_chau,:decir_algo]
  end

  it 'Un trait agrega de otros y luego se resta un meétodo (el método restado corresponde al último trait)' do
    Nuevo_trait = Buda + Saludador - :decir_chau
    Nuevo_trait.singleton_methods.should == [:meditar,:decir_hola, :decir_algo]
  end

  it 'Un trait agrega de otros y luego se resta un método (el método restado corresponde al primer trait)' do
    Nuevo_trait = Buda + Saludador - :meditar
    Nuevo_trait.singleton_methods.should == [:decir_hola, :decir_chau, :decir_algo]
  end

  it 'Un trait agrega de otros y resta varios métodos' do
    Nuevo_trait = Buda + Saludador - :decir_chau - :meditar -:decir_algo
    Nuevo_trait.singleton_methods.should == [:decir_hola]
  end

  it 'Una clase usa un trait' do
    class Sarlanga
      uses Buda
    end

    un_objeto = Sarlanga.new
    un_objeto.meditar.should == 'Om'
  end

  it 'Una clase usa un trait, los métodos de éste son métodos de instancia de la clase' do
    class Una_clase
      uses Saludador
    end

    Una_clase.instance_methods(false).should == [:decir_hola, :decir_chau, :decir_algo]
  end

  it 'Una clase con un método al agregar un trait con un método del mismo nombre no lo posee' do
    class Una_clase
      uses Saludador
      def decir_chau
        'Adiós'
      end
    end

    objeto = Una_clase.new
    objeto.decir_chau.should == 'Adiós'
  end

  it 'Usar una suma de traits en una clase' do
    class Una_clase
      uses Buda + Saludador
    end

    Una_clase.instance_methods(false).should =~ [:meditar, :decir_hola, :decir_chau, :decir_algo,]
    #El =~ es para que no tire que está mal por el orden de los métodos
  end

  it 'Se resta un método que no existe' do
    expect {Buda - :mensaje}.to raise_exception
  end

  it 'Usar una suma de traits con resta de métodos en una clase' do
    class Una_Clase
      uses Buda + Saludador - :decir_algo - :meditar
    end

    Una_Clase.instance_methods(false).should =~ [:decir_hola,:decir_chau]
  end

  it 'Usar un alias' do
    Otro_trait = Buda << (:meditar > :dormir)
    Buda.singleton_methods(false).should == [:meditar, :dormir]
  end

  it 'Usar alias de un método inexistente' do
    expect {Algun_trait = Buda (:mensaje > :mensajito)}.to raise_exception
  end

  it 'Usar un alias en una clase' do
    class Con_alias
      uses Saludador << (:decir_chau > :decir_adios)
    end

    objeto = Con_alias.new
    objeto.decir_adios.should == 'Chau!'
  end

  it 'Se suman dos traits con métodos conflictivos, se crean los métodos en su estrategia (con estrategia agreagar_ambos)' do
    Trait.define do
      name 'Uno'
      method 'algo'do
        #nada
      end
    end

    Trait.define do
      name 'Dos'
      method 'algo' do
        #Nada
      end
    end

    Otro_trait = Uno + Dos
    Otro_trait.estrategia.singleton_methods(false).should == [:algo, :algo_Dos]
  end

  it 'Se resuelve un conflicto con la estrategia default (agregar_ambos_metodos)' do
    Trait.define do
      name 'Calculador'
      method 'sumar_uno' do
        |numero|
        numero  + 1
      end
    end

    Trait.define do
      name 'Mentiroso'
      method 'sumar_uno' do
        |numero|
        numero + 2
      end
    end

    #¿Qué pasaría si tengo que ejecutar ambos métodos, pero en los traits tienen una aridad diferente?
    #Me parece que todavía no entiendo cómo se resuelve el conflicto con esta estrategia


    Otro_trait = Mentiroso + Calculador
    Otro_trait.sumar_uno(8).should == 9
    #Ejecuta los dos, pero como ambos son con el mismo parámetro, es como si el primero
    #no se hubiera ejecutado (se pisa con el resultado del segundo)
  end

end








