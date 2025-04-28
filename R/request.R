#' Request Data from Pacifico Python Library with Automatic Setup
#'
#' @param token Your API token.
#' @param ticker Ticker symbol.
#' @param family Optional family filter.
#' @param group Optional group filter.
#' @param market Optional market filter.
#' @param country Optional country filter.
#' @param document Optional document filter.
#' @param item Optional item filter.
#' @param chapter Optional chapter filter.
#' @param section Optional section filter.
#' @param subsection Optional subsection filter.
#' @param paragraph Optional paragraph filter.
#' @param app Optional app filter.
#' @param help Show help (logical).
#' @param dateStart Start date (Date or POSIXct).
#' @param dateEnd End date (Date or POSIXct).
#' @param fieldType Field type.
#' @param author Author.
#' @param timeOut Time out in seconds.
#' @param fileName Optional file name.
#' @param format Output format (default 'dataFrame').
#'
#' @return A cleaned dataframe with proper date formatting.
#' @examples
#' \dontrun{
#' # Example of requesting data from Pacifico:
#' result <- request(
#'   token = "your_api_token_here",
#'   ticker = "CLP@TPM",
#'   dateStart = as.Date("2025-04-20"),
#'   dateEnd = as.Date("2025-04-23")
#' )
#' print(result)
#' }
#' @export
request <- function(token = "",
                    ticker = "",
                    family = "",
                    group = "",
                    market = "",
                    country = "",
                    document = "",
                    item = "",
                    chapter = "",
                    section = "",
                    subsection = "",
                    paragraph = "",
                    app = "",
                    help = FALSE,
                    dateStart = Sys.Date(),
                    dateEnd = Sys.Date(),
                    fieldType = "",
                    author = "",
                    timeOut = 300,
                    fileName = "",
                    format = "dataFrame") {
  env <- setup_pacifico_environment()
  pacifico <- env$pacifico

  # Convert dates to Python datetime.date
  py_dateStart <- to_py_date(dateStart)
  py_dateEnd   <- to_py_date(dateEnd)

  # Call pacifico request
  result <- pacifico$request(
    token = token,
    ticker = ticker,
    family = family,
    group = group,
    market = market,
    country = country,
    document = document,
    item = item,
    chapter = chapter,
    section = section,
    subsection = subsection,
    paragraph = paragraph,
    app = app,
    help = help,
    dateStart = py_dateStart,
    dateEnd = py_dateEnd,
    fieldType = fieldType,
    author = author,
    timeOut = timeOut,
    fileName = fileName,
    format = format
  )

  if (tolower(format) != "json") {
  # Clean date columns
  result$`Date Publication` <- clean_date(result$`Date Publication`)
  result$`Date Publication` <- as.POSIXct(result$`Date Publication`, format = "%Y-%m-%d %H:%M:%S")
  result$`Date Effective`   <- clean_date(result$`Date Effective`)
  result$`Date Effective`   <- as.POSIXct(result$`Date Effective`, format = "%Y-%m-%d %H:%M:%S")
  result$`Date Tenor`       <- clean_date(result$`Date Tenor`)
  if (grepl("T", result$`Date Tenor`[1])){
    result$`Date Tenor`       <- as.POSIXct(result$`Date Tenor`, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
  }
  else{
    result$`Date Tenor`       <- as.POSIXct(result$`Date Tenor`, format = "%Y-%m-%d %H:%M:%S")
  }
  }

  return(result)
}
