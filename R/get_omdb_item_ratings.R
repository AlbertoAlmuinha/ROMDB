#' @title Get OMDB Item Ratings
#' @name get_omdb_item_ratings
#' @description This function searches Item Ratings.
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' Return a tibble with the movie/series ratings.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item_ratings(odmb_id = 'tt0120338')
#' }

get_omdb_item_ratings<-function(omdb_id, API_KEY = Sys.getenv('API_KEY')){

  url<-str_glue("http://www.omdbapi.com/?apikey={API_KEY}")

  res<-RETRY('GET', url = url,
             query = list(i = omdb_id,
                          r = 'json'
             ),
             quiet = TRUE) %>% content

  get_request_status(res)

  ratings<-res$Ratings

  if (length(ratings)==0){stop(str_glue("The item searched hasn't ratings."))}

  rats<-map_df(seq(length(ratings)), function(x){

    tibble(Source = ratings[[x]]$Source,
           Value = ratings[[x]]$Value)})

  return(rats)

}
