#'GEDI finder
#'
#'@description This function finds the path to GEDI data within a boundary box coordinates provided
#'
#'#'@usage gedifinder(level="GEDI02_B",xmin,xmax,ymin,ymax)
#'
#'@param level GEDI data level; Options: "GEDI01_B", "GEDI02_A" or "GEDI02_B"
#'@param ul_lat Numeric. Upper left (ul) corner coordinates, in lat (decimal degrees) for the bounding box of the area of interest.
#'@param ul_lon Numeric. Upper left (ul) corner coordinates, in lon (decimal degrees) for the bounding box of the area of interest.
#'@param lr_lat Numeric. Lower right (ul) corner coordinates, in lat (decimal degrees) for the bounding box of the area of interest.
#'@param lr_lon Numeric. Lower right (ul) corner coordinates, in lon (decimal degrees) for the bounding box of the area of interest.
#'
#'@return Vector object pointing out the path saving the downloaded GEDI data within
#'the boundary box coordinates provided
#'@seealso bbox: The correct format is upper left and lower right corner coordinates, in lat,lon ordering, for the bounding box of the area of interest (e.g. [ul_lat,ul_lon,lr_lat,lr_lon]).
#'This function just call the gedifinder tool developted by LPDAAC:
#'https://lpdaacsvc.cr.usgs.gov/services/gedifinder
#'
#'@examples
#'# Specifying bounding box coordinates
#'ul_lat<- 42.0
#'ul_lon<- -100
#'lr_lat<- 40.0
#'lr_lon<- -96.0
#'
#'# Extracting the path to GEDI data for the specified boundary box coordinates
#'gedi02b_list<-gedifinder(level="GEDI02_B",ul_lat, ul_lon, lr_lat, lr_lon)
#'@export
gedifinder<-function(level, ul_lat, ul_lon, lr_lat, lr_lon){
  response = httr::GET(paste0("https://lpdaacsvc.cr.usgs.gov/services/gedifinder?product=",level,"&version=001&bbox=",ul_lat,",",ul_lon,",",lr_lat,",",lr_lon,"&output=html"))
  content = httr::content(response, "text")
  links = gsub(".*a href=([^>]*).*", "\\1", strsplit(content,"<br/>")[[1]])
  return(links)
}


