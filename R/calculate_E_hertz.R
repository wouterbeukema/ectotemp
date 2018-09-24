#' Calculate thermoregulation effectiveness sensu Hertz, Huey & Stevenson
#'
#' This function calculates the effectiveness of temperature regulation 
#' (E = 1 - (mean db / mean de)) as described by Hertz et al. (1993). The 
#' thermal quality of the habitat (de) and accuracy of temperature regulation 
#' (db) are calculated as part of this formula, so it is not necessary to run 
#' \code{\link{calculate_de}} and \code{\link{calculate_db}} before running 
#' this function.
#' 
#' @param te A vector containing operative temperatures.
#' @param tb A vector containing body temperature measurements.
#' @param tset_low Lower boundary of a species or population set-point range   
#' that was determined through thermal preference trials in a temperature 
#' gradient. This may be a named double vector containing the lower boundary 
#' value, or simply the value itself.
#' @param tset_up Upper boundary of the set-point range.
#' 
#' @return Effectiveness of temperature regulation (E)
#' 
#' @references 
#' Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature 
#' regulation by field-active ectotherms: the fallacy of the inappropriate 
#' question. The American Naturalist, 142(5), 796-818.
#' 
#' @seealso \code{\link{calculate_de}} and \code{\link{calculate_db}}.
#' 
#' @examples
#' te <- na.omit(bufbuf[,"te"])
#' tb <- na.omit(bufbuf[,"tb"])
#' E <- calculate_E_hertz(te, tb, 19.35, 26.44)
#'
#' @export
calculate_E_hertz <- 
  function(te, tb, tset_low, tset_up){
    de <- dplyr::case_when(
      te > tset_low & te < tset_up ~ 0,
      te < tset_low ~ tset_low - te,
      te > tset_up ~ te - tset_up)
    mean_de <- mean(de)
    db <- dplyr::case_when(
      tb > tset_low & tb < tset_up ~ 0,
      tb < tset_low ~ tset_low - tb,
      tb > tset_up ~ tb - tset_up)
    mean_db <- mean(db)
    E <- 1 - (mean_db/mean_de)
  }