#' Thermoregulation effectiveness sensu Blouin-Demers & Weatherhead
#' 
#' This function calculates an often-used variant of the original formula to 
#' determine effectiveness of temperature regulation of Hertz et al. (1993). 
#' The concerning variant was proposed by Blouin-Demers & Weatherhead (2001), 
#' who argued that interpretation of the formula of Hertz et al. (1993) is
#' confounded by the fact that different combinations of the mean thermal 
#' quality of the habitat (de) and mean accuracy of temperature regulation (db) 
#' might lead to similar E values. As such, Blouin-Demers & Weatherhead (2001)
#' proposed use of E = de - db, which quantifies the extent of departure from 
#' perfect thermoconformity. Postive E values indicate active temperature
#' regulation, negative values represent active avoidance of suitable thermal 
#' habitat, and values around 0 suggest thermoconformity. 
#' The thermal quality of the habitat (de) and accuracy of temperature 
#' regulation (db) are calculated as part of this formula, so it is not 
#' necessary to run \code{\link{calculate_de}} and \code{\link{calculate_db}} 
#' before running this function.
#'
#' @param te A vector containing operative temperatures.
#' @param tb A vector containing body temperature measurements.
#' @param tset_low Lower boundary of a species or population set-point range   
#' that was determined through thermal preference trials in a temperature 
#' gradient. This may be a named double vector containing the lower boundary 
#' value, or simply the value itself.
#' @param tset_up Upper boundary of the set-point range.
#' 
#' @return Effectiveness of temperature regulation (E) sensu Blouin-Demers 
#' and Weatherhead (2001).
#' 
#' @references 
#' Blouin-Demers, G., & Weatherhead, P. J. (2001). Thermal ecology of black rat 
#' snakes (Elaphe obsoleta) in a thermally challenging environment. Ecology, 82
#' (11), 3025-3043.
#' 
#' @seealso \code{\link{calculate_E_hertz}}.
#' 
#' @examples
#' te <- na.omit(bufbuf[,"te"])
#' tb <- na.omit(bufbuf[,"tb"])
#' E <- calculate_E_blouin(te, tb, 19.35, 26.44)
#'
#' @export
calculate_E_blouin <- 
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
    E <- (mean_de - mean_db)
  }