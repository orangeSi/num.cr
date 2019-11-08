require "../core/ndtensor"
require "./fixed_dimension"
require "../util/exceptions"

module Bottle::Internal::LinAlg
  macro matrix_reduction_retain_size(operation)
    def {{operation}}(t : Tensor)
      if t.ndims < 2
        raise Exceptions::ShapeError.new("Tensor must be at least 2D")
      end

      if t.ndims == 2
        return {{operation}}_helper(t)
      end

      t = t.dup
      t.matrix_iter.each do |m|
        m[...] = {{operation}}_helper(m)
      end
      t
    end
  end

  matrix_reduction_retain_size(inv)

  def dot(a : Tensor(U), b : Tensor(U)) forall U
    if a.ndims == 2 && b.ndims == 2
      matmul(a, b)
    elsif a.ndims == 2 && b.ndims > 2
      m = Tensor(U).new(b.shape[...-2] + [a.shape[0], b.shape[-1]])
      m.matrix_iter.zip(b.matrix_iter) do |dest, src|
        matmul(a, src, dest: dest)
      end
      m
    elsif a.ndims > 2 && b.ndims == 2
      m = Tensor(U).new(a.shape[...-2] + [a.shape[-2], b.shape[-1]])
      m.matrix_iter.zip(a.matrix_iter) do |dest, src|
        matmul(src, b, dest: dest)
      end
      m
    elsif a.ndims > 2 && b.ndims > 2
      newshape = a.shape[...-2]
      if newshape != b.shape[...-2]
        raise Exceptions::ShapeError.new("Matrices cannot be multiplied")
      end
      m = Tensor(U).new(newshape + [a.shape[-2], b.shape[-1]])
      m.matrix_iter.zip(a.matrix_iter, b.matrix_iter) do |dest, am, bm|
        matmul(am, bm, dest: dest)
      end
      m
    else
      raise Exceptions::ValueError.new("Unsupported matrix operation")
    end
  end
end