#' Calculate accuracy of temperature regulation
#'
#' This function determines the degree to which ectotherms experience body 
#' temperatures outside their set-point range, better known as the accuracy of 
#' temperature regulation (db) as described by Hertz et al. (1993). Descriptive 
#' statistics are automatically computed as well.
#' 
#' @param tb A vector containing body temperature measurements.
#' @param tset_low Lower boundary of a species or population set-point range 
#' that was determined through thermal preference trials in a temperature 
#' gradient.
#' @param tset_up Upper boundary of the set-point range.
#' 
#' @return Degree to which ectotherms experience body temperatures outside 
#' their set-point range (db), and associated descriptive statistics.
#' 
#' @references 
#' Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature 
#' regulation by field-active ectotherms: the fallacy of the inappropriate 
#' question. The American Naturalist, 142(5), 796-818.
#' 
#' @examples
#' tb <- na.omit(bufbuf[,"tb"])
#' db_stats <- calculate_db(tb, 19.35, 26.44)
#'
#' @export
calculate_db <- 
  function(tb, tset_low, tset_up){
    db <- dplyr::case_when(
      tb > tset_low & tb < tset_up ~ 0,
      tb < tset_low ~ tset_low - tb,
      tb > tset_up ~ tb - tset_up)
    db_stats<- as.list(psych::describe(db))
  }