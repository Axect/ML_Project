import sequtils, future, math, strformat

proc mean[T](vec: seq[T]): float64 =
  result = float64(vec.sum) / float64(vec.len)
  
proc variance[T](vec: seq[T]): float64 =
  let l = float64(vec.len)
  let m = vec.mean
  result = vec.map(x => (x.float64 - m)^2 / (l - 1)).sum

proc std[T](vec: seq[T]): float64 =
  vec.variance.sqrt

proc main =
  let a = toSeq 1..10000000
  echo &"Mean: {a.mean}"
  echo &"Var: {a.variance}"
  echo &"Std: {a.std}"

if isMainModule:
  main()
