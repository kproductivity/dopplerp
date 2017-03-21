# Private function to read the API key
#
onsApikey <- function() {
  apikey <- Sys.getenv('ONS_APIKEY')
  if (identical(apikey, "")) {
    stop("Please set env var ONS_APIKEY to your ONS API key!",
         call. = FALSE)
  }
  
  return(apikey)
}

#' Set your ONS API key in the system
#' 
#' @export
setOnsApikey <- function(apikey) {
  
  if (is.null(apikey)) {
    stop("Please provide an API key", call. = FALSE)
  }
  Sys.setenv(ONS_APIKEY = apikey)
}


