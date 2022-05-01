# ToDo: a new authentification token is created for every file download. Rewrite to use the same token until it is expired. 
gesis_login <- function(){

	keys <- gesis_keys()

	url <- "https://login.gesis.org/realms/gesis/protocol/openid-connect/token"

	param <- list(
		scope="openid", 
		response_type="code",
		client_id="js-login",
		grant_type="password",
		username=keys[["user"]], 
		password=keys[["password"]]
	)

	cred <- POST(url, body=param, encode = "form")
	token <- content(cred)$access_token
	if(is.null(token)){
		stop("Login failed. No token found.")
		print(cred)
	}
	return()
	}

gesis_keys <- function(){
	gesis <- c()
	gesis["user"] <- as.character(key_list(service="gesis")['username'])
	gesis["password"] <- as.character(key_get(service="gesis", username=gesis["user"]))
	if( is.na(gesis["user"]) | is.na(gesis["password"]) ){
		stop("Credentials couldn't be loaded. Consider adding them using gesis_credentials.")
	}
	return(gesis)
	}


gesis_search_dbk <- function(za){
	za <- toupper(za)
	if( !grepl("^ZA", za)  ) {
		za <- paste0("ZA",za)
	}
	url <- "https://search.gesis.org/searchengine"
	json <- GET(url, query=list("q"=paste0("_id:",za)))
	json <- content(json)
	
	if( json$hits$total!=1 ){
		stop(paste(za, "doesn't identify a (retrievable) study in the data archive."))
	}
	return(json)
	}

# ToDo Display available formats if fails 
gesis_get_download_id <- function(za,type){
	json <- gesis_search_dbk(za)
	lst <- json$hits$hits[[1]]$`_source`$links_dataset
	for(l in lst){
		has_dta <- grepl( paste0("\\.",type), unlist(l$label_en))
			if( has_dta==TRUE ){
				return( parse_url(l$url)$query$id ) 
			}		
	}	
	stop( paste("The file format", type, "is not available for this study.") )
	}
