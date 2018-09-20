quicksort <- function(xs) {
  l <- length(xs)
  if (l == 0 || l == 1) {
    return(xs)
  }
  
  pivot <- xs[length(xs)/2]
  less <- c()
  more <- c()
  equal <- c()
  for (x in xs) {
    if (x < pivot) {
      less <- c(less,x)
    } else if (x > pivot) {
      more <- c(more,x)
    } else {
      equal <- c(equal,x)
    }
  }
  return(c(quicksort(less), equal, quicksort(more)))
}
