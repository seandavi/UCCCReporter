#' data.table of rural zipcodes from HRSA
#'
#' Data are stored at extdata/forhp-eligible-zips.xlsx for convenience.
#' They were accesses on September 25, 2021.
#'
#' @source \url{https://www.hrsa.gov/rural-health/about-us/definition/datafiles.html}
#'
#' @section Geographic level:
#'
#' - zipcode
#' - state
#'
#' @family Data resources
#'
#' @examples
#' rural_zip_data = rural_zips()
#'
#' head(rural_zip_data)
#'
#' # top states by number of rural counties
#' rural_zip_data[,.(.N),by=state][order(N,decreasing=TRUE)][1:10,]
#'
#' @export
rural_zips <- function() {
    tf = system.file(package='UCCCReporter','extdata/forhp-eligible-zips.xlsx')
    df <- readxl::read_excel(tf)
    data.table::setDT(df)
    data.table::setnames(df,old = tolower)
    data.table::setkey(df,'zip_code')
    df
}
