
# pacifico

<!-- badges: start -->
<!-- badges: end -->

The **`pacifico`** R package provides an interface to the **`Pacifico`** Python library, allowing users to request financial market data and handle date conversions seamlessly between R and Python. The package automates Python environment setup through **`reticulate`** and simplifies working with the **`Pacifico`** API (client source code) for economic research and analysis.

## Installation

You can install the development version of **`pacifico`** like so:
``` 
install.packages("devtools")
# or
install.packages("remotes")}

# for private repo
Sys.setenv(GITHUB_PAT = "your_github_token_here")

devtools::install_github("username/Pacifico-R")
# or
remotes::install_github("username/Pacifico-R")
``` 

## Example

This is a basic example of a request to the API:
``` 
library(pacifico)

pacifico::request(token='', ticker="CLP@TPM")

``` 

## Note

The package requires a Python environment with the pacifico Python package installed.
To set up this environment automatically, run:


```
library(pacifico)

# This will:
# - Install Miniconda if not already installed,
# - Create the 'r-reticulate' environment if missing,
# - Install the 'pacifico' Python package into that environment.
install_pacifico_environment()

```
