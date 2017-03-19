
#' @export
discoverONS <- function(){
  
  domain <- "http://data.ons.gov.uk/ons/api/data/"  # Beginning of the url
  apikey <- onsApikey()                             
  
  url <- paste(domain,
               "?apikey=", ApiKey,
               sep = "")

  doc      <- rsdmx::xmlParse(url)
  doc_data <- rsdmx::xmlToList(doc)
  doc_data
  
  #TODO: present list in a human readable way.
  
}

  
## Function to retrieve data
readONS <- function(path="",
                    context="",
                    geo=""){

	Domain = "http://data.ons.gov.uk/ons/api/data/"	# Beginning of the url
	Path = Path					                            #
	Representation = "xml"	                        # Type of file (xml, json, csv...)
	ApiKey = readONSapikey()	                      # API Key, as provided by ONS
	QueryContext = QueryContext                     # Census, Socio-Economic, Economic, Social
	QueryGeography = QueryGeography                 # Geographic filter (?geog=<hierarchy name>)
	QuerySlicing = ""					                      # Dimension filter (?dm=/<dimension>=<value>)
	QueryPaging = ""					                      # Paging filter

  # The API's URLs consists of the following parts:
  # http://[domain]/[context root]/[resource].[representation]?[query string]
  
  # TODO: implement slicing and paging
	url <- paste(Domain, Context, Path, "/set.", Representation,
			   "?context=", QueryContext,
         "&geog=", QueryGeography,
			   "&apikey=", ApiKey,
			   sep = "")

  # TODO: control for errors (i.e. too many rows retrieved)
  doc <- rsdmx::readSDMX(url)
  
}