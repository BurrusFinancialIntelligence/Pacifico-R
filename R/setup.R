#' Check Python environment and 'pacifico' availability
#'
#' Verifies if the Python environment and 'pacifico' package are available.
#' Warns the user if setup is incomplete.
#'
#' @return A list with the imported 'pacifico' and 'datetime' modules if available.
#' @keywords internal
setup_pacifico_environment <- function() {
  condaenv_name <- "r-reticulate"

  # Check if Miniconda exists
  if (!dir.exists(reticulate::miniconda_path())) {
    warning("Miniconda not found. Please run install_pacifico_environment() first.")
    return(invisible(NULL))
  }

  # Check if the environment exists
  if (!(condaenv_name %in% reticulate::conda_list()$name)) {
    warning("Conda environment 'r-reticulate' not found. Please run install_pacifico_environment().")
    return(invisible(NULL))
  }

  # Activate and check if 'pacifico' is installed
  reticulate::use_condaenv(condaenv_name, required = TRUE)
  if (!"pacifico" %in% reticulate::py_list_packages()$package) {
    warning("'pacifico' package not found. Please run install_pacifico_environment().")
    return(invisible(NULL))
  }

  # Load modules
  pacifico <- reticulate::import("pacifico")
  datetime <- reticulate::import("datetime")
  #message("'pacifico' environment and package successfully loaded.")

  return(list(pacifico = pacifico, datetime = datetime))
}


#' Install Python environment and 'pacifico' package
#'
#' This function installs Miniconda (if not available) and installs the 'pacifico'
#' Python package into the 'r-reticulate' environment.
#'
#' @export
install_pacifico_environment <- function() {
  condaenv_name <- "r-reticulate"

  # Install Miniconda if needed
  if (!dir.exists(reticulate::miniconda_path())) {
    message("Miniconda not found. Installing Miniconda...")
    reticulate::install_miniconda()
  }

  # Create the environment if not present
  envs <- reticulate::conda_list()$name
  if (!(condaenv_name %in% envs)) {
    message("Creating conda environment 'r-reticulate'...")
    reticulate::conda_create(envname = condaenv_name)
  }

  # Use the environment and install 'pacifico'
  reticulate::use_condaenv(condaenv_name, required = TRUE)
  packages <- reticulate::py_list_packages()$package
  if (!"pacifico" %in% packages) {
    message("Installing 'pacifico' Python package via pip...")
    reticulate::py_install("pacifico", envname = condaenv_name, method = "pip", pip = TRUE)
  }

  message("Environment setup complete.")
}
