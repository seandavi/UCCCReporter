#' Colorado shape files from census bureau
#'
#' This function simply wraps `tigris::zctas()` to grab the zip code shape
#' files for later plotting.
#'
#' @param state character(1) default 'colorado', passed directly to `tigris::zctas()`
#' @param year integer(1) default 2010, passed directly to `tigris::zctas()`
#' @param ... passed directly to `tigris::zctas()`
#'
#' @family Data resources
#'
#' @section Geographic level:
#' - zipcode
#'
#' @examples
#'
#' zipshapes = zipcode_shapes()
#'
#' tmap::tmap_mode('plot')
#'
#' tmap::tm_shape(zipshapes) +
#'   tmap::tm_fill('ALAND10') +
#'   tmap::tm_borders(col="gray",alpha=0.5) +
#'   tmap::tm_basemap("Esri.WorldStreetMap")
#'
#'
#'@export
zipcode_shapes = function(state='colorado',year=2010,...,progress_bar=interactive()) {
    tigris::zctas(state=state,year=year,...,progress_bar=progress_bar)
}
