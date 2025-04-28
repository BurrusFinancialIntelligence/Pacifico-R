test_that("clean_date handles ISO strings and blanks correctly", {
  input <- c("2025-04-23 00:00:00", "")
  output <- clean_date(input)
  expect_equal(output, c("2025-04-23 00:00:00", NA_character_))  # Expect NA, not ""
})
