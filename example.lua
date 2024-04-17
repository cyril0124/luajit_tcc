local ffi = require "ffi"
local tcc = require("tcc").load()

local state = tcc.new()
assert(state:set_output_type(tcc.OUTPUT.MEMORY))

assert(state:compile_string([[
  void matrix_mul(float* A, float* B, float* C, int M, int N, int K) {
    for (int i = 0; i < M; i++) {
      for (int j = 0; j < K; j++) {
          C[i * K + j] = 0;
          for (int k = 0; k < N; k++) {
              C[i * K + j] += A[i * N + k] * B[k * K + j];
          }
      }
    }
  }
]]))

assert(state:relocate(tcc.RELOCATE.AUTO))

local matrix_mul_sym = assert(state:get_symbol("matrix_mul"))
local matrix_mul = ffi.cast("void (*)(float *, float *, float *, int, int, int)", matrix_mul_sym)


local M, N, K = 10, 6, 4

local A = ffi.new("float[?]", M * N)
local B = ffi.new("float[?]", N * K)
local C = ffi.new("float[?]", M * K)

for i = 0, (M * N) - 1 do
    A[i] = math.random(1, 1000)
end

for i = 0, (N * K) - 1 do
    B[i] = math.random(1, 1000)
end

matrix_mul(A, B, C, M, N, K)

for i = 0, M-1 do
    for j = 0, K-1 do
        io.write(string.format("%8.1f\t", C[i * K + j]))
    end
    io.write("\n")
end
