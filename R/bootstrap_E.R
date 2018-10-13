#' Bootstrap thermoregulation effectiveness
#'
#' Bootstrapping of the effectiveness of temperature regulation (E) from the
#' original distributions of Te and Tb as described by Hertz et al. (1993).
#' One can choose the number of resamples and has the option to calculate E as
#' defined by Hertz et al. (1993) or Blouin-Demers & Weatherhead (2001). See
#' \code{\link{calculate_E_hertz}} and \code{\link{calculate_E_blouin}} for
#' more information about these two indices.
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
#' @param index Either 'hertz' or 'blouin'.
#' @param n The desired number of samples drawn with replacement.
#'
#' @return The mean E and its 95 percent confidence interval obtained through
#' resampling with replacement n times.
#'
#' @references
#' Blouin-Demers, G., & Weatherhead, P. J. (2001). Thermal ecology of black rat
#' snakes (Elaphe obsoleta) in a thermally challenging environment. Ecology, 82
#' (11), 3025-3043. \cr
#' Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature
#' regulation by field-active ectotherms: the fallacy of the inappropriate
#' question. The American Naturalist, 142(5), 796-818.
#'
#' @seealso \code{\link{calculate_E_hertz}} and
#' \code{\link{calculate_E_blouin}}.
#'
#' @examples
#' te <- na.omit(bufbuf[,"te"])
#' tb <- na.omit(bufbuf[,"tb"])
#' E_bootstrapped <- bootstrap_E(te, tb,
#'                              19.35, 26.44,
#'                              hertz',
#'                              1000)
#'
#' @export
bootstrap_E <-
  function(te, tb, tset_low, tset_up, index, n){
    E_bootstrapped <- list()
    for(i in 1:n){
      te_sample <- sample(te, size = length(te), replace=T)
      de <- dplyr::case_when(
        te_sample > tset_low & te_sample < tset_up ~ 0,
        te_sample < tset_low ~ tset_low - te_sample,
        te_sample > tset_up ~ te_sample - tset_up)
      mean_de <- mean(de)
      tb_sample <- sample(tb, size = length(tb), replace=T)
      db <- dplyr::case_when(
        tb_sample > tset_low & tb_sample < tset_up ~ 0,
        tb_sample < tset_low ~ tset_low - tb_sample,
        tb_sample > tset_up ~ tb_sample - tset_up)
      mean_db <- mean(db)
      if(index=='hertz'){
        E <- 1 - (mean_db/mean_de)
      } else {
        if(index=='blouin'){
          E <- (mean_de - mean_db)
        }
      }
      E_bootstrapped[i] <- E
    }
    E_bootstrapped2 <- unlist(E_bootstrapped)
    sd <- sd(E_bootstrapped2)
    n <- length(E_bootstrapped2)
    mean <- mean(E_bootstrapped2)
    error <- stats::qnorm(0.975) * sd / sqrt(n)
    E_CI <- as.list(c("mean" = mean,
                      "lower" = mean - error,
                      "upper" = mean + error))
    E_list <- as.list(c(E_bootstrapped))
    returnlist = list("Confidence Interval" = E_CI, "E values"= E_list)
  }
