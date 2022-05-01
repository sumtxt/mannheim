#' Get a data set from GESIS 
#'
#' \code{gesis_download_data} downloads data from the GESIS data repository. 
#'
#' @param za the study number (starts with "ZA")
#' @param purpose select a purpose for the download (see details)
#' @param file file (and path) to use for storage (detault: [za].[type])
#' @param type file type to download (default: STATA dta)
#' @param print print summary of server response (default) or return response object?
#'
#' @details 
#'
#' You need to define a purpose for downloading a data set. The options accepted by the 
#' the GESIS API are as follows:
#'
#' \itemize{
#'  \item scientific_research: for scientific research (incl. doctorate)
#'  \item commercial_research: for research with commercial mandate
#'  \item lecturer: in a course as lecturer
#'  \item final_thesis: for final thesis of the study programme (e.g. Bachelor/Master thesis)
#'  \item further_education: for further education and qualification
#'  \item non_scientific: for non-scientific purposes
#'  \item studies: in the course of my studies
#' }
#'
#' File options vary across studies. Typically, studies are available as 
#' por, dta, sps, sav file. 
#' 
#'
#' @return only returns httr response object if \code{print=FALSE}. 
#'
#'
#' @examples 
#' 
#' \dontrun{
#' Download ZA0078: Attitudes towards Europe, 1962
#' gesis_download_data(za="ZA0078", purpose="scientific_research")
#' }
#' 
#' 
#' 
#' @import httr 
#' @export
gesis_download_data <- function(za,purpose,file=NULL,type='dta', print=TRUE){

	if(is.null(file)){
		file <- paste0(za,".",type)
	}

	download_id <- gesis_get_download_id(za=za,type=type)	
	token <- gesis_login()

	url <- "https://dbk.gesis.org/dbksearch/download-secure"

	param <- list(
		id=download_id, 
		download_purpose=purpose
		)

	m <- GET(url, write_disk(file, overwrite=TRUE),
		query=param, 
		accept("*/*"), 
		content_type("application/x-www-form-urlencoded"),
		add_headers("Authorization"=paste("Bearer", token)) )
	
	if(print==TRUE){	
		print(m)
		cat("\n")
	} else {
		return(m)
	}

	}

