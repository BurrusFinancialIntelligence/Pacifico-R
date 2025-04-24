
# pacifico

<!-- badges: start -->
<!-- badges: end -->

This repository holds the pacifico user R package for the API (client source code).

## Installation

You can install the development version of pacifico like so:
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


