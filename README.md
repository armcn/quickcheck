
<!-- README.md is generated from README.Rmd. Please edit that file -->

# quickcheck <img src="man/figures/hex.png" align="right" style="width: 20%;"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/armcn/quickcheck/workflows/R-CMD-check/badge.svg)](https://github.com/armcn/quickcheck/actions)
[![Codecov test
coverage](https://codecov.io/gh/armcn/quickcheck/branch/main/graph/badge.svg)](https://app.codecov.io/gh/armcn/quickcheck?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

# Overview

Property based testing in R, inspired by
[QuickCheck](https://en.wikipedia.org/wiki/QuickCheck). This package
builds on the property based testing framework provided by
[`hedgehog`](https://github.com/hedgehogqa/r-hedgehog) and is designed
to seamlessly integrate with a [`testthat`](https://testthat.r-lib.org).

## Installation

You can install the development version of quickcheck from
[GitHub](https://github.com/) with:

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
    a = numeric_(),
    property = \(a) expect_equal(a, a + 0)
  )          
})

test_that("+ is commutative", {
  for_all(
    a = numeric_(),
    b = numeric_(),
    property = \(a, b) expect_equal(a + b, b + a)
  )          
})

test_that("+ is associative", {
  for_all(
    a = numeric_(),
    b = numeric_(),
    c = numeric_(),
    property = \(a, b, c) expect_equal(a + (b + c), (a + b) + c)
  )          
})
```

Here we test the properties of the
[`distinct`](https://dplyr.tidyverse.org/reference/distinct.html)
function from the [`dplyr`](https://dplyr.tidyverse.org/index.html)
package.

``` r
library(dplyr)

test_that("distinct does nothing with a single row", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      distinct(a) |> expect_equal(a)
    }
  )
})

test_that("distinct returns single row if rows are repeated", {
  for_all(
    a = any_tibble(rows = 1L),
    property = \(a) {
      bind_rows(a, a) |> distinct() |> expect_equal(a)
    }
  )
})

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
```
