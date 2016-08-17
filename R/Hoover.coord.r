#' Computes the coordinates used to plot an Hoover curve from regions - industries matrices
#'
#' This function computes the coordinates used to plot a Hoover curve regions - industries matrices.
#' @param mat An incidence matrix with regions in rows and industries in columns. The input can also be a vector of industrial regional count (a matrix with n regions in rows and a single column).
#' @param pop A vector of population regional count
#' @keywords concentration inequality
#' @export
#' @examples
#' ## generate vectors of industrial and population count
#' ind <- c(0, 10, 10, 30, 50)
#' pop <- c(10, 15, 20, 25, 30)
#'
#' ## run the function (30% of the population produces 50% of the industrial output)
#' Hoover.coord (ind, pop)
#'
#' ## plot the coordinates returned by the function to draw an Hoover curve
#' plot (Hoover.coord (ind, pop)$cum.reg, Hoover.coord (ind, pop)$cum.out,
#' type = "l", main = "Hoover curve",
#' xlab="Cumulative proportion of regions",
#' ylab="Cumulative proportion of industrial output",
#' xlim=c(0, 1), ylim=c(0, 1))
#' abline (0,1, col = "red")
#'
#' ## generate a region - industry matrix
#' mat = matrix (
#' c (0, 10, 0, 0,
#' 0, 15, 0, 0,
#' 0, 20, 0, 0,
#' 0, 25, 0, 1,
#' 0, 30, 1, 1), ncol = 4, byrow = T)
#' rownames(mat) <- c ("R1", "R2", "R3", "R4", "R5")
#' colnames(mat) <- c ("I1", "I2", "I3", "I4")
#'
#' ## run the function by aggregating all industries
#' Hoover.coord (rowSums(mat), pop)
#'
#' ## run the function for industry #1 only
#' Hoover.coord (mat[,1], pop)
#'
#' ## run the function for industry #2 only (perfectly proportional to population)
#' Hoover.coord (mat[,2], pop)
#'
#' ## run the function for industry #3 only (30% of the pop. produces 100% of the output)
#' Hoover.coord (mat[,3], pop)
#'
#' ## run the function for industry #4 only (55% of the pop. produces 100% of the output)
#' Hoover.coord (mat[,4], pop)
#'
#' @author Pierre-Alexandre Balland \email{p.balland@uu.nl}
#' @seealso \code{\link{Hoover.Gini}}, \code{\link{locational.Gini}}, \code{\link{locational.Gini.curve}}, \code{\link{Lorenz.curve}}, \code{\link{Gini}}
#' @references Hoover, E.M. (1936) The Measurement of Industrial Localization, \emph{The Review of Economics and Statistics} \strong{18} (1): 162-171

Hoover.coord <- function(mat, pop) {

  mat = as.matrix (mat)
      ind <- c(0, mat[,1])
      pop <- c(0, pop)
      c = data.frame (ind, pop)
      c = c[complete.cases(c),]
      ind = c$ind
      pop = c$pop
      o = ind/pop
      o[is.na(o)] = 0
      oind <- order(o)
      ind <- ind[oind]
      pop <- pop[oind]
      cind <- cumsum(ind)/max(cumsum(ind))
      cpop <- cumsum(pop)/max(cumsum(pop))
      return (list(cum.reg = cpop, cum.out = cind))

  }

