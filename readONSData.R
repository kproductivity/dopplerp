## Functions to read data from ONS through its API
## by Francisco Marco-Serrano, 2014


## Function to retrieve the APIKEY
readONSapikey <- function(){
  
  if(file.exists("onsapi.key") == TRUE){      # if apikey is already recorded
    apikey = read.csv("onsapi.key",
                         header = FALSE)      # read it
  } else {                                    # otherwise,
    apikey = readline("Api key:")             # ask for it
    write.csv(apikey, "onsapi.key",
              row.names = FALSE)              # and write it in the file
  }
  
  apikey[2,1]

}


## Function to retrieve data
readONSData <- function(Path="QS201EW",
                        QueryContext="Census",
                        QueryGeography="2011PCONH"){

	Domain = "http://data.ons.gov.uk/ons/api"	# Beginning of the url
	Context = "/data/dataset/"      				  # Request dataset
	Path = Path					                      #
	Representation = "xml"	                  # Type of file (xml, json, csv...)
	ApiKey = readONSapikey()	                # API Key, as provided by ONS
	QueryContext = QueryContext               # Census, Socio-Economic, Economic, Social
	QueryGeography = QueryGeography           # Geographic filter (?geog=<hierarchy name>)
	QuerySlicing = ""					                # Dimension filter (?dm=/<dimension>=<value>)
	QueryPaging = ""					                # Paging filter


  # TODO: implement slicing and paging
	url <- paste(Domain, Context, Path, "/set.", Representation,
			   "?context=", QueryContext,
         "&geog=", QueryGeography,
			   "&apikey=", ApiKey,
			   sep = "")

	print(url)						                    # Only for debugging

  require(rsdmx)

  # TODO: control for errors (i.e. too many rows retrieved)
  doc <- readSDMX(url)
  doc
  
}