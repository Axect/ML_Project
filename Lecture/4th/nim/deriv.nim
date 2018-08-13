import math
import future

proc derivative(f: float64 -> float64): auto =
  var h: float64 = 1e-06
  return proc(x: float64): float64 = (f(x+h) - f(x)) / h

var f = derivative(sin)
echo f(0)

