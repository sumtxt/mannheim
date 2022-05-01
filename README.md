
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mannheim

The R package `mannheim` provides functions to directly retrieve data
from a data archive [(*GESIS
Datenarchiv*)](https://www.gesis.org/angebot/daten-finden-und-abrufen)
maintained by GESIS in Mannheim.

### Installation

To install the latest version from Github use:

``` r
remotes::install_github("sumtxt/mannheim", force=TRUE)
```

### Usage

To retrieve data, you need to register as a user
[here](https://login.gesis.org/realms/gesis/login-actions/registration?client_id=js-login)
and accept the [terms and
conditions](https://www.gesis.org/fileadmin/upload/dienstleistung/daten/umfragedaten/_bgordnung_bestellen/2018-05-25_Usage_regulations_GESIS_DAS.pdf).
After the registration, save your credentials using the package function
`gesis_credentials`. This package relies on the
[keyring](https://github.com/r-lib/keyring) package to store and
retrieve credentials. To download data use `gesis_download_data`.

### Example

To download the first Eurobarometer data file [(ZA0078: Attitudes
towards Europe, 1962)](https://doi.org/10.4232/1.10850) use

``` r
gesis_download_data(
    za="ZA0078", 
    purpose="scientific_research")
```

The function saves the dta file in the working directory by default. To
switch the file type, use the `type` argument. To define the file name
and file path, use `file`. To load the dta file, use the package
[`haven`](https://github.com/tidyverse/haven).

### Similar and Complementary Packages

-   This package has simliar functionality the R package `gesis`
    [github.com/expersso/gesis](https://github.com/expersso/gesis) which
    is unmaintained and not working as GESIS changed the login and data
    retrieval API

-   This package is different from the R package `gesisdata`
    [github.com/fsolt/gesisdata](https://github.com/fsolt/gesisdata)
    which uses web browser automation via `RSelenium`
    [github.com/ropensci/RSelenium](https://github.com/ropensci/RSelenium/)
    to download data from GESIS
