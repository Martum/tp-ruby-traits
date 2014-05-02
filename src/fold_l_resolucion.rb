class FoldLResolucion
  attr_accessor :funcion_resuelve

  def initialize(funcion_res)
    funcion_resuelve = funcion_res
  end

  def resolver_conflicto(method_name, old_method, new_method)
    Proc.new do |*campos|
      res1 = self.instance_exec(*campos, &old_method)
      res2 = self.instance_exec(*campos, &new_method)

      self.instance_exec(res1, res2, &funcion_resuelve)
    end
  end

end