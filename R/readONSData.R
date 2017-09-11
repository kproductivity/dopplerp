# Retrieve the OpenAPI from ONS
GetONSapi <- function(){
  url <- "https://developer.ons.gov.uk/swagger.json"
  api <- rapiclient::get_api(url)
  
  schemas    <- rapiclient::get_schemas(api)
  operations <- rapiclient::get_operations(api, handle_response = content_or_stop)
  
  theApi <- list("schemas" = schemas, "operations" = operations)
  return(theApi)
}


#' Discover datasets provided by ONS through its API
#'
#' @param start: double
#'
#' @export
DiscoverONS <- function(start = 0, theApi = GetONSapi()){

  if (!is.null(start) && start < 0) {
    stop("Invalid parameter: 'start' must be a positive value!")
  }

  if (is.null(theApi)){
    theApi <- GetONSapi()
  }

  doc_df <- theApi$operations$Listing_of_datasets()
  
  if (doc_df$status_code == 200){
    #TODO get data
    df <- NULL
  }else{
    stop("Error: didn't retrieve any data!")
  }
  
  return(df)
}


#' Retrieve data from ONS
#'
#'
#' @export
ReadONS <- function(){

}
