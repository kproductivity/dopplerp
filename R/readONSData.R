# Retrieve the OpenAPI from ONS
getONSapi <- function(){
  url <- "https://developer.ons.gov.uk/swagger.json"
  api <- rapiclient::get_api(url)
  
  schemas    <- rapiclient::get_schemas(api)
  operations <- rapiclient::get_operations(api, handle_response = rapiclient::content_or_stop)
  
  theApi <- list("schemas" = schemas, "operations" = operations)
  return(theApi)
}


#' Discover datasets provided by ONS through its API
#'
#' @param start: double
#'
#' @export
discoverONS <- function(start = 0, theApi = getONSapi()){

  if (!is.null(start) && start < 0) {
    stop("Invalid parameter: 'start' must be a positive value!")
  }

  if (is.null(theApi)){
    theApi <- getONSapi()
  }

  doc_df <- theApi$operations$Listing_of_datasets(start = start, limit = 100L)
  
  if (doc_df$status_code == 200){
    #TODO get data
    df <- lapply(doc_df$items, function(record) data.frame(url = record$uri)) %>% bind_rows
  }else{
    stop("Error: didn't retrieve any data!")
  }
  
  return(df)
}


#' Retrieve data from ONS
#'
#'
#' @export
readONS <- function(){

}
