
<!-- README.md is generated from README.Rmd. Please edit that file -->

# quickcheck <img src="man/figures/hex.png" align="right" style="width: 25%;"/>

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
#> Test passed 🥳

test_that("+ is commutative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    property = \(a, b) expect_equal(a + b, b + a)
  )          
})
#> Test passed 😸

test_that("+ is associative", {
  for_all(
    a = numeric_(len = 1),
    b = numeric_(len = 1),
    c = numeric_(len = 1),
    property = \(a, b, c) expect_equal(a + (b + c), (a + b) + c)
  )          
})
#> Test passed 🎉
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
#> Test passed 🥇

test_that("distinct returns single row if rows are repeated", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      bind_rows(a, a) |> distinct() |> expect_equal(a)
    }
  )
})
#> Test passed 🎊

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
#>  [1]  2028  2772 -4457  6936     0 -8891     0  7352  8148   638
character_alphanumeric(len = 10) |> show_example()
#>  [1] "MTzA"      "gH4H9Raw"  "n3sVjh"    "XGXs"      "u6CGXHtzc" "nMy7Wdyu" 
#>  [7] "TzR"       "YQlSHb"    "TzR"       "ytB"
posixct_(len = 10, any_na = TRUE) |> show_example() 
#>  [1] "1361-04-08 23:51:46 LMT" "1166-01-03 17:46:59 LMT"
#>  [3] "1180-07-03 05:30:28 LMT" "0483-11-10 07:45:12 LMT"
#>  [5] "0482-09-21 16:13:06 LMT" "1255-02-04 23:07:40 LMT"
#>  [7] "2027-01-04 04:03:55 PST" NA                       
#>  [9] "2179-02-25 08:23:19 PST" "1097-02-25 00:18:12 LMT"
```

### Lists

``` r
list_(a = constant(NULL), b = any_undefined()) |> show_example()
#> $a
#> NULL
#> 
#> $b
#> NULL
flat_list_of(logical_(), len = 3) |> show_example()
#> [[1]]
#> [1] FALSE
#> 
#> [[2]]
#> [1] FALSE
#> 
#> [[3]]
#> [1] TRUE
```

### Tibbles

``` r
tibble_(a = date_(), b = hms_(), rows = 5) |> show_example()
#> # A tibble: 5 x 2
#>   a          b              
#>   <date>     <time>         
#> 1 1003-03-13 06:14:47.017376
#> 2 1131-05-11 03:44:24.723084
#> 3 1805-09-24 08:45:19.527709
#> 4 1447-06-06 01:16:16.840266
#> 5 1190-02-05 16:13:21.056747
tibble_of(double_bounded(-10, 10), rows = 3, cols = 3) |> show_example()
#> # A tibble: 3 x 3
#>    ...1  ...2   ...3
#>   <dbl> <dbl>  <dbl>
#> 1  5.15  1.42 -0.516
#> 2 -8.97 -5.68  3.39 
#> 3 -8.69 -1.72 -6.98
any_tibble(rows = 3, cols = 3) |> show_example()
#> # A tibble: 3 x 3
#>   ...1      ...2             ...3
#>   <list>    <time>          <int>
#> 1 <dbl [4]> 08:54:25.488938  6896
#> 2 <lgl [8]> 18:24:32.969608  3578
#> 3 <lgl [6]> 05:33:29.001039  4933
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
#> Test passed 🥇
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
#> Test passed 🥇
```

But this will cause an error:

``` r
test_that("composing hedgehog with quickcheck generators fails", {
  tibble_of(from_hedgehog(gen_powers_of_two)) |> expect_error()
})
#> Test passed 🎊
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
#> Test passed 🎉
```

## Fuzz tests

Fuzz testing is a special case of property based testing in which the
only property being tested is that the code doesn’t fail with a range of
inputs. Here is an example of how to do fuzz testing with `quickcheck`.
Let’s say we want to test that the `purrr::map` function won’t fail with
any vector as input.

``` r
test_that("map won't fail with any vector as input", {
  for_all(
    a = any_vector(),
    property = \(a) purrr::map(a, identity) |> expect_silent()
  )
})
#> Test passed 😸
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
#> Test passed 😀
```
