class EjecutarAmbosMetodosResolucion

  def resolver_conflicto(method_name, old_method, new_method)
    Proc.new do |*campos|
      self.instance_exec(*campos, &old_method)
      self.instance_exec(*campos, &new_method)
    end
  end

end