class PrimerVerdaderoResolucion

  attr_accessor :funcion_resuelve

  def initialize(funcion_res)
    @funcion_resuelve = funcion_res
  end

  def resolver_conflicto(method_name, old_method, new_method)
    funcion = funcion_resuelve
    lambda { |*campos|

      res1 = self.instance_exec(*campos, &old_method)
      res2 = self.instance_exec(*campos, &new_method)

      if (funcion.call(res1))
        res1
      elsif (funcion.call(res2))
        res2
      else
        raise 'ninguno coincide'
      end

    }
  end
end