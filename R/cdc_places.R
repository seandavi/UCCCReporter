#' CDC PLACES geographic data on health-related burden and outcome
#'
#' PLACES, a collaboration between CDC, the Robert Wood Johnson Foundation, and
#' the CDC Foundation, allows local health departments and jurisdictions
#' regardless of population size and urban-rural status to better understand the
#' burden and geographic distribution of health-related outcomes in their areas
#' and assist them in planning public health interventions.
#'
#' PLACES provides model-based population-level analysis and community estimates
#' to all counties, places (incorporated and census designated places), census
#' tracts, and ZIP Code Tabulation Areas (ZCTAs) across the United States.
#'
#' PLACES is an extension of the original 500 Cities Project that provided city
#' and census tract estimates for chronic disease risk factors, health outcomes,
#' and clinical preventive services use for the 500 largest US cities.
#'
#' They were accessed on September 25, 2021.
#'
#' @source
#' \url{https://www.cdc.gov/places/}
#'
#' @section Download: -
#'   \url{https://github.com/seandavi/UCCCReporter/raw/main/inst/extdata/PLACES__Local_Data_for_Better_Health__ZCTA_Data_2020_release.csv.gz}
#'
#'
#' @section Geographic level:
#'
#' - zipcode
#'
#' @family Data resources
#'
#' @examples
#' places <- cdc_places()
#'
#' head(places)
#'
#' # All available measures:
#' unique(places$Measure)
#'
#'
#' @export
cdc_places <- function() {
    fname = system.file('extdata/PLACES__Local_Data_for_Better_Health__ZCTA_Data_2020_release.csv.gz', package='UCCCReporter')
    data.table::fread(fname)
}
