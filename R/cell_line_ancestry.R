#' Cell line ancestry for common cancer cell lines
#'
#' Data are stored at extdata/cancer-cell-lines-ancestry.csv.gz
#' They were accessed on November 15, 2021.
#'
#' @source \url{http://ecla.moffitt.org/}
#'
#' @references
#' Dutil J, Chen Z, Monteiro AN, Teer JK, Eschrich SA. An Interactive Resource to Probe Genetic Diversity and Estimated Ancestry in Cancer Cell Lines. Cancer Res. 2019 Apr 1;79(7):1263-1273. doi: 10.1158/0008-5472.CAN-18-2747. Epub 2019 Mar 20. PMID: 30894373; PMCID: PMC6445675.
#'
#' - \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6445675/}
#'
#'
#' @section Download:
#' - \url{https://github.com/seandavi/UCCCReporter/raw/main/inst/extdata/cancer-cell-lines-ancestry.csv.gz}
#'
#' @family Data resources
#'
#' @examples
#' cl_ancestry = cell_line_ancestry()
#'
#' head(cl_ancestry)
#'
#' @export
cell_line_ancestry <- function() {
    tf = system.file(package='UCCCReporter','extdata/cancer-cell-lines-ancestry.csv.gz')
    # column names are capitalized
    # Read zip at character to keep leading zeros
    df <- data.table::fread(tf)
    data.table::setnames(df,old = tolower)
    df$cvcl_url=sprintf("https://web.expasy.org/cellosaurus/CVCL%s",df$cvcl)
    df
}
