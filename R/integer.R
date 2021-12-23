integer_ <- function() {
  integer_bounded(
    max_negative_integer(),
    max_positive_integer()
  )
}


integer_bounded <- function(left, right) {
  integers <-
    hedgehog::gen.element(left:right)

  as_generator(
    \()
      if (left <= 0L && right >= 0L)
        hedgehog::gen.choice(
          0L,
          integers,
          prob = c(0.1, 0.9)
        )

      else
        integers
  )
}


integer_left_bounded <- function(left) {
  integer_bounded(left, max_positive_integer())
}


integer_right_bounded <- function(right) {
  integer_bounded(max_negative_integer(), right)
}


integer_positive <- function() {
  integer_left_bounded(1L)
}


integer_negative <- function() {
  integer_right_bounded(-1L)
}


max_positive_integer <- function() {
  .Machine$integer.max
}


max_negative_integer <- function() {
  -max_positive_integer()
}
