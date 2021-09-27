#' set auth token path
#'
#' @param GCS_AUTH_FILE character(1) path to GCS json file
#'
#' @family Internal utilities
#'
#' @export
set_gcs_auth_file <- function(GCS_AUTH_FILE) {
    if(!file.exists(GCS_AUTH_FILE)) {
        stop(sprintf("File `%s` does not exist?",GCS_AUTH_FILE))
    }
    Sys.setenv("GCS_AUTH_FILE"=GCS_AUTH_FILE)
}

#' get auth token path
#'
#' @export
get_google_auth_file <- function() {
    Sys.getenv("GCS_AUTH_FILE")
}
