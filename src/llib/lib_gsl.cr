@[Link("gsl")]
@[Link("openblas")]
lib LibGsl
  alias Integer = LibC::Int
  alias Real = LibC::Float
  alias Double = LibC::Double
  alias Logical = LibC::Char
  alias Ftnlen = LibC::Int
  alias LFp = Pointer(Void)
  alias UInt = LibC::SizeT

  struct GslBlock
    size : UInt*
    data : Double*
  end

  struct GslVector
    size : UInt
    stride : UInt
    data : Double*
    block : GslBlock*
    owner : Integer
  end

  struct GslVectorView
    vector : GslVector
  end

  struct GslMatrix
    size1 : UInt
    size2 : UInt
    tda : UInt
    data : Double*
    block : GslBlock*
    owner: Integer
  end

  struct GslMatrixView
    matrix : GslMatrix
  end

  # Block allocation
  fun gsl_block_alloc(n : UInt) : GslBlock
  fun gsl_block_calloc(n : UInt) : GslBlock
  fun gsl_block_free(b : GslBlock)

  # Vector allocation
  fun gsl_vector_alloc(n : UInt) : GslVector*
  fun gsl_vector_calloc(n : UInt) : GslVector*
  fun gsl_vector_free(b : GslVector*)

  # Vector getters/setters
  fun gsl_vector_get(v : GslVector*, i : UInt) : Double
  fun gsl_vector_set(v : GslVector*, i : UInt, x : Double)
  fun gsl_vector_set_all(v : GslVector*, x: Double)
  fun gsl_vector_set_zero(v : GslVector*)
  fun gsl_vector_set_basis(v : GslVector*, i : UInt)

  # Vector views
  fun gsl_vector_subvector(v : GslVector*, offset : UInt, n : UInt) : GslVectorView
  fun gsl_vector_subvector_with_stride(v : GslVector*, offset : UInt, stride : UInt, n : UInt) : GslVectorView
  fun gsl_vector_view_array(base : Double*, n : UInt) : GslVectorView
  fun gsl_vector_view_array_with_stride(base : Double*, stride : UInt, n : UInt)

  # Vector manipulations
  fun gsl_vector_memcpy(dest : GslVector*, src : GslVector*) : Integer
  fun gsl_vector_swap_elements(v : GslVector*, i : UInt, j : UInt) : Integer
  fun gsl_vector_reverse(v : GslVector*) : Integer

  # Vector math
  fun gsl_vector_add(a : GslVector*, b : GslVector*) : Integer
  fun gsl_vector_sub(a : GslVector*, b : GslVector*) : Integer
  fun gsl_vector_mul(a : GslVector*, b : GslVector*) : Integer
  fun gsl_vector_div(a : GslVector*, b : GslVector*) : Integer
  fun gsl_vector_scale(a : GslVector*, x : Double) : Integer
  fun gsl_vector_add_constant(a : GslVector*, x : Double)
  fun gsl_vector_axpby(alpha : Double, x : GslVector*, beta : Double, y : GslVector*)

  # Vector max/min
  fun gsl_vector_max(v : GslVector*) : Double
  fun gsl_vector_min(v : GslVector*) : Double
  fun gsl_vector_minmax(v : GslVector*, min_out : Double*, max_out : Double*)
  fun gsl_vector_max_index(v : GslVector*) : UInt
  fun gsl_vector_min_index(v : GslVector*) : UInt
  fun gsl_vector_minmax_index(v : GslVector*, imin : UInt*, imax : UInt*)

  # properties
  fun gsl_vector_isnull(v : GslVector*) : Integer
  fun gsl_vector_ispos(v : GslVector*) : Integer
  fun gsl_vector_isneg(v : GslVector*) : Integer
  fun gsl_vector_isnonneg(v : GslVector*) : Integer
  fun gsl_vector_equal(u : GslVector*, v : GslVector*) : Integer

  # matrix allocation
  fun gsl_matrix_alloc(n1 : UInt, n2 : UInt) : GslMatrix*
  fun gsl_matrix_allow(n1 : UInt, n2 : UInt) : GslMatrix*
  fun gsl_matrix_free(m : GslMatrix*)

  # matrix getters/setters
  fun gsl_matrix_get(m : GslMatrix*, i : UInt, j : UInt) : Double
  fun gsl_matrix_set(m : GslMatrix*, i : UInt, j : UInt)
  fun gsl_matrix_set_all(m : GslMatrix*, x : Double)
  fun gsl_matrix_set_zero(m : GslMatrix*)
  fun gsl_matrix_set_identify(m : GslMatrix*)
  fun gsl_matrix_get_row(v : GslVector*, m : GslMatrix*, i : UInt) : Integer
  fun gsl_matrix_get_col(v : GslVector*, m : GslMatrix*, i : UInt) : Integer
  fun gsl_matrix_set_row(m : GslMatrix*, i : UInt, v : GslVector*) : Integer
  fun gsl_matrix_set_col(m : GslMatrix*, i : UInt, v : GslVector*) : Integer

  # matrix views
  fun gsl_matrix_submatrix(m : GslMatrix*, k1 : UInt, k2 : UInt, n1 : UInt, n2: UInt) : GslMatrixView
  fun gsl_matrix_row(m : GslMatrix*, i : UInt) : GslVectorView
  fun gsl_matrix_column(m : GslMatrix*, j : UInt) : GslVectorView
  fun gsl_matrix_subrow(m : GslMatrix*, j : UInt) : GslVectorView
  fun gsl_matrix_subcolumn(m : GslMatrix*, j : UInt) : GslVectorView
  fun gsl_matrix_diagonal(m : GslMatrix*) : GslVectorView
  fun gsl_matrix_subdiagonal(m : GslMatrix*, k : UInt) : GslVectorView
  fun gsl_matrix_superdiagonal(m : GslMatrix*, k : UInt)

  # matrix mutations
  fun gsl_matrix_swap_rows(m : GslMatrix*, i : UInt, j : UInt) : Integer
  fun gsl_matrix_swap_columns(m : GslMatrix*, i : UInt, j : UInt) : Integer
  fun gsl_matrix_swap_rowcol(m : GslMatrix*, i : UInt, j : UInt) : Integer
  fun gsl_matrix_transpose_memcpy(dest : GslMatrix*, src : GslMatrix*) : Integer
  fun gsl_matrix_transpose(m : GslMatrix*) : Integer

  # arithmetic
  fun gsl_matrix_add(a : GslMatrix*, b : GslMatrix*) : Integer
  fun gsl_matrix_sub(a : GslMatrix*, b : GslMatrix*)
  fun gsl_matrix_mul_elements(a : GslMatrix*, b : GslMatrix*) : Integer
  fun gsl_matrix_div_elements(a : GslMatrix*, b : GslMatrix*) : Integer
  fun gsl_matrix_scale(a : GslMatrix*, x : Double) : Integer
  fun gsl_matrix_add_constant(a : GslMatrix*, x : Double)

  # matrix properties
  fun gsl_matrix_max(m : GslMatrix*) : Double
  fun gsl_matrix_min(m : GslMatrix*) : Double
  fun gsl_matrix_minmax(m : GslMatrix*, min_out : Double*, max_out : Double*)
  fun gsl_matrix_max_index(m : GslMatrix*, imax : UInt, jmax : UInt)
  fun gsl_matrix_min_index(m : GslMatrix*, imin: UInt, jmin : UInt)
  fun gsl_matrix_minmax_index(m : GslMatrix*, imin : UInt, jmin : UInt, imax : UInt, jmax : UInt)

  # null checks
  fun gsl_matrix_isnull(m : GslMatrix*) : Integer
  fun gsl_matrix_ispos(m : GslMatrix*) : Integer
  fun gsl_matrix_isneg(m : GslMatrix*) : Integer
  fun gsl_matrix_isnonneg(m : GslMatrix*) : Integer

end
