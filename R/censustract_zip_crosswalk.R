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
#' @section Download:
#' - \url{https://github.com/seandavi/UCCCReporter/raw/main/inst/extdata/TRACT_ZIP_092021.csv.gz}
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
    tf = system.file(package='UCCCReporter','extdata/TRACT_ZIP_092021.csv.gz')
    # column names are capitalized
    # Read zip at character to keep leading zeros
    df <- data.table::fread(tf,colClasses = c(ZIP="character"))
    data.table::setnames(df,old = tolower)
    df
}
