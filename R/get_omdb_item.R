#' @title Get OMDB Item
#' @name get_omdb_item
#' @description This function searches OMDB Movies/Series by ID.
#' @author Alberto Almuiña
#' @param omdb_id String with the omdb_id for a movie/series.
#' @param include_image If TRUE, the result includes an image of the movie/series. Default: TRUE.
#' @param API_KEY OMBD Api Key. Default: Get the Api Key from system environment. Use Sys.setenv('API_KEY' = 'XXXXX'). More information in: http://www.omdbapi.com/apikey.aspx
#' @return
#' If include_image is TRUE, returns a list with a tibble with the movie information and a image of the film. If include_image is FALSE, only returns the tibble.
#' @export
#' @examples
#' \dontrun{
#' get_omdb_item('tt0120338')
#' }

get_omdb_item<-function(omdb_id, include_image = TRUE, API_KEY = Sys.getenv('API_KEY')){

  url<-str_glue("http://www.omdbapi.com/?apikey={API_KEY}")

  res<-RETRY('GET', url = url,
             query = list(i = omdb_id,
                          r = 'json'
             ),
             quiet = TRUE) %>% content

  get_request_status(res)

  info<-switch(res$Type,
               movie = tibble(

                 title = res$Title,
                 year = res$Year,
                 rated = res$Rated,
                 released = res$Released,
                 runtime = res$Runtime,
                 genre = res$Genre,
                 director = res$Director,
                 writer = res$Writer,
                 actors = res$Actors,
                 plot = res$Plot,
                 language = res$Language,
                 country = res$Country,
                 awards = res$Awards,
                 poster = res$Poster,
                 metascore = res$Metascore,
                 imdbRating = res$imdbRating,
                 imdbVotes = res$imdbVotes,
                 imdbID = res$imdbID,
                 type = res$Type,
                 DVD = res$DVD,
                 boxoffice = res$BoxOffice,
                 production = res$Production,
                 website = res$Website

               ),

               series = tibble(

                 title = res$Title,
                 year = res$Year,
                 rated = res$Rated,
                 released = res$Released,
                 runtime = res$Runtime,
                 genre = res$Genre,
                 director = res$Director,
                 writer = res$Writer,
                 actors = res$Actors,
                 plot = res$Plot,
                 language = res$Language,
                 country = res$Country,
                 awards = res$Awards,
                 poster = res$Poster,
                 metascore = res$Metascore,
                 imdbRating = res$imdbRating,
                 imdbVotes = res$imdbVotes,
                 imdbID = res$imdbID,
                 type = res$Type,
                 total_seasons = res$totalSeasons

               )

  )

  if(include_image){

    photo<-image_read(info$poster[info$poster != 'N/A'])

    return(list(odmb_df = info, image = photo))

  } else {

    return(info)

  }

}
