#' Helper that gets the mean by some variables
#'
#' @param ds a Dataset
#' @param mean_var string alias of a single variable you want to get a mean of
#' @param by_vars string aliases of variables to group by
#'
#' @return an object of class `CrunchCube`
#' @export
crunch_mean_by <- function(ds, mean_var, by_vars) {
    crunch::crtabs(
        stats::formula(paste0("mean(", mean_var, ") ~ ", paste(by_vars, collapse = " + "))),
        ds
    )
}
