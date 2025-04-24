#' Setup Pacifico Python Environment Safely
#'
#' This function checks for Miniconda, creates the `r-reticulate` environment if needed,
#' installs the required Python package `pacifico`, and imports the necessary modules.
#'
#' @return A list with the imported `pacifico` and `datetime` Python modules.
#' @export
setup_pacifico_environment <- function() {
  # Check if Miniconda is installed:
  miniconda_path <- reticulate::miniconda_path()
  if (!dir.exists(miniconda_path)) {
    message("Miniconda not found. Installing Miniconda...")
    reticulate::install_miniconda()
  }

  # Define the environment name explicitly:
  condaenv_name <- "r-reticulate"

  # Check if the environment exists:
  available_envs <- reticulate::conda_list()$name
  if (!(condaenv_name %in% available_envs)) {
    message("Creating conda environment 'r-reticulate'...")
    reticulate::conda_create(envname = condaenv_name)
  }

  # Activate the environment:
  reticulate::use_condaenv(condaenv_name, required = TRUE)

  # Check if 'pacifico' is installed in the environment:
  if (!"pacifico" %in% reticulate::py_list_packages()$package) {
    message("Installing 'pacifico' Python package via pip...")
    reticulate::py_install("pacifico", envname = condaenv_name, method = "pip", pip = TRUE)
  }

  # Import Python modules:
  pacifico <- reticulate::import("pacifico")
  datetime <- reticulate::import("datetime")

  return(list(pacifico = pacifico, datetime = datetime))
}

