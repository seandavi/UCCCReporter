#' get demographic report from Bigquery or cache
#'
#' @param use_cache logical(1) whether or not to use
#' values from cache. If cache does not exist, data are downloaded.
#'
#' @family Internal utilities
#'
#' @export
get_patient_report <- function(use_cache=TRUE) {
    cache_file = '/tmp/records.rds'
    if(file.exists(cache_file) & use_cache) {
        return(readRDS(cache_file))
    }
    library(bigrquery)

    if(is.null(get_google_auth_file()))
        bigrquery::bq_auth()
    else
        bigrquery::bq_auth(path=get_google_auth_file())

    con <- DBI::dbConnect(
        bigrquery::bigquery(),
        project = "uccc-warehouse",
        billing = "uccc-warehouse",
        bigint = "integer64"
    )
    records = con |>
        dplyr::tbl('uccc-warehouse.staging.reports') |>
        dplyr::collect()
    data.table::setDT(records)
    records[,row_id:=.I]
    saveRDS(records,cache_file)
    records
}

relationalize_patient_reports <- function(records) {
    patient_details <- unique(records[,c("arb_person_id","GenderIdentity","SexAssignedAtBirth",
                           "SexualOrientation","Race","Ethnicity","PostalCode")])
    patient_first_visits <- records[,c("arb_person_id","RN","FirstCancerCenterVisit_Date",
                                      "Age_At_FirstVisit","PayorName_AtFirstTimeOfVisit")]
    patient_diagnoses <- records[,c("arb_person_id","RN","ICDCodeType","ICDCode","ICDDescription")][
        ,lapply(.SD,function(x) strsplit(x,' \\| ')),by=.(arb_person_id,RN),.SDcols=c('ICDCode','ICDDescription','ICDCodeType')][
            ,lapply(.SD,unlist,recursive=FALSE),by=.(arb_person_id,RN)]
    patient_clinics <- records[,c("arb_person_id","RN","Clinic_Identifier")][
        ,lapply(.SD,function(x) strsplit(x,' \\| ')),by=.(arb_person_id,RN),.SDcols=c("Clinic_Identifier")][
            ,lapply(.SD,unlist,recursive=FALSE),by=.(arb_person_id,RN)]
    patient_trials <- records[,c("arb_person_id","RN","Protocol")][
        ,lapply(.SD,function(x) strsplit(x,' \\| ')),by=.(arb_person_id,RN),.SDcols=c("Protocol")][
            ,lapply(.SD,unlist,recursive=FALSE),by=.(arb_person_id,RN)]
    return(list(patient_details=patient_details,
                patient_first_visits=patient_first_visits,
                patient_diagnoses=patient_diagnoses,
                patient_clinics=patient_clinics,
                patient_trials=patient_trials
                ))

}

demographics_by_clinic <- function(d, clinic_name, ...) {
    by_race = d[grepl(clinic_name, Clinic_Name, ...),count:=.N,by=Race]
}
