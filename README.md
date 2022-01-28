
<!-- README.md is generated from README.Rmd. Please edit that file -->

# quickcheck <img src="man/figures/hex.png" align="right" style="width: 20%;"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/quickcheck)](https://CRAN.R-project.org/package=quickcheck)
[![R-CMD-check](https://github.com/armcn/quickcheck/workflows/R-CMD-check/badge.svg)](https://github.com/armcn/quickcheck/actions)
[![Codecov test
coverage](https://codecov.io/gh/armcn/quickcheck/branch/main/graph/badge.svg)](https://app.codecov.io/gh/armcn/quickcheck?branch=main)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/quickcheck)](https://cran.r-project.org/package=quickcheck)
<!-- badges: end -->

# Overview

Property based testing in R, inspired by
[QuickCheck](https://en.wikipedia.org/wiki/QuickCheck). This package
builds on the property based testing framework provided by
[`hedgehog`](https://github.com/hedgehogqa/r-hedgehog) and is designed
to seamlessly integrate with [`testthat`](https://testthat.r-lib.org).

## Installation

You can install the released version of `quickcheck` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("quickcheck")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("armcn/quickcheck")
```

# Usage

The following example uses `quickcheck` to test the properties of the
base R `+` function.
[Here](https://fsharpforfunandprofit.com/posts/property-based-testing/)
is an introduction to the concept of property based testing, and an
explanation of the mathematical properties of addition can be found
[here](https://www.khanacademy.org/math/cc-sixth-grade-math/cc-6th-factors-and-multiples/properties-of-numbers/a/properties-of-addition).

``` r
library(testthat)
library(quickcheck)

test_that("0 is the additive identity of +", {
  for_all(
    a = numeric_(len = 1),
    property = \(a) expect_equal(a, a + 0)
  )          
})
#> Test passed 😸

test_that("+ is commutative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    property = \(a, b) expect_equal(a + b, b + a)
  )          
})
#> Test passed 🎉

test_that("+ is associative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    c = numeric_(len = 1),
    property = \(a, b, c) expect_equal(a + (b + c), (a + b) + c)
  )          
})
#> Test passed 🥇
```

Here we test the properties of the
[`distinct`](https://dplyr.tidyverse.org/reference/distinct.html)
function from the [`dplyr`](https://dplyr.tidyverse.org/index.html)
package.

``` r
library(dplyr, warn.conflicts = FALSE)

test_that("distinct does nothing with a single row", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      distinct(a) |> expect_equal(a)
    }
  )
})
#> Test passed 🌈

test_that("distinct returns single row if rows are repeated", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      bind_rows(a, a) |> distinct() |> expect_equal(a)
    }
  )
})
#> Test passed 🌈

test_that("distinct does nothing if rows are unique", {
  for_all(
    a = tibble_of(integer_positive(), rows = 1L, cols = 1L),
    b = tibble_of(integer_negative(), rows = 1L, cols = 1L),
    property = \(a, b) {
      unique_rows <- bind_rows(a, b)
      distinct(unique_rows) |> expect_equal(unique_rows)
    }
  )
})
#> Test passed 🌈
```

## Quickcheck generators

Many generators are provided with `quickcheck`. Here are a few examples.

### Atomic vectors

``` r
integer_(len = 10) |> show_example()
#>  [1]  8722  6884  2096  6432  3872 -5283  5612  -637 -1923  1824
character_alphanumeric(len = 10) |> show_example()
#>  [1] "nOOBCzCY"  "tH86rFU"   "QptKXwpy"  "4De"       "ang"       "7uXS6S"   
#>  [7] "sPUFUE72x" "TUBgb"     "Fvs53"     "ugkNWhO5n"
posixct_(len = 10, frac_na = 0.5) |> show_example() 
#>  [1] NA                        "2004-08-13 16:07:23 PDT"
#>  [3] "2003-04-30 03:13:39 PDT" NA                       
#>  [5] NA                        "0883-05-14 00:01:26 LMT"
#>  [7] NA                        "1824-10-27 07:03:52 LMT"
#>  [9] "2351-11-24 16:21:14 PST" NA
```

### Lists

``` r
list_(a = constant(NULL), b = any_undefined()) |> show_example()
#> $a
#> NULL
#> 
#> $b
#> [1] NA
flat_list_of(logical_(), len = 3) |> show_example()
#> [[1]]
#> [1] FALSE
#> 
#> [[2]]
#> [1] TRUE
#> 
#> [[3]]
#> [1] FALSE
```

### Tibbles

``` r
tibble_(a = date_(), b = hms_(), rows = 5) |> show_example()
#> # A tibble: 5 x 2
#>   a          b              
#>   <date>     <time>         
#> 1 1233-03-31 20:39:07.672605
#> 2 1699-04-21 09:46:37.638352
#> 3 1018-10-18 21:46:13.348493
#> 4 2747-05-04 17:12:19.959295
#> 5 2562-03-07 13:13:42.824348
tibble_of(double_bounded(-10, 10), rows = 3, cols = 3) |> show_example()
#> # A tibble: 3 x 3
#>    ...1   ...2  ...3
#>   <dbl>  <dbl> <dbl>
#> 1 -9.27 -2.14   6.69
#> 2  1.63 -1.02  -6.41
#> 3  5.00 -0.108  9.52
any_tibble(rows = 3, cols = 3) |> show_example()
#> # A tibble: 3 x 3
#>   ...1             ...2       ...3      
#>   <list>           <list>     <list>    
#> 1 <named list [2]> <time [1]> <dttm [1]>
#> 2 <named list [2]> <dbl [1]>  <fct [1]> 
#> 3 <named list [2]> <int [1]>  <chr [1]>
```

## Hedgehog generators

`quickcheck` is meant to work with `hedgehog`, not replace it.
`hedgehog` generators can be used by wrapping them in `from_hedgehog`.

``` r
library(hedgehog)

is_even <- 
  \(a) a %% 2 == 0

gen_powers_of_two <- 
  gen.element(1:10) |> gen.with(\(a) 2 ^ a)

test_that("is_even returns TRUE for powers of two", {
  for_all(
    a = from_hedgehog(gen_powers_of_two),
    property = \(a) is_even(a) |> expect_true()
  )
})
#> Test passed 🎊
```

Any `hedgehog` generator can be used with `quickcheck` but they can’t be
composed together to build another generator. For example this will
work:

``` r
test_that("powers of two and integers are both numeric values", {
  for_all(
    a = from_hedgehog(gen_powers_of_two),
    b = integer_(),
    property = \(a, b) c(a, b) |> is.numeric() |> expect_true()
  )
})
#> Test passed 🎉
```

But this will cause an error:

``` r
test_that("composing hedgehog with quickcheck generators fails", {
  tibble_of(from_hedgehog(gen_powers_of_two)) |> expect_error()
})
#> Test passed 😀
```

A `quickcheck` generator can also be converted to a `hedgehog` generator
which can then be used with other `hedgehog` functions.

``` r
gen_powers_of_two <- 
  integer_bounded(1L, 10L, len = 1L) |> 
    as_hedgehog() |> 
    gen.with(\(a) 2 ^ a)


test_that("is_even returns TRUE for powers of two", {
  for_all(
    a = from_hedgehog(gen_powers_of_two),
    property = \(a) is_even(a) |> expect_true()
  )
})
#> Test passed 🎊
```

## Fuzz tests

Fuzz testing is a special case of property based testing in which the
only property being testing is that the code doesn’t fail with a range
of inputs. Here is an example of how to do fuzz testing with
`quickcheck`. Let’s say we want to test that the `purrr::map` function
won’t fail with any vector as input.

``` r
test_that("map won't fail with any vector as input", {
  for_all(
    a = any_vector(),
    property = \(a) purrr::map(a, identity) |> expect_silent()
  )
})
#> Test passed 🎊
```

## Repeat tests

Repeat tests can be used to repeatedly test that a property holds true
for many calls of a function. These are different from regular property
based tests because they don’t require generators. The function
`repeat_test` will call a function many times to ensure the expectation
passes in all cases. This kind of test can be useful for testing
functions with randomness.

``` r
test_that("runif generates random numbers between a min and max value", {
  repeat_test(
    property = \() {
      random_number <- runif(1, min = 0, max = 10)
      expect_true(random_number >= 0 && random_number <= 10)
    }
  )
})
#> Test passed 🥇
```
