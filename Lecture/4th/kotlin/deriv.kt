import kotlin.math.sin

fun main(args: Array<String>) {
  println(derivative({x: Double -> sin(x)})(0.0))
}

fun derivative(f: (Double) -> Double): (Double) -> Double {
  val h: Double = 1e-06
  return {x: Double -> (f(x+h) - f(x)) / h}
}
