test_that("to_py_date returns Python date object", {
  datetime <- reticulate::import("datetime")
  result <- to_py_date(as.Date("2025-04-23"))

  # Use py_call() on isinstance()
  is_date <- reticulate::py_eval("isinstance", convert = TRUE)(
    result,
    datetime$date
  )

  expect_true(is_date)
})
