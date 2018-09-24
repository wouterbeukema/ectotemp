#' Exploitation of the thermal environment
#' 
#' This function determines the extent to which organisms exploit their thermal 
#' environment (indexed by Ex) following Christian and Weavers (1996). Ex is 
#' given by the amount of time when field body temperatures (Tb) are within the 
#' set-point range, relative to the total amount of time during which this 
#' could have been possible as indicated by operative temperatures (Te). The 
#' higher the Ex value, the more an organism exploits its thermal environment 
#' when the environment is permissive.
#' The user-supplied vectors containing Te and Tb data are assumed to use the 
#' same time unit. 
#' 
#' @param te A vector containing operative temperatures. These data should be 
#' in the same time unit as the tb data.
#' @param tb A vector containing body temperature measurements.
#' @param tset_low Lower boundary of a species or population set-point range   
#' that was determined through thermal preference trials in a temperature 
#' gradient. This may be a named double vector containing the lower boundary 
#' value, or simply the value itself.
#' @param tset_up Upper boundary of the set-point range.
#' 
#' @return 
#' Ex index, indicating thermal exploitation of the environment during a 
#' user-determined period of time.
#' 
#' @references
#' Christian, K. A., & Weavers, B. W. (1996). Thermoregulation of monitor 
#' lizards in Australia: an evaluation of methods in thermal biology. 
#' Ecological monographs, 66(2), 139-157.
#' 
#' @examples
#' te <- na.omit(ichalp[,"te"])
#' tb <- na.omit(ichalp[,"tb"])
#' Ex <- calculate_Ex(te, tb, 14.44, 18.33)
#'
#' @export
calculate_Ex <- 
  function(te, tb, tset_low, tset_up){
    nr_te_within_tset <- sum(te > tset_low & te < tset_up)
    nr_tb_within_tset <- sum(tb > tset_low & tb < tset_up)
    Ex <- nr_tb_within_tset / nr_te_within_tset
  }