class ArrojarExcepcionResolucion

  def resolver_conflicto(method_name, old_method, new_method)
    Proc.new do |*campos|
      raise "Conflicto con el metodo #{method_name}"
    end
  end

end