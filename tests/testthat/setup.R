setup <- function() {
  if (is_dev_version())
    options(quickcheck.tests = 100L)

  else
    options(quickcheck.tests = 5L)
}

setup()
