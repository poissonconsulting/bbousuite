pkg_attach <- function(pkg) {
  loc <- if (pkg %in% loadedNamespaces()) dirname(getNamespaceInfo(pkg, "path"))
  do.call(
    "library",
    list(pkg, lib.loc = loc, character.only = TRUE, warn.conflicts = FALSE)
  )
}

pkgs_attach <- function(pkgs) {
  msg("Attaching: ", paste(pkgs, collapse = " "))

  suppressPackageStartupMessages(
    lapply(pkgs, pkg_attach)
  )
  invisible()
}
