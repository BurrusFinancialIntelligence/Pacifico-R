#' Convert R Date or POSIXct to Python datetime.date
#'
#' This function converts an R `Date`, `POSIXct`, or `POSIXlt` object into a Python `datetime.date` object.
#'
#' @param x An R `Date`, `POSIXct`, or `POSIXlt` object.
#'
#' @return A Python `datetime.date` object.
#' @examples
#' to_py_date(as.Date("2025-04-23"))
#' @export
to_py_date <- function(x) {
  datetime <- reticulate::import("datetime")

  if (inherits(x, "Date")) {
    x <- as.POSIXlt(x)
  } else if (!(inherits(x, "POSIXct") || inherits(x, "POSIXlt"))) {
    stop("x must be of class Date, POSIXct, or POSIXlt")
  }

  datetime$date(
    as.integer(x$year + 1900),
    as.integer(x$mon + 1),
    as.integer(x$mday)
  )
}


#' Clean Python datetime columns to R POSIXct
#'
#' This function cleans a column of Python datetime objects (or strings)
#' returned via `reticulate`, converting them to ISO format strings for R.
#'
#' @param column A vector (usually a column from a dataframe) containing
#' Python datetime objects or ISO-formatted character strings.
#'
#' @return A character vector of ISO date strings.
#' @examples
#' # Example with mixed data types:
#' clean_date(c("2025-04-23 00:00:00", ""))
#' @export
clean_date <- function(column) {
  sapply(column, function(x) {
    if (inherits(x, "python.builtin.object")) {
      return(x$isoformat())
    } else if (is.character(x)) {
      if (x == "") {
        return(NA_character_)
      } else {
        return(x)
      }
    } else {
      return(as.character(x))
    }
  }, USE.NAMES = FALSE)
}
