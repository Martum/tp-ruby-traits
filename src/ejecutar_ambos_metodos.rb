class EjecutarAmbosMetodos

  def self.resolver_conflicto(old_method, new_method)
    Proc.new { |*campos| old_method.call(*campos); new_method.call(*campos)}
  end

end