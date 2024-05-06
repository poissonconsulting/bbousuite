test_that("bbousite packages returns character vector of package names", {
  out <- bbousuite_packages()
  expect_type(out, "character")
  expect_true("bboutools" %in% out)
})
