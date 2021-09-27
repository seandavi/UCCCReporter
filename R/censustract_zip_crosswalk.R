#' data.table mapping zips and census tracts
#'
#' Data are stored at extdata/ZIP_TRACT_062021.xlsx for convenience.
#' They were accesses on September 25, 2021.
#'
#' @source \url{https://www.huduser.gov/portal/datasets/usps_crosswalk.html}
#'
#' @section Geographic level:
#' - zipcode
#' - census tract
#'
#' @family Data resources
#'
#' @examples
#' ctract_zip = census_tract_zip_crosswalk()
#'
#' head(ctract_zip)
#'
#' @export
census_tract_zip_crosswalk <- function() {
    tf = system.file(package='UCCCReporter','extdata/ZIP_TRACT_062021.xlsx')
    df <- readxl::read_excel(tf)
    data.table::setDT(df)
    data.table::setnames(df,old = tolower)
    df
}
