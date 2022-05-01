#' Saves GESIS credentials 
#'
#' \code{save_credentials} saves a set of GESIS credentials using the \code{keyring} package. 
#'
#' @param user your user name. 
#' @param password your password. 
#'   
#' @details  
#'  User/password are stored in Keychain on macOS, Credential Store on Windows or Secret Service API on Linux. 
#'  If a user/password pair for a database already exists, it is silently replaced with the new pair.  
#'  This function relies on the \code{\link{keyring}}  package. 
#' 
#' @seealso \code{\link{keyring}} 
#'
#' @examples 
#' 
#'  \dontrun{
#'  gesis_credentials(
#' 		user="stein.rokkan@sowi.uni-mannheim.de", 
#' 		password="comparativepolitics")
#'  }
#' 
#' 
#' @importFrom keyring key_set_with_value key_list key_get
#' @export
gesis_credentials <- function(user, password){
	key_set_with_value("gesis", username=user, password=password)
	message("Successfully added credentials.")
	}