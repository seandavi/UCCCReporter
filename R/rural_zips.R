#' data.table of rural zipcodes from HRSA
#'
#' These data were compiled by Federal Office of Rural Health Policy (FORHP)
#' at the Health Resources and Services Administration (HRSA). This data
#' resources gives a simple list of zipcodes that are considered _rural_.
#'
#' They were accessed on September 25, 2021.
#'
#' @source \url{https://www.hrsa.gov/rural-health/about-us/definition/datafiles.html}
#'
#' @section Download:
#' - \url{https://github.com/seandavi/UCCCReporter/raw/main/inst/extdata/forhp-eligible-zips.xlsx}
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
