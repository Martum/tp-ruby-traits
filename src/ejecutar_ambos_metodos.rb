class EjecutarAmbosMetodos

  def self.union(otro_hash, objeto)
    objeto.metodos.merge!(otro_hash) { |key, oldval, newval| Proc.new { |*campos| oldval.call(*campos); newval.call(*campos)}}
  end

end