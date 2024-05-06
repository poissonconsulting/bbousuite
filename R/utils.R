#' List all bbousite packages
#'
#' @param include_self Include bbousite in the list?
#' @export
#' @examples
#' bbousuite_packages()
bbousuite_packages <- function(include_self = TRUE) {
  raw <- utils::packageDescription("bbousuite")$Imports
  imports <- strsplit(raw, ",")[[1]]
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  names <- vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))
  
  if (include_self) {
    names <- c(names, "bbousuite")
  }
  
  names
}
