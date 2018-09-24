#' Calculate thermal quality of the habitat
#'
#' This function calculates the thermal quality of the habitat (de) from the
#' perspective of the focal species or population as described by Hertz et al. 
#' (1993). Descriptive statistics are automatically computed as well.
#' 
#' @param te A vector containing operative temperatures.
#' @param tset_low Lower boundary of a species or population set-point range 
#' that was determined through thermal preference trials in a temperature 
#' gradient.
#' @param tset_up Upper boundary of the set-point range.
#' 
#' @return Thermal quality of the habitat (de) and associated descriptive 
#' statistics.
#' 
#' @references
#' Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature 
#' regulation by field-active ectotherms: the fallacy of the inappropriate 
#' question. The American Naturalist, 142(5), 796-818.
#'
#' @examples
#' te <- na.omit(bufbuf[,"te"])
#' de_stats <- calculate_de(te, 19.35, 26.44)
#'
#' @export
calculate_de <- 
  function(te, tset_low, tset_up){
    de <- dplyr::case_when(
      te > tset_low & te < tset_up ~ 0,
      te < tset_low ~ tset_low - te,
      te > tset_up ~ te - tset_up)
    de_stats<- as.list(psych::describe(de))
  }