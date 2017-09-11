# # Discover datasets provided by ONS through its API
# # 
# # @param context: char,  indicates in which context to start the discovery, either: \code{Census},
# # \code{Socio-Economic}, \code{Economic}, or \code{Social}. If \code{NULL} it starts showing the 
# # available contexts.
# # 
# # @export
# discoverONS <- function(context=NULL){
# 
#   if (!is.null(context) && !context %in% c('Census', 'Socio-Economic', 'Economic', 'Social')) {
#     stop("Invalid parameter: 'context' must be 'Census', Socio-Economic', 'Economic', or 'Social'!")
#   }
# 
#   domain <- "http://web.ons.gov.uk/ons/api/data/"  # Beginning of the url
#   url    <- paste0(domain, '.xml?apikey=', onsApikey())
# 
#   if (!is.null(context)) {
#     url <- paste0(url, '&context=', context)
#   }
# 
#   doc      <- XML::xmlTreeParse(url, useInternalNodes = TRUE)
#   doc_list <- XML::xmlToList(doc)
# 
#   if(is.null(context)) {
#     doc_df <- doc_list$contextList
#     df     <- plyr::ldply(doc_df, data.frame)[,-1]
#   } else {
#     doc_df <- doc_list$linkedNodes
#     df     <- plyr::ldply(doc_df, data.frame)[, c("name", "urls.url.href")]
#   }
# 
#   return(df)
# }
# 
# 
# # Retrieve data from ONS
# #
# # @param path: char
# # @param context: char,  indicates in which context to start the discovery, either: \code{Census},
# # \code{Socio-Economic}, \code{Economic}, or \code{Social}. If \code{NULL} it starts showing the
# # available contexts.
# # @param geo: char
# #
# # @export
# readONS <- function(path="",
#                     context="",
#                     geo=""){
# 
# 	Domain = "http://data.ons.gov.uk/ons/api/data/"	# Beginning of the url
# 	Path = path					                            #
# 	Representation = "xml"	                        # Type of file (xml, json, csv...)
# 	ApiKey = readONSapikey()	                      # API Key, as provided by ONS
# 	QueryContext = context                          # Census, Socio-Economic, Economic, Social
# 	QueryGeography = geo                            # Geographic filter (?geog=<hierarchy name>)
# 	QuerySlicing = ""					                      # Dimension filter (?dm=/<dimension>=<value>)
# 	QueryPaging = ""					                      # Paging filter
# 
#   # The API's URLs consists of the following parts:
#   # http://[domain]/[context root]/[resource].[representation]?[query string]
# 
#   # TODO: implement slicing and paging
# 	url <- paste(Domain, Context, Path, "/set.", Representation,
# 			   "?context=", QueryContext,
#          "&geog=", QueryGeography,
# 			   "&apikey=", ApiKey,
# 			   sep = "")
# 
#   # TODO: control for errors (i.e. too many rows retrieved)
#   doc <- rsdmx::readSDMX(url)
# 
#   return(doc)
# }