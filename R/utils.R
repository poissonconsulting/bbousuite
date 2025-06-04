# Copyright 2022-2023 Integrated Ecological Research and Poisson Consulting Ltd.
# Copyright 2024 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

msg <- function(...) {
  if (!isTRUE(getOption("bbousuite.quiet"))) {
    packageStartupMessage(...)
  }
}

#' List all bbousuite packages
#'
#' Inspired by `tidyverse::tidyverse_packages()`.
#' @param include_self Include bbousuite in the list?
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
