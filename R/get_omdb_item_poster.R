#' @title Get OMDB Item Poster
#' @name get_omdb_item_poster
#' @description This function searches Item Poster.
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' Return an image with the movie/series poster.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item_poster(omdb_id = 'tt0120338')
#' }

get_omdb_item_poster<-function(omdb_id, API_KEY = Sys.getenv('API_KEY')){

  res<-RETRY('GET', url = url,
             query = list(i = omdb_id,
                          r = 'json'
             ),
             quiet = TRUE) %>% content

  get_request_status(res)

  poster<-res$Poster

  if (length(poster)==0){stop(str_glue("The item searched hasn't poster."))}

  image1<-image_read(poster)

  plot(image1)

  return(list(poster = poster, image = image1))

}
