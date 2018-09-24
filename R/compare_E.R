#' Compare E between species or populations using permutation
#'
#' To test whether or not distinct species or populations (hereafter 'entity') 
#' differed in their effectiveness of thermoregulation, Hertz et al. (1993) 
#' suggested comparing paired estimates of E obtained through bootstrapping. 
#' However, because sample sizes of active body temperatures (Tb) or operative 
#' temperatures (Te) may be small and could differ in size and variance, 
#' possibly leading to non-normality, we propose to use two-sided permutation 
#' testing instead of bootstrapping to build and compare distributions of E 
#' values.
#' 
#' @param datasp1 A dataframe with two columns named 'te' (containing operative 
#' temperatures) and 'tb' (containing body temperature measurements) of entity 
#' 1. Do not use capitals in column names.
#' @param datasp2 A dataframe for entity 2 structured as indicated above.
#' @param tset_lowsp1 Lower boundary of the set-point range of entity 1 that 
#' was determined through thermal preference trials in a temperature gradient.
#' This may be a named double vector containing the lower boundary value, or 
#' simply the value itself.
#' @param tset_upsp1 Upper boundary of the set-point range of entity 1.
#' @param tset_lowsp2 Lower boundary of the set-point range of entity 2.
#' @param tset_upsp2 Upper boundary of the set-point range of entity 2.
#' @param index Either 'hertz' or 'blouin'.
#' @param n The desired number of samples drawn without replacement.
#' 
#' @return Permutation testing results including a graphical overview which 
#' displays the empirical (actual) difference in E between two entities, along 
#' with a null distribution of differences in permuted E values constructed 
#' from pooled data of both entities.   
#' 
#' @references 
#' Blouin-Demers, G., & Weatherhead, P. J. (2001). Thermal ecology of black rat 
#' snakes (Elaphe obsoleta) in a thermally challenging environment. Ecology, 82
#' (11), 3025-3043. \cr
#' Hertz, P. E., Huey, R. B., & Stevenson, R. D. (1993). Evaluating temperature 
#' regulation by field-active ectotherms: the fallacy of the inappropriate 
#' question. The American Naturalist, 142(5), 796-818.
#' 
#' @seealso 
#' \code{\link{calculate_E_hertz}} and \code{\link{calculate_E_blouin}}.
#' 
#' @examples
#' bufbuf <- bufbuf
#' ichalp <- ichalp
#' E_diff <- compare_E(bufbuf, ichalp,
#'                     19.35, 26.44, 
#'                     14.44, 18.33,
#'                     'blouin',
#'                     1000)
#'                     
#' @importFrom graphics hist
#' @importFrom graphics abline
#' @importFrom graphics text
#' 
#' @export
compare_E <- 
  function(datasp1, datasp2, 
           tset_lowsp1, tset_upsp1, 
           tset_lowsp2, tset_upsp2,
           index,
           n){
    
    tesp1 <- stats::na.omit(datasp1$te)
    tbsp1 <- stats::na.omit(datasp1$tb)
    tesp2 <- stats::na.omit(datasp2$te)
    tbsp2 <- stats::na.omit(datasp2$tb)
    
    # Determine empirical E;
    desp1 <- dplyr::case_when(
      tesp1 > tset_lowsp1 & tesp1 < tset_upsp1 ~ 0,
      tesp1 < tset_lowsp1 ~ tset_lowsp1 - tesp1,
      tesp1 > tset_upsp1 ~ tesp1 - tset_upsp1)
    mean_desp1 <- mean(desp1)
    dbsp1 <- dplyr::case_when(
      tbsp1 > tset_lowsp1 & tbsp1 < tset_upsp1 ~ 0,
      tbsp1 < tset_lowsp1 ~ tset_lowsp1 - tbsp1,
      tbsp1 > tset_upsp1 ~ tbsp1 - tset_upsp1)
    mean_dbsp1 <- mean(dbsp1)
    if(index=='hertz'){
      Empirical_E_sp1 <- 1 - (mean_dbsp1/mean_desp1)
    } else {
      if(index=='blouin'){
        Empirical_E_sp1 <- (mean_desp1 - mean_dbsp1)
      }
    }
    
    desp2 <- dplyr::case_when(
      tesp2 > tset_lowsp2 & tesp2 < tset_upsp2 ~ 0,
      tesp2 < tset_lowsp2 ~ tset_lowsp2 - tesp2,
      tesp2 > tset_upsp2 ~ tesp2 - tset_upsp2)
    mean_desp2 <- mean(desp2)
    dbsp2 <- dplyr::case_when(
      tbsp2 > tset_lowsp2 & tbsp2 < tset_upsp2 ~ 0,
      tbsp2 < tset_lowsp2 ~ tset_lowsp2 - tbsp2,
      tbsp2 > tset_upsp2 ~ tbsp2 - tset_upsp2)
    mean_dbsp2 <- mean(dbsp2)
    if(index=='hertz'){
      Empirical_E_sp2 <- 1 - (mean_dbsp2/mean_desp2)
    } else {
      if(index=='blouin'){
        Empirical_E_sp2 <- (mean_desp2 - mean_dbsp2)
      }
    }
    
    Empirical_E_diff <- abs(Empirical_E_sp1 - Empirical_E_sp2)
    
    # Permutation;
    te_all <- as.vector(c(tesp1, tesp2))
    tb_all <- as.vector(c(tbsp1, tbsp2))
    
    E_perm <- list() 
    
    for(i in 1:n){
      perm_tesp1 <- sample(te_all, size = length(tesp1), replace=F)
      perm_tesp2 <- sample(te_all, size = length(tesp2), replace=F)
      perm_tbsp1 <- sample(tb_all, size = length(tbsp1), replace=F)
      perm_tbsp2 <- sample(tb_all, size = length(tbsp2), replace=F)
      
      de_perm_sp1 <- dplyr::case_when(
        perm_tesp1 > tset_lowsp1 & perm_tesp1 < tset_upsp1 ~ 0,
        perm_tesp1 < tset_lowsp1 ~ tset_lowsp1 - perm_tesp1,
        perm_tesp1 > tset_upsp1 ~ perm_tesp1 - tset_upsp1)
      mean_perm_desp1 <- mean(de_perm_sp1)
      perm_dbsp1 <- dplyr::case_when(
        perm_tbsp1 > tset_lowsp1 & perm_tbsp1 < tset_upsp1 ~ 0,
        perm_tbsp1 < tset_lowsp1 ~ tset_lowsp1 - perm_tbsp1,
        perm_tbsp1 > tset_upsp1 ~ perm_tbsp1 - tset_upsp1)
      mean_perm_dbsp1 <- mean(perm_dbsp1)
      perm_E_sp1 <- (mean_perm_desp1 - mean_perm_dbsp1)
      
      de_perm_sp2 <- dplyr::case_when(
        perm_tesp2 > tset_lowsp2 & perm_tesp2 < tset_upsp2 ~ 0,
        perm_tesp2 < tset_lowsp2 ~ tset_lowsp2 - perm_tesp2,
        perm_tesp2 > tset_upsp2 ~ perm_tesp2 - tset_upsp2)
      mean_perm_desp2 <- mean(de_perm_sp2)
      perm_dbsp2 <- dplyr::case_when(
        perm_tbsp2 > tset_lowsp2 & perm_tbsp2 < tset_upsp2 ~ 0,
        perm_tbsp2 < tset_lowsp2 ~ tset_lowsp2 - perm_tbsp2,
        perm_tbsp2 > tset_upsp2 ~ perm_tbsp2 - tset_upsp2)
      mean_perm_dbsp2 <- mean(perm_dbsp2)
      perm_E_sp2 <- (mean_perm_desp2 - mean_perm_dbsp2)
      
      perm_E_diff <- perm_E_sp1 - perm_E_sp2
      
      E_perm[i] <- perm_E_diff
      
    } 
    
    E_perm <- unlist(E_perm)
    graphics::hist(E_perm,
                   main = "Distribution of permuted E values (diff sp1 - sp2)",
                   xlab = "E",
                   col = "blue",
                   las = 1,
                   breaks = 25)
    graphics::abline(v = Empirical_E_diff, col = "black", lty = 2, lwd = 2)
    graphics::text(Empirical_E_diff, 10, 
                  adj = c(1.1, -0.5),
                  srt = -90,
                  col = "black",
                  font = 2,
                  cex = 0.7, 
                  "Empirical E difference")
    
    p <- sum(abs(E_perm) >= abs(Empirical_E_diff)) / length(E_perm) 
    
    E_results <- as.list(c("Empirical difference in E" = Empirical_E_diff,
                           "p value" = p))
  }