
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
to seamlessly integrate with a [`testthat`](https://testthat.r-lib.org).

## Installation

You can install the released version of quickcheck from
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

The following example uses quickcheck to test the properties of the base
R `+` function.
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
#> Test passed 🌈

test_that("+ is commutative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    property = \(a, b) expect_equal(a + b, b + a)
  )          
})
#> Test passed 🎊

test_that("+ is associative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    c = numeric_(len = 1),
    property = \(a, b, c) expect_equal(a + (b + c), (a + b) + c)
  )          
})
#> Test passed 🌈
```

Here we test the properties of the
[`distinct`](https://dplyr.tidyverse.org/reference/distinct.html)
function from the [`dplyr`](https://dplyr.tidyverse.org/index.html)
package.

``` r
library(dplyr) |> suppressMessages()

test_that("distinct does nothing with a single row", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      distinct(a) |> expect_equal(a)
    }
  )
})
#> Test passed 🥳

test_that("distinct returns single row if rows are repeated", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      bind_rows(a, a) |> distinct() |> expect_equal(a)
    }
  )
})
#> Test passed 😀

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
#> Test passed 🥇
```

## Quickcheck generators

Many generators are provided with quickcheck. Here are a few examples.

### Atomic vectors

``` r
integer_(len = 10) |> show_example()
#>  [1]  -814     0 -3226  4292 -9604 -4857 -6333     0   143  1791
character_alphanumeric(len = 10, frac_na = 0.5) |> show_example()
#>  [1] "0O3JDnxgK" NA          "GB"        "ilHPKEIez" "N88"       NA         
#>  [7] "IU"        NA          NA          "vgmzoe9Z"
```

### Lists

``` r
list_(a = constant(NULL), b = logical_(len = 1)) |> show_example()
#> $a
#> NULL
#> 
#> $b
#> [1] FALSE
flat_list_of(hms_(), len = 3) |> show_example()
#> [[1]]
#> 08:23:44.87806
#> 
#> [[2]]
#> 20:43:37.839286
#> 
#> [[3]]
#> 20:54:18.834063
```

### Tibbles

``` r
tibble_(a = date_(), b = posixct_(), rows = 5) |> show_example()
#> # A tibble: 5 x 2
#>   a          b                  
#>   <date>     <dttm>             
#> 1 1092-06-04 1786-08-16 19:37:01
#> 2 2780-10-06 2731-07-01 13:51:04
#> 3 1586-07-16 0377-07-03 09:38:30
#> 4 2212-03-17 0404-12-21 08:54:40
#> 5 2515-04-24 2979-02-04 05:40:53
tibble_of(any_vector(), cols = 3, rows = 3) |> show_example()
#> # A tibble: 3 x 3
#>   ...1       ...2             ...3 
#>   <list>     <list>           <lgl>
#> 1 <chr [1]>  <named list [2]> FALSE
#> 2 <fct [1]>  <named list [2]> FALSE
#> 3 <time [1]> <named list [2]> FALSE
```

## Hedgehog generators

quickcheck is meant to work with hedgehog, not replace it. hedgehog
generators can be used simply by wrapping them in `from_hedgehog`. Under
the hood all this function does is wrap the hedgehog generator in an
anonymous function and add the `quickcheck_generator` class to it.

``` r
library(hedgehog)

is_even <- 
  \(a) a %% 2 == 0

gen_powers_of_two <- 
  gen.element(1:10) |> gen.with(\(a) 2 ^ a)

for_all(
  a = from_hedgehog(gen_powers_of_two),
  property = \(a) is_even(a) |> expect_true()
)
```

Any hedgehog generator can be used with quickcheck but they can’t be
composed together to build another generator. For example this will
work:

``` r
for_all(
  a = from_hedgehog(gen_powers_of_two),
  b = integer_(),
  property = \(a, b) c(a, b) |> is.numeric() |> expect_true()
)
```

But this will cause an error:

``` r
for_all(
  a = tibble_of(from_hedgehog(gen_powers_of_two)),
  property = \(a) is_tibble(a) |> expect_true()
)
#> Error
```

## Fuzz testing

Fuzz testing is a special case of property based testing in which the
only property being testing is that the code doesn’t fail with a range
of inputs. Here is an example of how to do fuzz testing with quickcheck.
Let’s say we want to test that the `purrr::map` function won’t fail with
any vector as input.

``` r
for_all(
  a = any_vector(),
  property = \(a) purrr::map(a, identity) |> expect_silent()
)
```
